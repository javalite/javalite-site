<div class="page-header">
   <h1>Expecting Log Output</h1>
</div>


Sometimes you will need to test for  content of log output. 
For instance, you are testing  some service deep inside the stack and do not have a direct access to it. 


## Configure a Log4j Logger 

Create a `log4j.properties` file (presuming a Maven file structure): 

```
 src
  +--test
      +--resources
             +--log4j.properties
```

with the following content: 

```
log4j.rootLogger=INFO,CONSOLE
log4j.appender.CONSOLE=org.javalite.logging.LoggingTestAppender
```

This logger simply drops everything in STDIO.

Maven will place the `src/test/resources` at the top of the classpath for tests but will not package into the 
final artifact, so your real Log4j configuration is safe.   

## Writing a spec


~~~~ {.java .numberLines}
@Test
public void shouldExpectFoo() {
    SystemStreamUtil.replaceOut();
    //some code here to cause actual actions
    String out = SystemStreamUtil.getSystemOut();
    String[] lines = Util.split(out, System.getProperty("line.separator"));
    the(lines[4]).shouldContain("select * from people");
    SystemStreamUtil.restoreSystemOut();
 }

~~~~

* Line 3: will start intercepting and accumulating all output to `System.out`.   
* Line 5: get all log output as a single `String` object
* Line 6: splitting the log output into individual log lines
* Line 7: asserting the value in a specific line
* Line 8: restorin the STDIO back to its natural state for all other tests that follow.


## STDERR?

The same technique can be done with `SystemStreamUtil.getSystemErr()` 
and `SystemStreamUtil.restoreSystemErr()` respectively.

----
> Do not forget to restore the STDIO or STDERR output, otherwise you will not see much of log output. 
 
