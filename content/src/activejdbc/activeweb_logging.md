<div class="page-header">
   <h1>ActiveWeb Logging</h1>
</div>


ActiveWeb will use a logging system that is integrated into the app  via SLF4J, see [Log4j2 Configuration](/log4j2_configuration).

When logging from filters and controllers, there is no need to create a new logger, since the following 
methods are already available from the class `HttpSupport`, which is a super class for all controllers and 
controller filters:  

        
```java
logDebug(..);
logError(..);
logInfo(..);
logWarning(..);
```


