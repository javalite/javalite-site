<div class="page-header">
   <h1>AppConfig </h1> 
   <h4>A configuration library for Java apps</h4>
</div>


AppConfig is a small configuration library which provides properties for applications deployed to different environments.
For example, your local file storage is located at `/home/joe/project1/files` in a development environment (laptop), 
but in production it is located on the NFS: `/opt/project1/files`. 

`AppConfig` makes it easy to configure multiple property files, one per environment and load just one depending what environment 
 the application is running on. 
  
As such, you may have a property file `development.properties` with content: 

```
file_storage=/home/joe/project1/files
```

while the `production.properties` file will include:

```
file_storage=/opt/project1/files
```


## Reading properties

First, import a static `import AppConfig.p(...)` method:

~~~~ {.java  .numberLines}
import static org.javalite.app_configAppConfig.p;
~~~~ 

then, simply call it as: `p(..)` in places where you need to inject a property:

~~~~ {.java  .numberLines}
String name = p("name");
~~~~

## Property substitution
 
AppConfig allows a property substitution to make it possible to refactor large property files by specifying a
repeating value once. 

If your property file has these properties:
 
``` 
first.name=John
phrase= And the name is ${first.name}
```

than this code will print `And the name is John`:
 
```java
System.out.println(p("phrase"));
```

> Note: The order of properties does not matter.
 

## Setting an environment 

`AppConfig` allows configuration of applications that is specific for different deployment environments. Applications have 
environment-specific files, whose names follow this pattern: `environment.properties`, where environment is a name of a 
deployment environment, such as `development`, `staging`, `production`, etc.

You can also provide a global file, properties from which will be loaded in all environments: global.properties.

> In all cases the files need to be on the classpath under directory/package `/app_config`.

Environment-specific file will have an "environment" part of the file name match to an environment 
variable called `ACTIVE_ENV`. Such configuration is easy to achieve in Unix shell:

~~~~ {.java  .numberLines}
export ACTIVE_ENV=test
~~~~


A typical file structure

```
/app_config
        |
        +--global.properties
        |
        +--development.properties
        |
        +--staging.properties
        |
        +--production.properties
        
```



Global property file will always be loaded, while others will be loaded depending on the value of `ACTIVE_ENV`` environment variable.

> If environment variable `ACTIVE_ENV` is missing, `AppConfig` defaults to environment `development`.

## System property override

You can also provide an environment as a system property app_config.properties. 

Here is an example (add this to the startup script for your app): 

```
-Dapp_config.properties=/opt/project1/production.properties
```

The `app_config.properties` system property points to a file specific to that computer (local box, server, etc.). 
If a specific property is provided in the properties file loaded on classpath, and the same property is also found in 
 the file `app_config.properties`, then the value loaded from a local file overrides the one loaded from classpath.
  
