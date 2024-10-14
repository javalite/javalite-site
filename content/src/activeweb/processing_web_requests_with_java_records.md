<div class="page-header">
   <h1>Web Requests: Java Records</h1>
</div>

> This feature is available in a current snapshot:  3.0-SNAPSHOT for Java 16 and up.

ActiveWeb can also map requests to Java records. In this case, the built-in validation is not provided and  
needs to be implemented by the application developer.  

## Example JSON Processing 

Let\'s say we have a web client (a browser, or an API client) post this JSON document in a web request: 

```json
{
 "firstName":"John",
 "lastName": "Smith",
 "yearOfBirth": 1234
}
```

A simple Java Record for encapsulating  this JSON object might look like this: 

```java
public record PersonRecord(String  firstName, String lastName,  int yearOfBirth){}
```

A controller would look like this:

```java
public class RequestArgumentController extends AppController {

    @POST
    public void personRecord(PersonRecord person) {
        // use the person object;
     
        respond().contentType("application/json");
    }
}


```

> As you can see, the framework is expecting the JSON value names to match the Java record properties exactly.  
