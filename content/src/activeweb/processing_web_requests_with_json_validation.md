<div class="page-header">
   <h1>Web Requests: JSON Input Validation</h1>
</div>

> This feature is available in a current snapshot:  3.0-SNAPSHOT for Java 16 and up.

While ActiveWeb can process validations of simple classes as described 
[here](processing_web_requests_with_validation), often modern apps whether they are APIs or
backends for a single page app require a complex JSON structure. Such structures might be deeper than 
a single level. In such cases, you can use the JavaLite JSON capability that allows you 
to map a variable structure JSON object to a class `JSONBase`. 
The page [JSON](/json) describes basic `JSONBase` features. 
However, the current page dives deeper into JSON processing and validation in the context of a web requests.

The class `JSONBase` has two powerful features:

* It extends the `ValidationSupport` class that makes the entire [Validation](/validation) system 
available to subclasses.
* It provides the [JSON Deep Path](json#json-deep-paths) feature. 
  
In addition, the ActiveWeb does an implicit validation of any object whose class extends `JSONBase`. 

## Example JSON Processing 

Let\'s say we have a web client (a browser, or an API client) post this JSON document in a web request: 

```json
{
  "university": {
    "students": [
      {
        "first_name": "Mary",
        "last_name": "Smith"
      },
      {
        "first_name": "Joe",
        "last_name": "Shmoe"
      }
    ]
  }
}
```

A simple class for encapsulating  this JSON object might look like this: 

```java
public class UniversityRequest extends JSONBase {
    public UniversityRequest(Map jsonMap) {
        super(jsonMap);
    }
}
```

A controller would look like this:

```java
public class UniversityController extends APIController {
    @POST
    public void saveStudents(UniversityRequest request) {
        JSONList students = request.getList("university.students");
        for (int i = 0; i < students.size(); i++) {
            JSONMap student = students.getMap(i);
            //... and so on...
        }
    }
}
```

By the time the action method `saveStudents` is called, the `UniversityRequest` a JSON request was already parsed and 
passed into the method. 

## JSON Validation 

The class `UniversityRequest` above extends from `JSONBase`, which provides various validations in the same way the general 
[Validations framework](validations) as well as [JSON Validations](/json#jsonbase-and-validations) operate.

Let\'s enhance the class `UniversityRequest` with a single validation: 


```java
public class UniversityRequest extends JSONBase {
    public UniversityRequest(Map jsonMap) {
        super(jsonMap);
        validateList("university.students");
    }
}
```

The last line in the constructor above will validate that the structure of JSON will have a JSON Array (or Java List)
at the path `"university.students"`. A controller would look a bit more elaborate:

```java
public class UniversityController extends APIController {
    @POST
    public void saveStudents(UniversityRequest request) {
        if(request.isValid()){
            JSONList students = request.getList("university.students");
            for (int i = 0; i < students.size(); i++) {
                JSONMap student = students.getMap(i);
                //... and so on...
            }
        }else{
            view("errors", request.errors());
            render("/system/500");
        }
    }
}
```
As you can see, the ActiveWeb  framework does most of the heavy lifting of parsing and verifying the incoming JSON
requests.

## JSON Validators

There many other validators in the package `org.javalite.json`

### ListValidator


Just as above, will validate that the structure at the path `"university.students"` is a list. 

```java
public class UniversityRequest extends JSONBase {
    public PeopleRequest(Map jsonMap) {
        super(jsonMap);
        validateList("university.students");
    }
}
```

### MapValidator


Will validate that the structure at the path `"university"` is a map.

```java
public class UniversityRequest extends JSONBase {
    public PeopleRequest(Map jsonMap) {
        super(jsonMap);
        validateMap("university");
    }
}
```

### BooleanValidator

Will validate that the structure at the path `"university.active"` is a boolean.

```java
public class UniversityRequest extends JSONBase {
    public PeopleRequest(Map jsonMap) {
        super(jsonMap);
        validateBoolean("university.active");
    }
}
```

another take on the boolean: will expect a pre-defined value: 

```java
public class UniversityRequest extends JSONBase {
    public PeopleRequest(Map jsonMap) {
        super(jsonMap);
        validateBoolean("university.active", true);
    }
}
```

## Standard validators

Since the class `JSONBase` ties into standard [Validation framework](validations), you can use any standard validation
 in addition. Here is an example:

```java
public class UniversityRequest extends JSONBase {
    public PeopleRequest(Map jsonMap) {
        super(jsonMap);
        validateWith(new EmailValidator("university.address.email"));
    }
}
```

as  you can see, the twist that `JSONBase` adds is a Deep Path to a value in a JSON document. 


## Custom validator

If none of the existing validators work for  you, you can implement a custom one: 

```java


public class PeopleRequest extends JSONBase {

    public PeopleRequest(Map jsonMap) {
        super(jsonMap);
        validateWith(new JSONValidator() {
            @Override
            public void validateJSONBase(JSONBase jsonBase) {
                boolean valid = false;
                //this is where  you can access the values of jsonBase for validation
                if(!valid){
                    jsonBase.addFailedValidator(this, "path.to.object");
                    setMessage("something did not pass validation");
                }
            }
        });
    }
}
```

As you can see, writing a custom validator is not complicated. 
