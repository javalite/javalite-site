<div class="page-header">
   <h1>Running in development mode</h1>
</div>

ActiveWeb will recompile and reload routes and controllers on each request in development environment. It makes it possible
to experiment with controllers, pages and routes in a live application without having to restart the container. Watch the
video on the [ActiveWeb](activeweb) for an example.
All that is required is a system property `active_reload` to be set.

Since production environments do not have compiler, or `active_reload` system property, the framework simply executes
previously compiled and packaged controllers and routes.

## Jetty configuration

Starting a project in development mode is easy, just type:

~~~~ {.prettyprint}
mvn jetty:run
~~~~

The Jetty plugin is configured by default, and there is almost nothing in configuration of this plugin that is
specific to ActiveWeb, except some system properties, see below

### System properties with Jetty

Typical configuration of the Jetty plugin:

~~~~ {.xml  .numberLines}
<plugin>
    <groupId>org.mortbay.jetty</groupId>
    <artifactId>maven-jetty-plugin</artifactId>
    <version>6.1.22</version>
    <configuration>
      <contextPath>/</contextPath>
      <scanIntervalSeconds>0</scanIntervalSeconds>
      <connectors>
        <connector implementation="org.mortbay.jetty.nio.SelectChannelConnector">
          <port>8080</port>
          <maxIdleTime>1000</maxIdleTime>
        </connector>
      </connectors>
      <systemProperties>
        <systemProperty>
          <name>activejdbc.log</name>
          <value></value>
        </systemProperty>
        <systemProperty>
          <name>active_reload</name>
          <value>true</value>
        </systemProperty>
        <systemProperty>
          <name>activeweb.log.request</name>
          <value>true</value>
        </systemProperty>
      </systemProperties>
    </configuration>
</plugin>
~~~~

In the configuration above, there are three system properties configured:

-   `activejdbc.log` - this is related to ActiveJDBC, for more information, please refer to: [ActiveJDBC Logging](logging).
If you do not use ActiveJDBC, you can remove it.
-   `active_reload` - this property if set to true, causes ActiveWeb to recompile and reload a controller being executed.
-   `activeweb.log.request` - this property will enable short information logged from ActiveWeb about each request. It is recommended to have it on.

## Running with Tomcat Maven plugin

In some cases you might want to develop on Tomcat. This is useful if your target deployment in production is also
Tomcat, and you might want to catch some Tomcat-related problems sooner rather than later. Here is default configuration for Tomcat:

~~~~ {.xml  .numberLines}
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.0-beta-1</version>
    <configuration>
        <systemProperties>
            <activejdbc.log/>
            <active_reload>true</active_reload>
            <activeweb.log.request>true</activeweb.log.request>
        </systemProperties>
    </configuration>
    <dependencies>
        <dependency>
            <groupId>com.sun</groupId>
            <artifactId>tools</artifactId>
            <version>1.6.0</version>
            <scope>system</scope>
            <systemPath>${java.home}/../lib/tools.jar</systemPath>
        </dependency>
    </dependencies>
</plugin>
~~~~

Running is as easy as with Jetty:

~~~~ {.prettyprint}
mvn tomcat7:run
~~~~

The same system properties are configured here as for Jetty. For more information on Tomcat plugin, please refer to:
[Tomcat plugin](http://tomcat.apache.org/maven-plugin-2/run-mojo-features.html).

The Tomcat plugin has a `tools.jar` dependency configured. It is necessary for ActiveWeb in order to recompile
controllers. If you remove `active_reload` property, you can also remove this dependency, but then there will be
no code refresh in development environment.
