<div class="page-header">
   <h1>Web Requests: Implicit Conversion</h1>
</div>

> This feature is available starting with v2.4 for Java 8 and v3.0 for Java 11 and up.
> Also available in current snapshots: 2.3.3-j8-SNAPSHOT and 3.0-SNAPSHOT.  



While many commercial projects were built by just [reading dynamic parameters](processing-web-requests-dynamic-parameters),
there is a more advanced set of features to process the   

## Implicit conversion with a POJO


Controller action classes can take  a single argument, such that this argument has private members that match the request properties. 

For instance,  you may have a controller that looks looks like this: 

~~~~ {.java  .numberLines}
public class Person {
    private String  firstName, lastName;
    private int yearOfBirth = -1;
    private boolean married = false;
    public String toString(){ return "First name: " + firstName + ", last name: " + lastName + ", married: " + married; }
}
~~~~

As you can see, this is not a typical bean (it could be if you want though) and does not necessary  have getters  and setters. 
This class can be used as an argument to an action method of a class. You may want to add getters sop you can  read values in your controller.  

For example, if you have a form: 

~~~~ {.html .numberLines}
<@form controller="people" action="add" method="POST"> 
  <input type="text" name="first_name"/>
  <input type="text" name="last_name"/>
  <input type="text" name="married"/>
  <input type="submit"/>
</@form>
~~~~

and a corresponding controller: 

~~~~{.java .numberLines}
public class PeopleController extends AppController {
    @POST
    public void add(Person person){
        logInfo(person);
    }
}
~~~~

Then ActiveWeb will detect the fact that the action  has an argument and will automatically: 

1. Create a  new instance of `Person`,
2. Translate names of the HTTP request  parameters in the underscore format to Java camelCase format   
3. Fill the members of the new instance with corresponding  values 
4. Will perform an implicit conversion  of types.   

Continue reading for more details.


## Parameter name translation  

The name  translation assumes that: 

1. Request parameter names have an underscore format
2. Java class used as an argument uses a standard camel case format for members, starting with lower case

Examples: 

Parameter name             Java class member name 
-------------------        -------------------------------
first_name                 firstName           
last_name                  lastName


> If there is no exact name matching after translation, the input parameter is ignored by the matching process, but the value 
can still be accessed, see  [Dynamic parameter access](#dynamic-parameter-access)


Form input names are underscore, but the argument class fields (as in `Person` above) are a classic camelCase 


## Dynamic parameter access

Even if your action method accepts a value argument, you can still access all request parameters as  described in 
[Processing web requests with dynamic parameters](processing-web-requests-dynamic-parameters): 

~~~~{.java .numberLines}
public class PeopleController extends AppController {
    @POST
    public void add(Person person){
        logInfo(person);
        Map params = params1st();
        ...
    }
}
~~~~

All request parameters are accessible dynamically, regardless if they matched to an argument class or not. 
 


## Implicit conversion (for simple Java classes)

If you did  not use an explicit validation system as described below, the framework offers an implicit validation of types.

For instance, in the example above, the `Person.married` member is type `boolean`, and the type of the incoming parameter 
will be converted to the target type automatically with a help of a [Convert](http://javalite.github.io/2.3.2-j8/org/javalite/common/Convert.html) class.

As a resulrt, the parameter `married` could have one of these values to be true: 

* 1 
* t
* y
* true
* yes


Currently, the following types are supported for implicit  conversion: 

* Integer
* Double
* Float
* Boolean
* String

as well as their literal counterparts.  


## A conversion exception


If the request parameters  can be converted to the  corresponding types, than will just happen.
 
If however the conversion is impossible, such that you try to convert `"blah"` to an `Integer`, 
then you will get a `org.javalite.common.ConversionException`. 

This exception gets thrown during the conversion phase, which means it will happen _before_  execution is passed to your controller. 
The framework will simply display [a system error page](/views#system-error-pages).  

In order to catch and gracefully process such exceptions, you will need to add a [controller filter](controller_filters) and catch that (and other exceptions):

~~~~{.java .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
    public void init(AppContext appContext) {
        add(new CatchAllFilter());
    }
} 
~~~~

and then implement:

~~~~{.java .numberLines}
public class CatchAllFilter extends HttpSupportFilter {
    public void onException(Exception e) {
    logError(e.toString(), e);
        if(e instanceof org.javalite.common.ConversionException.class){
            //TODO: implement here. 
        }else{
              render("/system/error", Collections.map("message", "Apologies for inconvenience");
        }
    }
} 
~~~~


TODO: fill out below:


## Implicit conversion with JSON 

A current implementation supports a **single level JSON document posted to the controller**, 
in addition to submitting standard forms or parameters. 

For instance,  if you  post a document like this: 

~~~~ {.javascript .numberLines}
{
    "first_name": "John",
    "last_name": "Doe"
}
~~~~

and  ensure that  your `Content-type` header is equal `application/json`, then the framework will behave in the 
exact  same manner as in case of a [regular form submission](#implicit-conversion-with-a-pojo). 


In other words, if you have a value class `Person` as described above, it does not matter if you are sending a request as a JSON 
object or as a simple form. 

> The real difference though it that in case of a simple request, you can  use an HTTP GET method, but in case of a JSON 
object,  you must use POST, PUT, etc.  
  

## Parameter matching 

ActiveWeb will do its best to match the parameters of a request  (or fields of a submitted JSON document) to an argument 
type of an action method. The submitted parameters that do  not match the Java type as described in 
[parameter name translation](#parameter-name-translation) section will simply be ignored. 

For instance, if you are submitting a form: 

~~~~ {.html .numberLines}
<@form controller="people" action="add" method="POST"> 
  <input type="text" name="first_name"/>
  <input type="text" name="middle_name"/>
</@form>
~~~~

to an action with the argument of this type: 

~~~~ {.java  .numberLines}
public class Person {
    private String  firstName, lastName;
}
~~~~

Then, the `middle_name` and `lastName` will be ignored. There will be no log statement or any other output. It is
a responsibility  of a developer to ensure that input data matches the argument type. 
 

Read next: [processing web requests with validation](processing_web_requests_with_validation).



