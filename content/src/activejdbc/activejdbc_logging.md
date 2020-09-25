<div class="page-header">
   <h1>ActiveJDBC Logging</h1>
</div>



JavaLite uses [SLF4J](http://www.slf4j.org/) logging facade. Please, refer to SLF4J documentation  for more 
information on integration with Log4J, Java Logging, Apache logging, Logback, etc.


ActiveJDBC uses a system property `activejdbc.log` for specifying logging configuration. The value of this property can be:

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

Follow to the [log4j configuration](log4j_configuration) page. 


### Log4j2 configuration

Follow to the [log4j2 configuration](log4j2_configuration) page. 


## Logging Context

Sometimes you need to comprehend multiple log entries in a context (web request, user actions, etc). You can use a class 
`org.javalite.logging.Context` to do  just that. 

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

The class `org.javalite.logging.Context` attaches parameters 
to a current thread, making  them available to execution down the stack trace, where they are picked up by a loggin system and added to 
each log line

  
## Benefits of logging Context

Sometimes you need to see all log statements as they pertain to a single web request or a web session. A lot of things might  
happen during a web request: 

1. Service calls
2. JDBC calls to a database
3. HTTP calls to outside services

In all cases, it would be hugely beneficial to see all the log statements generated deeper in teh stack but originated from the same 
web request. 

You can achieve that by using the `Context` class.  

