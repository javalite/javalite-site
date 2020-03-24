## Release notes v2.3.1-j8

### Supported Java

Built with Oracle JDK v 8.x. Should work with OpenJDK too.

The full release notes can be [found here](https://github.com/javalite/javalite/releases/tag/javalite-2.3.2-j8).



## Migration from previous versions

While we have been striving for 100% compatibility with application code, sometimes you need to make decisions that break 100% compatibility.
This release introduces one such inconvenience. 

For instance, if you used this code in previous versions: 

```java
Base.open();

// do work here

Base.close();
```  

Such code relied before on availability of a file `/database.properties` on your classpath. With this release your app will break with a message:

`Could not find configuration in a property file for environment: development. Are you sure you called org.javalite.activejdbc.connection_config.DBConfiguration.loadConfiguration("/database.properties") or similar? You can also call org.javalite.activejdbc.connection_config.DBConfiguration.addConnectionConfig(...) directly`

This message is telling you that this file is not found and you need to explicitly call `DBConfiguration.loadConfiguration("/database.properties")`. So, adding  this
 line to the example above will clear this exception and load the properties file: 
 
```java
DBConfiguration.loadConfiguration("/database.properties"); //<<<---------Add this line before you open a connection for the first time. 
Base.open();

// do work here

Base.close();
```  

In addition,  you can  give this file a different name. 
 
