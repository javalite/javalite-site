<div class="page-header">
   <h1>Web Requests: Input Validation</h1>
</div>

> This feature is available starting with v2.4 for Java 8 and v3.0 for Java 11 and up.
> Also available in current snapshots: 2.3.3-j8-SNAPSHOT and 3.0-SNAPSHOT.  


ActiveWeb uses the same [Validation Framework](/validations) as is available to non-web applications. 



## Control validation outcomes

The value classes used for capturing web requests can  subclass the [ValidationSupport](/validations#validation-support-for-simple-classes)
the same way. 

Lets  say  you have a class: 

~~~~{.java .numberLines}
public class Plant extends ValidationSupport {
    private String name, group;
    public Plant(){
        validatePresenceOf("name", "group");
    }
}
~~~~

And the controller: 

~~~~{.java .numberLines}
public class PlantController extends AppController{
public void plant(Plant plant){
        Errors errors = plant.errors();
        String groupError = errors.get("group");
    }
}
~~~~

as you can see, both attributes `name` and `group` are required. This means, that if you send a request to the 
controller the one of them missing, the Validation framework will kick in before the controller gets a hold of the
request. The object of a `Plant` type will contain an `Errors`  object. 
 
 
The value classes  can use all the same features including dynamic messages, resource bundles, etc, 
 just as described  in the [ValidationSupport](/validations#validation-support-for-simple-classes) page.
 
A controller will get access to the request in this case and the developer will control the 
outcome of execution conditionally  as desired, as opposed to catching a 
[ConversionException](processing_web_requests_implicit_conversion#a-conversion-exception). 


> If the argument type extends the `ValidationSupport`, the controller will be invoked. 



<hr>

> The validation rule declarations in controller argument types are the same as in 
the [Validation Framework](/validations), but located in a constructor rather than in a static block.

## Overloaded  actions are not allowed. 

In order to prevent ambiguity during routing a request to the right controller and action, overloaded action methods are not allowed.

For example, if you  define such action methods in a controller: 

~~~~{.java .numberLines}
public class MyController extends AppController {
    public void action1(){}
    public void action1(Person person){}
}
~~~~ 
 
than this condition will lead to the framework rejecting to route with `org.javalite.activeweb.AmbiguousActionException`
generated before your controller is executed. Ensure to write specs and the catch error filters to capture this condition. 

## Reply on failed validation

Generally, when you are building  web services, it is  easy to implement a reply like below for a given a value class: 

~~~~{.java .numberLines}
public class Plant extends ValidationSupport {
    private String name, group, temperature;
    public Plant(){
        validatePresenceOf("name", "group");
        validateNumericalityOf("temperature").greaterThan(0).lessThan(100);
    }
} 
~~~~

The controller definition: 

~~~~{.java .numberLines}
public class PlantController extends AppController{
public void plant(Plant plant){

    if(plant.errors.isEmpty()){
        // - happy path
    }else{
        respond(plant.errors().toJSON()).statusCode(400);
    }
}
~~~~

In case of a validation error, you will be sending a JSON object back to a 
client like this: 


Example of a JSON response: 

~~~~{.javascript}
{
    "group":"value is missing",
    "name":"value is missing",
    "temperature":"value is greater than 100.0"
}
~~~~

If any field  passes the validation,  it will not be present  in the response. 

## Auto-reply on failed validation

However, sometimes it might get repetitive, and you might want to adopt an automatic response from the 
framework. While it does not have the same flexibility, it reduces some boiler-plate code. 

~~~~{.java .numberLines}
public class PlantController extends AppController{
    @FailedValidationReply(400)
    public void add(Plant plant){
        // - happy path only
    }
}
~~~~

Note the `@FailedValidationReply(400)` annotation. The 400 value is an HTTP  response code. If the 
validation fails, the framework  will respond with a JSON object and a `application/json`  content type 
directly to a client, bypassing the controller.

The response  from the framework in this case will be exactly the same as above. 

## Auto-reply options

The  `@FailedValidationReply` annotation can be placed on specific actions or on a controller. 
If it is placed  at the controller level,  all action methods will adopt the logic for 
an auto-reply  on validation. 

## Auto-reply on implicit conversions

Since the conversion errors (string to int)  happen during the conversion/validation phase, such error messages 
will be added to the automatic responses in cases where `@FailedValidationReply` is used. The text of the messages
is coming from the framework, so ensure this is the error message you want to expose your customers to.   
 