The release 3.0 is a cornerstone release, because it is the first official 
release post-Java 11, and is built for Java 16. Many features that were added 
to the project, were added to this release and were not ported to previous releases for 
Java 8 and Java 11. Since this release took so long, it will be followed by a new release 
3.1 for Java 17 LTS almost unchanged.  

## Convenience working with JSON

As the Internet development pretty much standardized on JSON as the
linqua-franqa  of the Internet, JavaLite added a number of conveniences
working with JSON, be it reading, writing, validating  many other features.

### JSONMap class gets a  new constructor 

Here is a  new constructor for the class `JSONMap`
```java
public class JSONMap extends HashMap<String, Object> {
    public JSONMap(String ... keysAndValues){
        super(map(keysAndValues));
    }
}
```

It allows writing one-liners to create map objects that are JSON-enabled: 

```java
JSONMap person = new JSONMap("first_name", "Marylin", "last_name", "Monroe");
```
see more: [Implement a convenience constructor](https://github.com/javalite/javalite/issues/1210)

### JSONHelper gets a  new method `jsonString(...)`

for example, a call:

```java
String person = JSONHelper.toJsonString("first_name", "Marilyn", "last_name", "Monroe");
```
will generate a string: 

```
{"first_name": "Marilyn","last_name": "Monroe"}
```


### Convenience JSON methods for controllers

If your controller expects a JSON request that can be converted to a map, you can 
convert the request into a map using the method: `getRequestJSONMap()`: 

```java

public class MyController extends AppController {
    @POST
    public void index1(){
        JSONMap request = getRequestJSONMap();
        request.put("last_name", "Doe"); // adding more stuff to the map
        ...  
    }
```

A corresponding `getRequestJSONList()` was also added.

----

Responding with JSON from controllers also got easier: 

```java
@POST
    public void index1(){
        respondJSON(request);
    }
```

The method `respondJSON(obj)` will try to convert any object to a JSON string and 
will also set the Content-type header to `application/json`.

### Controller Spec conveniences  
The same convenience is also available for sending JSON documents from controller tests: 

```java
@Test
public void shouldPostJSONMap(){
    String doc = """
            {
                "first_name" : "John"
            }
            """;
    request().json(doc).post("index1");
```

Note, that the method `json(..)` accepts a String and automatically sets the `application/json`
content type. 

Additionally, two more methods were added to the controller specs that help parse 
controller output: `responseJSONMap()` and `responseJSONList()`. here is a whole spec example: 

```java
public void shouldPostJSONMap(){
    String doc="""
        {
            "first_name" : "John"
        }
        """;
    request().json(doc).post("index1");
    JSONMap response=responseJSONMap();
    the(response).shouldContain("first_name");
}
```

These methods make controller specs easier to write and to read.

### JavaLite HTTP Client

This library also benefited from the added JSON support: 

```java
Get p = Http.get("https://www.serice...");
JSONMap map = p.jsonMap();
// or:
JSONList list = p.jsonList();
```

Of  course, watch out for a runtime exception in case the output is not JSON.  

## Implementation of WebSockets

Documentation coming soon. 


In the meantime, you can review the  latest [Release Notes](/releases): 




