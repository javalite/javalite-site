<div class="page-header">
   <h1>Record creation</h1>
</div>



There are many ways to create new records with ActiveJDBC. Let's explore them

## Use setter method

~~~~ {.java .numberLines}
Person p = new Person();
p.set("first_name", "John");
p.set("last_name", "Doe");
p.set("dob", "1935-12-06");
p.saveIt();
~~~~

This code should be self explanatory. As you can see, ActiveJDBC does not require to have getters and setters. You can write them, if you like, but IMHO, they are nothing but code pollution.

## save() and saveIt() methods

ActiveJDBC class Model provides two methods for saving an entity: `save()` and `saveIt()`. Both methods will involve validations during saving, but in the case of the method save() will silently exit without throwing exceptions. In case validations failed, the instance will have an errors collection attached to it. This is very useful in the context of a web application. Here is an example:

~~~~ {.java  .numberLines}
Person person = new Person();
person.fromMap(requestParams);
if(person.save()) //<<<===  will not throw exception and will not save in case there are validation errors. 
    //show page success
else{
     request.setAttribute("errors", person.errors());
     //show errors page, or same page so that user can correct errors.
}
~~~~

More on validations , see this page: [Validations](validations)

The `saveIt()` method will throw an exception in case there was a validation problem. The `save()` method makes more sense in the context of a web application, whereas `saveIt()` is more useful in a non-web app situations - batch inserts, tests, etc.

## Method chaining

The `set(name, value)` method returns reference to the same model object, which makes it possible to string method calls like this:

~~~~ {.java  .numberLines}
Person p = new Person();
p.set("name", "John").set("last_name", "Doe").set("dob", "1935-12-06").saveIt();
~~~~

..or make it shorter:

~~~~ {.java  .numberLines}
new Person().set("first_name", "Marilyn").set("last_name", "Monroe").set("dob", "1935-12-06").saveIt();
~~~~

## Batching names an values

There is a way to batch names and values into arrays:

~~~~ {.java  .numberLines}
String[] names = {"first_name", "last_name", "dob"};
Object[] values = {"John", "Doe", dob}
new Person().set(names, values).saveIt();
~~~~

Of course, the names is a String array and the two arrays need to be the same size.

## Initialize from Map

This method of creation is useful for web applications if request parameters are posted from a form an available in a Map instance:

~~~~ {.java  .numberLines}
Map values = ... initialize map
Person p = new Person();
p.fromMap(values);
p.saveIt();
~~~~

## Initialize from varargs

Model also provides another convenience method for entity initialization, the set methods that accepts a varargs:

~~~~ {.java  .numberLines}
Person p = new Person();
p.set("first_name", "Sam", "last_name", "Margulis", "dob", "2001-01-07");
p.saveIt();
~~~~

The argument list is a string of names and corresponding values where names are interleaved with values. This makes it easy to write allows for easy reading (if you just read it aloud, it will sound as an English sentence).

## Convenience create() and createIt() methods

The class Model also provides two convenience methods for creation of records: `create()` and `createIt()`. There is a semantic difference between these two methods, and it is the same as between `save()` and `saveIt()` methods, except in this case, ActiveJDBC creates and attempts to save an object in one step.

~~~~ {.java  .numberLines}
Person p = Person.create("first_name", "Sam", "last_name", "Margulis", "dob", "2001-01-07");
p.saveIt();
~~~~

or:

~~~~ {.java  .numberLines}
Person p = Person.createIt("first_name", "Sam", "last_name", "Margulis", "dob", "2001-01-07");
~~~~

The `create()` and `createIt()` method accepts a list of arguments, where names are interleaved with values. This is similar to the varargs setter described above, but also includes semantics of the `save()` and `saveIt()` methods.

## No setters/getters???

Please, see [Setters and getters](setters_and_getters)
