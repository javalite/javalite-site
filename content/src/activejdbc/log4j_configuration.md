<div class="page-header">
   <h1>Log4j Configuration</h1>
</div>

You can use a class [JsonLog4jLayout](http://javalite.github.io/activejdbc/snapshot/org/javalite/logging/JsonLog4jLayout.html) to 
configure your Log4j logger to achieve JSON format.
 
 
Here is an example of the `log4j.properties` file:
 
~~~~ {.prettyprint}
log4j.rootLogger=INFO, FILE

log4j.appender.FILE=org.apache.log4j.RollingFileAppender  
log4j.appender.FILE.layout=org.javalite.logging.JsonLog4jLayout
~~~~

Such a configuration will convert every log line into a self-contained JSON document  with the same values as a regular log line. 
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

## Custom date format

In order to format the timestamp in a log line you can add an optional parameter: `DateFormatPattern`:
 

```
log4j.appender.FILE.layout=org.javalite.logging.JsonLog4jLayout
log4j.appender.FILE.layout.DateFormatPattern=yyyy-MM-dd HH:mm:ss.SSS
```

The format for this parameter is the same as for [SimpleDateFormat](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html) 
