<div class="page-header">
   <h1>JSON processing</h1> 
   <h4>Ways to process JSON  in JavaLite apps</h4>
</div>


## Introduction

JSON   define these data types:

* String
* Number
* object (JSON object)
* an array
* boolean
* null

Modern applications and services use JSON as a lingua franca of the Internet today. Due to ubiquity of JavaScript
and readability  of JSON, it is now the most popular format  for communicating over a network. 

## Generating of JSON

JavaLite historically had methods for generating JSON documents from models: 

```java
String json = model.toJSON();
```

as well as any other object using a `JSONHelper` class: 
 
> As of version 3.0 (and the preceding snapshots), the `org.javalite.common.JsonHelper` class has been deprecated and replaced 
> by `org.javalite.json.JSONHelper`. In the legacy applications, all you have to do is rename the class and package, since the new 
> class is backwards compatible  with the old one.
> 

## Utility class JSONHelper

As mentioned above, the  class `org.javalite.json.JSONHelper` is a Swiss army knife when parsing/generating JSON. It is based on 
a popular open source [Jackson](https://github.com/FasterXML/jackson), but adds a lot of one-line conveniences in the typical style
of JavaLite. 

## Serializing an object

Say you have a class: 
```java
class Person {
    private String firstName, lastName;
    public Person(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }
    //corresponding setters and getters omitted for clarity
}
```

Generating JSON looks like this:

```java
String json = JSONHelper.toJsonString(new Person("John", "Smith"));
System. out.println(json);
```

The output:
```json
{
  "firstName": "John",
  "lastName": "Smith"
}
```

## Generating a JSON object

Normally, you would use a `java.util.Map` type as a data object for that. The `JSONHelper` has a
convenience method to produce a map like so:


```java
String result = JSONHelper.toJsonObject("name", "Joe", "age", 23, "dob", new Date());
System.out.println(result); 
```

The method above assumes that you want to create a map  first, so the argument style is: `(key, val, key1, val1, etc.)`.

The printed text will look like this:
```json
{"name":"Joe","age":23,"dob":"Wed Jun 30 22:37:30 CDT 2021"}
```




## Reading JSON

Suppose you have a JSON array. Converting it to a java.util.List is one line:

```java
List llist = JSONHelper.toList("[1, 2]");
```

Same for a map:
```java
Map m = JSONHelper.toMap("{ \"name\" : \"John\", \"age\": 22 }");
```

any valid JSON format will be copnverted to a corresponding Java class. 
You need to know the structure of the expected JSON  to pick the right method. 

Here you get an array of Maps: 


```java
Map[] maps = JSONHelper.toMaps("[{ \"name\" : \"John\", \"age\": 22 },{ \"name\" : \"Samantha\", \"age\": 21 }]");
```

## JSON Deep Paths

These classes are located in the same package `org.javalite.json`, and have the following purpose: 


* `JSONMap` represents a JSON object
* `JSONList` represents a JSON array
* `JSONBase` represents a JSON object and allows to declare validations
  
Additionally, these classes are integrated well with one another.

For instance, given this document: 

```json
{
   "university": {
        "students" : ["mary", "joe"]
    }
}
```

we can parse and access data such as: 

```java
JSONmap json = JSONHelper.toJSONMap(jsonString));
```

Once we have the instance, we can reach to a deep object inside the JSON document: 

```java
JSONList list = json.getList("university.students");
```
As you can see, we are expecting the type at the path `"university.students"` to be a `java.util.List` 
(formerly JSON array). 

Both `JSONMap` and `JSONBase` have this capability we call Deep Path or Attribute Path. 
It allows a developer to reach directly to a deep object without having to peel off one layer at the time.

## JSONBase and validations
JSONBase class exists to: 

1. Wrap an instance of JSONMap and:
2. Provide the same capability  of validations that the JavaLite [Validations framework](validations) provides 


Suppose we have this JSON code: 

```json
{
   "university": {
        "students" : {
            "mary": { "first_name": "Mary", "age": 35, "married": false},
            "joe": { "first_name": "Joe"}
        }
    }
}
```

We could define a class Students: 

```java
class Students extends JSONBase {
    public Students(Map jsonMap) {
        super(jsonMap);
        validateWith(new RangeValidator("university.students.mary.age", 10, 50));
    }
}
```
so,  in this contrived example, we expect that the integer buried deep inside the JSON hierarchy 
has to be between 10 and 50.  

```java
Student student = new Student(JSONHelper.toMap());
System.out.println(student.valid()); // prints true or false
System.out.println(student.errors().get("university.students.mary.age")); // prints "value should be within limits: > 10 and < 20" in case value is out of range
```

The class `JSONBase` supports all capabilities of the [Validations framework](validations) framework, please refer to that page for further information.  