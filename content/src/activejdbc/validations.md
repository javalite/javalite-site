<div class="page-header">
   <h1>Validations</h1>
</div>



ActiveJDBC has a validation framework that is somewhat reminiscent of ActiveRecord validation.
The validation rules in ActiveJDBC are described in a model definition in a declarative way.

## Validation of attribute presence

In order to add any validation, a model will declare a static bloc at the top of a class definition, and invoke all
validation declaration inside this block:

~~~~ {.java  .numberLines}
public class Person extends Model {
    static{
        validatePresenceOf("first_name", "last_name");
    }    
}
~~~~

The method `Model.validatePresenceOf()` takes a vararg of strings, which allows to specify a list of attribute names
(column names) in one line of code.

## Triggering of validation

triggering of validations causes these actions:

-   Call `Model.validate()` method (will not throw exception)
-   Call `Model.save()` method (will not throw exception)
-   Call `Model.saveIt()` method (will throw exception)
-   Call `Model.createIt()` method (will throw exception)

The semantic difference of `save()` and `saveIt()` methods is described on the [Record creation](record_creation) page.

## Consuming validation messages

After the validation triggered, you can retrieve all messages from a model as a collection:

~~~~ {.java  .numberLines}
//...trigger validation

Map<String, String> errors = myPerson.errors();
String firstNameError = errors.get("first_name");
~~~~

As you can imagine, it is very easy to write web applications with form validation using this ActiveJDBC.

## Usage in a web application

This is a pseudo-code of a web application controller where a form was submitted:

~~~~ {.java  .numberLines}

public void doPost(...){
   Map params = ... // this is a map of HTML form submitted from a web page
   Person p = Person();
   p.fromMap(params); //The model will only pluck values that correspond to it's attribute names
   
   if(p.save()){
      //render success page
   }else{
      request.setAttribute("errors", p.errors());
      getServletContext().getRequestDispatcher("/results.jsp").forward(request,response);
   }
}
~~~~

In a JSP:

~~~~ {.html  .numberLines}

<span style="error">${errors.first_name}</span>
...
<span style="error">${errors.last_name}</span>
...
~~~~

In [ActiveWeb](activeweb):

~~~~ {.java  .numberLines}
@POST
public void create(){
    Book book = new Book();
    book.fromMap(params1st());
    if(!book.save()){
        flash("message", "Something went wrong, please  fill out all fields");
        flash("errors", book.errors());
        flash("params", params1st());
        redirect(BooksController.class, "new_form");
    }else{
        flash("message", "New book was added: " + book.get("title"));
        redirect(BooksController.class);
    }
}
~~~~

