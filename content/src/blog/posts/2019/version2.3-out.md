Finally, after much work for almost a year, we released a new version of JavaLite!


### JUnit 5 Support

JUnit 5 has been out for some time,  so there were a number or requests to add its support to JavaLite, which we did. 
However, in the spirit of the backwards compatibility, we retained support for JUnit 4, which means  that you can use 
JUnit 4  and 5 in the same project  if you like. 

### Add ability to use model classes without connecting to the DB

As you know, ActiveJDBC uses [Runtime Discovery](/runtime_discovery) for its dynamic configuration of model 
attributes, tables as well as relationships. This means that whenever  you use any model for the first time, 
your program needs access to the database  so that the metadata could be pulled out. 

This approach works well, as the database is the only place of reference. However, it does not work well for 
all cases, so a Static Metadata Generation was implemented. 

Please see [Static Metadata Generation](/runtime_discovery#static-metadata-generation) for more information.    

##   What about the rest?

Of course not! There is a considerable set of changes from a previous version, check out a full list:  [Realse Notes 2.3](/release-notes-23).  

## What is next? 

We set our sites on Java11 and beyond. In the process we will be maintaining compatibility to Java 8 as we grind into Java11. 
Here is how branching and versioning will work: 

1. The branch [java8](https://github.com/javalite/activejdbc/tree/java8) to release versions 2.3.X to support Java8. 
2. The master branch will be used for version 3.0-SNAPSHOT and will be switching to support Java11 and later. 

All important bug fixes and new features will be implemented on master and then cherry-picked  to the [java8](https://github.com/javalite/activejdbc/tree/java8) branch. 

  
 

Version 2.3.1 is for Java 8 maintenance. The next version 3.0 will start supporting Jav version 11 and later. 