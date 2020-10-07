## Release notes v2.4-j8

### Supported Java

Built with Oracle JDK v 8.x. Should work with OpenJDK too.

The full release notes can be [found here](https://github.com/javalite/javalite/releases/tag/javalite-2.4-j8).

### Migration from previous versions

There might be small changes when you upgrade to v 2.4 


#### Validation package moved


This package:  `org.javalite.activejdbc.validation` was renamed `org.javalite.validation` and moved to dependency `javalite-common`. 
Your imports need to change from:   

```java
import org.javalite.activejdbc.validation.ValidationException;
```

to:
```java
import org.javalite.validation.ValidationException;
``` 


####  Conversion package moved

Conversion package moved to dependency `javalite-common` and is renamed: 
Old example: 

```java
import org.javalite.activejdbc.conversion.BlankToNullConverter;
```

new example:
```java
import org.javalite.conversion.BlankToNullConverter;
```


#### Validator interface changed a method signature 

Before:
```java
public interface Validator {
    void validate(Model model);
}
``` 

After:
```java
public interface Validator {
    void validate(Validatable validatable);
}
``` 

This means that if you are using custom validators: 
```java
public class MyCustomValidator extends ValidatorAdapter {
    public void validate(Model m) {
	//...
    }    
}
```

you have to cast if the validator expects a Model: 

```java
public class MyCustomValidator extends ValidatorAdapter {
    public void validate(Validatable validatable) {
        Model m = (Model) validatable;
	//...
    }
}

```


### Notable new features

#### [1044](https://github.com/javalite/javalite/issues/1044) - Async: Add support for scheduled delivery time.

Allows to send commands using Async not necessarily immediately, but with a delay in milliseconds after sending.

In short, this is a new  method that was added to the `Async` class: 

```java
async.send(QUEUE_NAME, new HelloCommand("Hello " + i), requiredTime);
```

The `requiredTime` is some time in the future, and the message will be delivered at  that time. As usual, this 
is really a feature  of Artemis,  and Async is simply exposes it through its API. 

 
#### [1043](https://github.com/javalite/javalite/issues/1043) Implement support for Cassandra in DB-Migrator plugin

For more information, see [Cassandra in DB-Migrator](cassandra_migrations) plugin page for more info. 

#### [1027](https://github.com/javalite/javalite/issues/1027) Implement ability to write DB migration in a Groovy Script

Sometimes you need to "massage" data during a migration,  but there is no way to do this using a built-in language. As
of this version, you can simply write migrations in Groovy. The database connection will be already open for your Groovy 
script, and ActiveJDBC will be on the script's classpath. This allows to write simple, concise migration scripts in Groovy
with whatever logic that is necessary.
 
 
 ```groovy
import org.javalite.activejdbc.Base

def books = Base.findAll("select * from books")
books.each { println "The book is: ${it.title}" }
/// ... more code 
```

The migration file needs to  have a `.groovy` extension to be processed as a Groovy script. 


#### JSpec expectation method

There is a new method [JSpec.expect()](http://javalite.github.io/2.4-j8/org/javalite/test/jspec/JSpec.html#expect-java.lang.Class-java.lang.String-java.lang.Runnable-).
 
It is used to verify that an exception ahs been thrown and that the message from that exception matches the expectation: 

```java
expect(AppException.class, "exact exception message here", () -> { /*code here*/ });
```

It provides a convenient "one liner" for expectations that is easy to read. 

#### [#1021](https://github.com/javalite/javalite/issues/1021) HTTP Request Conversion and Validation Specification 

This is the largest change in this release yet.  The ultimate goal for this new feature was to allow matching of Java objects
and incoming HTTP requests, while providing a sensible way for data conversion and validation. 


**Validations**
 
ActiveJDBC already had a considerable validation framework, but it was embedded in ActiveJDBC. With this release, 
you can enjoy the same validation techniques in non-model classes, follow to the [Validations](/validations) page 
for more information. This was a massive refactoring effort with the goals of a full backwards compatibility. 
  
**Dynamic paramers**  

ActiveWeb controllers could always pull request parameters using different versions of `param` methods: `param("name")`, 
`params1st("name")`, etc.  

This feature has been available  for close to 10 years: [Dynamic parameters](https://javalite.io/processing_web_requests_dynamic_parameters). 

**Implicit conversion**

However, with this release, you can use real Java classes as request parameters.


For instance,  say you have a class: 

```java
public class Person {
    private String  firstName, lastName;
    private int yearOfBirth = -1;
    private boolean married = false;
    public String toString(){ return "First name: " + firstName + ", last name: " + lastName + ", married: " + married; }
}
```

and the form looks like this: 

```html
<@form controller="people" action="add" method="POST"> 
  <input type="text" name="first_name"/>
  <input type="text" name="last_name"/>
  <input type="text" name="married"/>
  <input type="submit"/>
</@form>
```
The controller  might process this form as anm instance of a `Person`  class already filled with data: 

```java
public class PeopleController extends AppController {
    @POST
    public void add(Person person){
        logInfo(person);
    }
}
```

As you can see, the framework will: 

1. Match form parameters with class attributes using name  as well as type matching. `first_name -> firstName`.
2. Create a new instance of the class `Person` and automatically will fill it to the best of its abilities. 

This allows developers to write cleaner code for HTTP request processing. 

> Besides HTTP froms, this mode also supports direct `application/json` documents posted to controllers. 

 For more information, follow to the [Implicit conversion](/processing_web_requests_implicit_conversion) page. 
 

**Conversion with Validation**

Since the [Validations](/validations) framework is general purpose, it was possible to integrate it to into ActiveWeb 
in order to add data validation to the  [Implicit conversion](/processing_web_requests_implicit_conversion) capability. 


Lets say you have a value class: 
```java
public class Plant extends ValidationSupport {
    private String name, group, temperature;
    public Plant(){
        validatePresenceOf("name", "group");
        validateNumericalityOf("temperature").greaterThan(0).lessThan(100);
    }
} 
```

As you can see, you can specify validations similarly to Model validations, but they are declared in constructor. 

The controller might look like this: 

```java
public class PlantController extends AppController{
public void plant(Plant plant){

    if(plant.errors.isEmpty()){
        // - happy path
    }else{
        respond(plant.errors().toJSON()).statusCode(400);
    }
}
```

.. so the `plant.errors()` will have all the validation errors if any. 

At this point,  you have the power of implicit conversion together with validation and direct JSON support. 

For more information, see [Web requests with validation](/processing_web_requests_with_validation) 
  
