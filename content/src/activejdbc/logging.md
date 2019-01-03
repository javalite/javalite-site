<div class="page-header">
   <h1>Logging</h1>
</div>



ActiveJDBC uses [SLF4J](http://www.slf4j.org/) logging facade. Please, refer to SLF4J documentation to see how to
configure it with Log4J, Java Logging, Apache logging, etc.

## ActiveJDBC Logging

ActiveJDBC uses a system property `activejdbc.log` for specifying logging. The value of this property can be:

* blank - in this case, ActiveJDBC will spit out all available information - every SQL statement, cache hits/misses, cache purge events, etc.
* regular expression - in this case, ActiveJDBC will only log statements that match a regular expression

If you just want to see all messages from ActiveJDBC, start your program like this:

~~~~ {.prettyprint}
java -Dactivejdbc.log com.acme.YourProgram
~~~~

If you only want to see select messages, you can provide an expression:

~~~~ {.prettyprint}
java -Dactivejdbc.log=select.* com.acme.YourProgram
~~~~

## Dynamically filter log output

Use this call:

~~~~ {.prettyprint}
org.javalite.activejdbc.LogFilter.setLogExpression("regular expression goes here");
~~~~

This will dynamically change ActiveJDBC log output at run time.

## Custom logger

If you want 100% control over logging, you can implement [ActiveJDBCLogger](http://javalite.github.io/activejdbc/snapshot/org/javalite/activejdbc/ActiveJDBCLogger.html)
and configure it by adding this property to the `activejdbc.properties` file: 

```
activejdbc.logger=com.myproject.MyLogger
```

Ensure that this class has a default constructor. 


## JSON Log4j logging

Many companies use advanced tools to analyze structured logs 
 using such services as [Splunk](https://www.splunk.com/) as well as various 
 [ELK](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=elk+service&*)  implementation. 
    
### Log4j configuration

You can use a classes [JsonLog4jLayout](http://javalite.github.io/activejdbc/snapshot/org/javalite/logging/JsonLog4jLayout.html) to 
configure your Log4j logger to achieve JSON format.
 
 
Here is an example of the `log4j.properties` file:
 
~~~~ {.prettyprint}
log4j.rootLogger=INFO, FILE

log4j.appender.FILE=org.apache.log4j.RollingFileAppender  
log4j.appender.FILE.layout=org.javalite.logging.JsonLog4jLayout
~~~~

Such  configuration will convert every log line into a self-contained JSON document  with the same values as a regular log line. 
For example, this code: 

~~~~ {.java  .numberLines}
Logger logger = LoggerFactory.getLogger(getClass());
logger.info("hello");
logger.error("world");
~~~~

will print the following into a log:

~~~~ {.prettyprint} 
{"level":"INFO","timestamp":"Fri Feb 24 15:20:15 CST 2017","thread":"main","logger":"org.javalite.activejdbc.logging.JsonLog4jLayoutSpec","message":"hello"}
{"level":"ERROR","timestamp":"Fri Feb 24 15:20:15 CST 2017","thread":"main","logger":"org.javalite.activejdbc.logging.JsonLog4jLayoutSpec","message":"world"}
~~~~
                       
Such information id easy to ship to a log analyzer such as  [Splunk](https://www.splunk.com/) as well as various [ELK](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=elk+service&*)
for easy search and analysis. 

### Custom date format

In order to format the timestamp in a log line you can add an optional parameter: `DateFormatPattern`:
 

```
log4j.appender.FILE.layout=org.javalite.logging.JsonLog4jLayout
log4j.appender.FILE.layout.DateFormatPattern=yyyy-MM-dd HH:mm:ss.SSS
```

The format for this parameter is the same as for [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html) 

### Using Context parameters

Sometimes you need to comprehend multiple log entries in a context (web request, user actions, etc). You can use a class 
[Context](http://javalite.github.io/activejdbc/snapshot/org/javalite/logging/Context.html) to do  just that. 

Here is an example: 

~~~~ {.java  .numberLines}
Logger logger = LoggerFactory.getLogger(getClass());
Context.put("user", "joeschmoe", "user_id", "234", "email", "joe@schmoe.me");
logger.info("hello");
logger.error("world");
Context.clear();
~~~~

will print the following into a log:

~~~~ {.prettyprint} 
{"level":"INFO","timestamp":"Fri Feb 24 15:20:15 CST 2017","thread":"main","logger":"org.javalite.activejdbc.logging.JsonLog4jLayoutSpec","message":"hello", "context":{"user":"joeschmoe","user_id":"234","email":"joe@schmoe.me"}}
{"level":"ERROR","timestamp":"Fri Feb 24 15:20:15 CST 2017","thread":"main","logger":"org.javalite.activejdbc.logging.JsonLog4jLayoutSpec","message":"world", "context":{"user":"joeschmoe","user_id":"234","email":"joe@schmoe.me"}}
~~~~

As you can see, every log line now includes an object "context" with corresponding values.  

> Class [Context](http://javalite.github.io/activejdbc/snapshot/org/javalite/logging/Context.html) attaches parameters 
to a current thread, making  them available to execution down the stack trace.
 
> Class [JsonLog4jLayout](http://javalite.github.io/activejdbc/snapshot/org/javalite/logging/JsonLog4jLayout.html)
locates context values on the current thread and appends them to every log line. 

