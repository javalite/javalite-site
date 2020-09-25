<div class="page-header">
   <h1>Logging Context</h1>
</div>


## Context definition

As a developer, you often need to comprehend multiple log entries in a 
context (web request, web session, etc). For instance,  in the "context" of  a single web request you
want to see a sequence of log statements as they are emitted by various layers of technology in the same order as they are being executed. 

### Adding context values to log statements

You can use a class 
[Context](http://javalite.github.io/activejdbc/snapshot/org/javalite/logging/Context.html) to do just that.

> Context adds parameters  that will be mixed-in to all log statements down stream in the stack trace. 

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

* Class [Context](http://javalite.github.io/activejdbc/snapshot/org/javalite/logging/Context.html) attaches parameters 
to a current thread, making  them available to execution down the stack trace.
 
* Class `org.javalite.logging.JsonLog4j(2)Layout` locates context values on the current thread and appends them to every log line. 

### Cleaning context

The context parameters are attached to a Thread and will remain there till they are removed.

If you are using ActiveWeb, the context is cleaned automatically at the end of  each HTTP request processing. 
If you are not using ActiveWeb, you can do it by executing: 

```java
Context.clean();
``` 
