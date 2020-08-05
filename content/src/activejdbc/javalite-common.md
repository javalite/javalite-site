<div class="page-header">
   <h1>JavaLite Common</h1>
</div>



JavaLite Common  is a collection of convenience classes and packages that are shared across
other JavaLite modules. 


## org.javalite.common.Collections

A simple class that adds some syntactical sugar when creating lists  and maps. For instance
if you want to create a list of strings, normally you would: 
  

~~~~ {.java  .numberLines}
List<String> names = new ArrayList<>();
names.add("John");
names.add("Hellen");
names.add("Henry");
~~~~ 

with Collections, you would: 

~~~~ {.java  .numberLines}

import static org.javalite.common.Collections;

List<String> names = list("John", "Hellen", "Henry");
~~~~

.. or use a method `li` for the same purpose. 

For maps:

~~~~ {.java  .numberLines}

import static org.javalite.common.Collections;

Map<String, String > people = map( "first_name", "John", "last_name", "Doe", 
                                   "first_name", "Hellen", "last_name", "Doe");
~~~~

For more features, see: [Collections JavaDoc](http://javalite.github.io/2.3.2-j8/org/javalite/common/Collections.html) 


## org.javalite.common.Convert

This is an important class because it  is used throughout the framework to convert one type to another. 

Example: 
 
~~~~ {.java  .numberLines} 
int x = Convert.toInteger("1"); 

boolean  active = Convert.toBoolean("yes");
~~~~

There are many converter  methods. You cn explore at: [Convert](http://javalite.github.io/2.3.2-j8/org/javalite/common/Convert.html).

##  org.javalite.common.HumanDate

Allows to generate distance in time in a human readable format: 


~~~~ {.java  .numberLines}
String distance = HumanDate.toHumanFormat(fromTime, toTime)); // Value: "less than a minute"
~~~~

## org.javalite.common.Inflector

Translates English in singluar  form to plural and back, as well as other translation functions: 

~~~~ {.java  .numberLines}
Inflector.pluralize("octopus");             // "octopi"
Inflector.camelize("library_book");         // "LibraryBook"
Inflector.underscore("LibraryBook");        // "library_book"   
~~~~

 
## org.javalite.common.JsonHelper
 
 This class is a convenience for a popular library [FasterXML/jackson](https://github.com/FasterXML/jackson).
 Jackson is on the classpath and  you can use it directly. However, you migth find these shortcuts convenient: 
 
~~~~ {.java  .numberLines}
 Map m = toMap(json); 
 Map[] maps = toMaps(json);
 List list = toList(String json);
 String jsonString = toJsonString(val);
~~~~ 
 
 If course in the first three cases, the string objects need to contain proper JSON content; 
 
   
## org.javalite.common.Util
 
This is a Swiss army knife  for working with files and streams, as well as other functions: 
 
~~~~ {.java  .numberLines}
 String joined = Util.join(list("first", "second", "third"), ",")       // "first,second,third"
 String[] = parts Util.split("first,second,third", ',');  // ["first", "second", "third"]
~~~~ 
 
Reading resources: 
 
~~~~ {.java  .numberLines}
 String applicationJson  = Util.readResource("/foo/bar/application.json");
~~~~ 
 
## Validations 
 
 For Validations framework, refer [here](validations)