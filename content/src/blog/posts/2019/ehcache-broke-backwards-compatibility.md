As I was working on the issue to upgrade all dependencies to their respective versions, the work progressed smoothly 
until I had to upgrade Ehcache from version 3.0.0.m4 to version 3.6.4. If you are using Ehcache v3, 
[here is the config doc](http://javalite.io/caching#ehcache-configuration-v-3.x).

Unfortunately, the developers of Ehcache introduced a non-compatible change, such that it requires a different format of your
XML configuration file.   
 



Here is the previous format for `activejdbc-ehcache.xml` for version 3.0.0.m4:  
```xml
<config xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='http://www.ehcache.org/v3'
        xsi:schemaLocation="http://www.ehcache.org/v3 ../../../main/resources/ehcache-core.xsd">
    <cache-template name="activejdbc">
        <key-type>java.lang.String</key-type>
        <value-type>java.lang.Object</value-type>
        <heap size="200" unit="entries"/>
    </cache-template>
</config>
```

The new format will look like this (3.6.3):

```xml
<config xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='http://www.ehcache.org/v3'
        xsi:schemaLocation="http://www.ehcache.org/v3 ../../../main/resources/ehcache-core.xsd">
    <cache-template name="activejdbc">
        <key-type>java.lang.String</key-type>
        <value-type>java.lang.Object</value-type>
        <heap unit="entries">200</heap>           <!-- changed format! -->
    </cache-template>
</config>
```

If you maintain the older format, your project will break if you upgrade to version of JavaLite 2.3 of 2.3-SNAPSHOT. 

So, this article is to help you with this upgrade. If you have any questions, feel free to leave a comment below.  