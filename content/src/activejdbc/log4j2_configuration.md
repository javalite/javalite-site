<div class="page-header">
   <h1>Log4j2 Configuration</h1>
</div>

> JavaLite switched to Log4j2 since v 2.4  and 3.0 respectively (as well as preceding snapshots).

Generally, developers want to see the results of logging in the console during development, and in files
on test, staging and production environments. The configuration below is a suggestion on  how to achieve that and also integrate 
Log4j2 into your apps. 

## Maven profiles 

Here is an example  of a "development" profile that configures an `appender-name` property to the value 
`CONSOLE`. Since this profile is active by default, this will be the value of the `appender-name` property
when standard Maven commands issued: `mvn clean install`, `mvn test`, etc. 

```xml
<profile>
    <id>development</id>
    <activation>
        <activeByDefault>true</activeByDefault>
    </activation>
    <properties>
        <appender-name>CONSOLE</appender-name>
    </properties>
</profile>
``` 
The second profile `file_log` sets  the `appender-name`  to a value `FILE`, and is designed to indicate that 
the log needs to go to a file.  

```xml
<profile>
    <id>file_log</id>
    <properties>
        <appender-name>FILE</appender-name>
    </properties>
</profile>
```



## Configuring Log4j2


This is done  by adding a file `log4j2.xml` to directory `src/main/resources`.  

Log4j2 supports other formats too, please refer to 
[its configuration documentation](http://logging.apache.org/log4j/2.x/manual/configuration.html). 
 

Here is an example:  

~~~~ {.xml  .numberLines}
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="INFO" packages="org.javalite.logging" name="MyApp" strict="true">
    <Loggers>
        <Root level="info">
            <AppenderRef ref="${appender-name}"/>
        </Root>
    </Loggers>
    <Appenders>
        <Console name="CONSOLE" target="SYSTEM_OUT">
            <JsonLog4j2Layout dateFormat="yyyy-MM-dd HH:mm:ss.SSS"/>
        </Console>
        <RollingFile name="FILE"
                     ignoreExceptions="false"
                     fileName="${sys:app.home}/logs/myapp.log"
                     filePattern="${sys:app.home}/logs/myapp-%d{MM-dd-yyyy}.log.gz">
            <Policies>
                <TimeBasedTriggeringPolicy/>
            </Policies>
            <DefaultRolloverStrategy/>
            <JsonLog4j2Layout dateFormat="yyyy-MM-dd HH:mm:ss.SSS"/>
        </RollingFile>
    </Appenders>
</Configuration>
~~~~


Let\'s decompose  this configuration: 

* Line 2 contains this attribute: ` packages="org.javalite.logging"`, which is necessary to
use if you  want the output in JSON format, which is achieved by `JsonLog4j2Layout` configured on 
line 20th
* Line 5 contains a valiable `appender-name` which is replaced with either `FILE` or `CONSOLE` by Maven while filtering the 
resources. See [Filtering resources](#filtering-resources) below. 

As a result, your `log4j2.xml`  file will have either `CONSOLE` or `FILE` on line 5,  depending what profile  you used
in your Maven command.   
 
 As you can see, the configuration above contains two appenders, `CONSOLE` and `FILE`, 
 and just the `FILE` appender has a layout configured. This means that the output in a file 
 will be in a JSON format, while the CONSOLE format will be in plain text.
 
 > Having logs on the console in development and in a log file in 
 production achieves goals of fast development and automated log processing. 


## Filtering resources

In order to tell Maven to replace the `appender-name`, you need to "filter"  resources, and this is how you do this in Maven, 
considering that the file `log4j2.xml` is located in `src/main/resources`, as it should.    
  
```xml
<resources>
    <resource>
        <directory>src/main/resources</directory>
        <filtering>true</filtering>
    </resource>
</resources>
```
