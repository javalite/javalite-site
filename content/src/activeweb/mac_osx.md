<div class="page-header">
   <h1>Mac osx</h1>
</div>


The simple example app needs a few small modification to run on OS X. See below for each.

## Setting Tools Jar Path


On OS X there is no "tools.jar", its instead named "classes.jar" and lives in a different directory.
Here's how to pick it up in your pom.xml

~~~~ {.xml  .numberLines}
<profiles>
    <profile>
        <id>default-profile</id>
        <activation>
            <activeByDefault>true</activeByDefault>
            <file>
                <exists>${java.home}/../lib/tools.jar</exists>
            </file>
        </activation>
        <properties>
            <toolsjar>${java.home}/../lib/tools.jar</toolsjar>
        </properties>
    </profile>
    <profile>
        <id>mac-profile</id>
        <activation>
            <activeByDefault>false</activeByDefault>
            <file>
                <exists>${java.home}/../Classes/classes.jar</exists>
            </file>
        </activation>
        <properties>
            <toolsjar>${java.home}/../Classes/classes.jar</toolsjar>
        </properties>
    </profile>
</profiles>
~~~~

And then update this dependency to use the toolsjar variable:

~~~~ {.xml  .numberLines}
<dependency>
        <groupId>com.sun</groupId>
        <artifactId>tools</artifactId>
        <version>1.5.0</version>
        <scope>system</scope>
        <systemPath>${toolsjar}</systemPath>
 </dependency>
~~~~

## Picking an App Server

You have two choices here. You can either make a change to the jetty-env.xml file to get jetty working,
or you can switch to use the Tomcat plugin instead of Jetty. Here's the details for both.

## Jetty plugin


To get Jetty to work update your jetty-env.xml file like this:

~~~~ {.xml  .numberLines}

<?xml version="1.0"?>
<!DOCTYPE Configure PUBLIC "-//Mort Bay Consulting//DTD Configure//EN" "http://jetty.mortbay.org/configure.dtd">
<Configure class="org.mortbay.jetty.webapp.WebAppContext">
    <Set name="parentLoaderPriority">true</Set>
</Configure>
~~~~

## Tomcat plugin

Alternatively switch to the Tomcat plugin in pom.xml. The only oddity about Tomcat plugin is that it is
pinned to the "compile" phase, which means that unlike Jetty it will not run instrumentation automatically.
Other then that, no issues with Tomcat plugin on MaxOS. Here is the configuration:

~~~~ {.xml  .numberLines}
 <plugin>
        <groupId>org.apache.tomcat.maven</groupId>
        <artifactId>tomcat7-maven-plugin</artifactId>
        <version>2.0-beta-1</version>
        <configuration>
            <path>/</path>
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
                <systemPath>${toolsjar}</systemPath>
            </dependency>
        </dependencies>
</plugin>
~~~~


Evan