Here is a link to controller: [ActiveWeb BookController](https://github.com/javalite/activeweb-simple/blob/master/src/main/java/app/controllers/BooksController.java#L45)

## Customized messages for different attributes

You can call method `validatePresenceOf().message()` multiple times, providing different attribute names as well
as different messages:

~~~~ {.java  .numberLines}
public class Person extends Model {
    static{
        validatePresenceOf("first_name").message("Please, provide your first name");
        validatePresenceOf("last_name").message("Please, provide your last name");
    }    
}
~~~~

## Validation of numericality

ActiveJDBC like ActiveRecord also provides other validators, for instance:

~~~~ {.java  .numberLines}
public class Account extends Model {
    static{
        validateNumericalityOf("amount", "account", "total");
    }
}
~~~~

Like the `validatePresenseOf()`, this method also takes in a vararg of strings, which allows to specify a list of attribute names that should have a numeric format.

## Validation of numericality with additional properties

When checking numericality of an attribute, you can have a finer control, including specifying that it could be `null`, providing a range and a custom message. In fact, all validators allow for custom message.

~~~~ {.java  .numberLines}
public class Account extends Model {
    static{
        validateNumericalityOf("total")
                .allowNull(true).greaterThan(0)
                .lessThan(100).onlyInteger()
                .message("incorrect 'total'");
    }
}
~~~~

Again, ActiveJDBC is using [Fluent Interfaces](http://martinfowler.com/bliki/FluentInterface.html) technique,
as in many other places.

## Range validator

Besides numeric validation, there is also a specific range validator:

~~~~ {.java  .numberLines}
public class Temperature extends Model {
    static{
        int min = 0, max = 100;
        validateRange("temp", min, max).message("temperature cannot be less than " + min + " or more than " + max);
    }
}
~~~~

Although you can use either numeric or range validators for range, in some cases range validator will have a
more concise syntax than numeric one.

## Email validator

The email validator exists to check a proper format of email (it does not check if email actually exists!)

~~~~ {.java  .numberLines}
public class User extends Model {
    static{
        validateEmailOf("email");
    }
}
~~~~

## Regular expressions validator

You can probably guess, that the email validator is a special case of a regular expression validator:

~~~~ {.java  .numberLines}
public class User extends Model {
    static{
        validateRegexpOf("email", "\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b");
    }
}
~~~~

This validator provides enough freedom to developers who know regular expressions well :)

## Custom validators

If all else fails, and ActiveJDBC does not provide a validator you want, you can extend a ValidatorAdapter class:

~~~~ {.java  .numberLines}
public interface Validator {
    void validate(Model m);
    void setMessage(String message);
    String formatMessage(Locale locale, Object ... params);
}
~~~~

or better yet, [ValidatorAdapter](http://javalite.github.io/activejdbc/snapshot/org/javalite/activejdbc/validation/ValidatorAdapter.html):

~~~~ {.java  .numberLines}
public class CustomValidator extends ValidatorAdapter{
   void validate(Model m){
       boolean valid = true;
      //perform whatever validation logic, then add errors to model if validation did not pass:
      if(!valid)
         m.addValidator(this, "custom_error");
    }
}
~~~~

Once you have a custom validation, you can register it with a model like this:

~~~~ {.java  .numberLines}
public class Person extends Model{
   static{
      validateWith(new CustomValidator()).message("custom.message");
   }
}
~~~~

Another way to register is outside your model class:

~~~~ {.java  .numberLines}
CustomValidator cv = new CustomValidator();
Person.addValidator(cv).message("blah, blah");
~~~~

after a validation, you can retrieve an error like this:

~~~~ {.java  .numberLines}
Person p = ...
p.save();
String errorMessage = p.errors().get("custom_error");
~~~~

Validators are executed during validation in the order they were added to the model. The `validate()` method is
called from `save()` and `saveIt()`

## Customization of messages

ActiveJDBC provides stock messages (one for each validator), which may not be appropriate for all projects.
For instance, `validatePresenseOf()` provides a simple message "value is missing". In order to customize these messages,
the framework provides a DSL-ish like facility:

~~~~ {.java  .numberLines}
public class Person extends Model {
    static{
        validatePresenceOf("first_name", "last_name").message("name.missing");
    }    
}
~~~~

where `name.missing` is a key from a resource bundle `activejdbc_messages`.

After a validation process, if there are errors, they are accessible via the `p.errors()` method, and a specific validation error message is accessed using an attribute name as a message key:

~~~~ {.java  .numberLines}
String firstNameMissingErrorMessage = p.errors().get("first_name");
~~~~

..or you can use the `Errors` object returned from `errors()` method as a `Map` and process it generically (as is usually the case for web applications).

## Parametric validation messages

In some cases, you will need to parametrize messages coming from a resource bundle.
For instance, in a file `activejdbc_messages.properties` you would have an entry:

~~~~ {.prettyprint}
temperature.outside.limits = Temperature is outside acceptable limits, while it needs to be between {0} and {1}
~~~~

You might have a model defined like this:

~~~~ {.java  .numberLines}
public class Temperature extends Model{
   static{
      validateRange("temp", 10, 2000).message("temperature.outside.limits");
   }
}
~~~~

You will then create an instance of Temperature, set the values and validate in a code pattern similar to this;

~~~~ {.java  .numberLines}
Temperature temp = new Temperature();
temp.set("temp", 5000);

if(!temp.save()){
   String message = temp.errors().get("temp");
   System.out.println(message);// prints: Temperature is outside acceptable limits, while it needs to be between 10 and 2000
}
~~~~

## Split parameters for validation messages

In some cases you know parameter values when declaring a model, but some other parameters are only known in the
context where validation is actually used. In this case, you can split parameters between the declaration
(static context) and calling for messages (dynamic context).

Resource bundle:

~~~~ {.prettyprint}
temperature.outside.limits = Temperature is outside acceptable limits, while it needs to be between {0} and {1} for user: {2}
~~~~

Model definition:

~~~~ {.java  .numberLines}
public class Temperature extends Model{
   static{
      validateRange("temp", 10, 2000).message("temperature.outside.limits");
   }
}
~~~~

As you can see, the message calls for three parameters, but the validator can only set two. At the time of Model
definition, the user is not known. However, the user can be provided when the validation fails, and an application
calls for an error message:

~~~~ {.java  .numberLines}
Temperature temp = new Temperature();
temp.set("temp", 5000);

if(!temp.save()){
   String message = temp.errors().get("temp", user.getName());
   System.out.println(message);// prints: Temperature is outside acceptable limits, while it needs to be between 10 and 2000 for user: Tom
}
~~~~

The getter method for Errors class has this signature: `get(String attributeName, Object ... params)`, which allows to supply more than one parameter.

The one rule you have to keep in mind, is that static parameters will be indexed from zero, and dynamic parameters will be appended to static. As in this case, the user name is placed in the message at index {2}.

## Internationalization of validation messages (I18N)

In cases where there is a need for internationalization of messages, this is easy to accomplish by providing a locale
instance to the `errors()` method. But first, you will need to create these messages. ActiveJDBC uses a
resource bundle `activejdbc_messages`. This means:

-   `activejdbc_messages.properties` - default locale bundle
-   `activejdbc_messages_de_DE.properties` - German/Germany bundle
-   etc.

As usual in Java you will need to create a bundle for each locale. If you need a localized message during runtime,
all you need it to provide a locale to the `errors()` method of a model. Building on the example above with temperature,
the German local bundle file will have this:

~~~~ {.prettyprint}
temperature.outside.limits = Die Temperatur liegt außerhalb akzeptabler Grenzen, während es sein muss zwischen {0} und {1}
~~~~

At run time, the message will be printed in German if a locale provided is German:

~~~~ {.java  .numberLines}
Temperature temp = new Temperature();
temp.set("temp", 5000);

if(!temp.save()){
   String message = temp.errors(new Locale("de", "DE")).get(temp); //<<<=== provide locale
   System.out.println(message);// prints: Die Temperatur liegt außerhalb akzeptabler Grenzen, während es sein muss zwischen 10 und 2000
}
~~~~
