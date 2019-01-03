<div class="page-header">
   <h1>Instrumentation</h1>
</div>



ActiveJDBC requires instrumentation of class files after they are compiled. This is accomplished with an Instrumentation
tool provided by the project. There are three ways to use it: with a Maven plugin, Ant, and as a standalone Java
class (no Ant or Maven)

## What is instrumentation?

Instrumentation is byte code manipulation that happens after a compile phase. It adds static methods from super
class to a subclass. Instrumentation allows to "inherit" static methods from a super class, making elegant code like this
possible:

~~~~ {.java  .numberLines}
List<Person> retirees = Person.where("age >= ?", 65);
~~~~

Without instrumentation, ActiveJDBC would not be able to know which class is being called, and as a result,
what table to query.

For instance, in a case of no instrumentation, this call in source code:

~~~~ {.java  .numberLines}
Person.where(...);
~~~~

translates to this logic in bytecode:

~~~~ {.java  .numberLines}
Model.where(...);
~~~~

It is evident, that there is no way to tell what model is executed, and as a result, we cannot map this call to a database table.

While instrumentation introduces an additional step in the process, the benefit is a very intuitive and concise API.

## Maven instrumentation plugin

The simple usage of a Maven plugin is provided by a Maven ActiveJDBC Simple Example project: [Simple Maven Example](https://github.com/javalite/simple-example).
Specifically, the plugin is added to a pom like this:

~~~~ {.xml  .numberLines}
<plugin>
    <groupId>org.javalite</groupId>
    <artifactId>activejdbc-instrumentation</artifactId>
    <version>${activejdbc.version}</version>
    <executions>
        <execution>
            <phase>process-classes</phase>
            <goals>
                <goal>instrument</goal>
            </goals>
        </execution>
    </executions>
</plugin>
~~~~

and binds to a `process-classes` Maven phase. It will automatically instrument model classes during the build.

## Video: IntelliJ Idea + Instrumentation 

This video clip shows how to do rapid application development with IntelliJ Idea and integrated instrumentation step. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/OHXJXzZNKCU" frameborder="0" allowfullscreen></iframe>

For more, see [IntelliJ Integration](intellij_idea_integration)

## Gradle instrumentation plugin

The instrumentation step is also available as a Gradle plugin, an example project can be found here: [Gradle Plugin Example](https://github.com/javalite/activejdbc-gradle).

Add the plugin to your `build.gradle` file like this:

~~~~ {.groovy .numberLines}
buildscript {
    repositories {
        mavenCentral()
        maven { url 'http://repo.javalite.io' }
    }
    dependencies {
        classpath group: 'org.javalite', name: 'activejdbc-gradle-plugin', version: '1.4.13-SNAPSHOT'
    }
}

apply plugin: 'java'
apply plugin: 'org.javalite.activejdbc'
~~~~

The plugin will insert an instrumentation task between the `compileJava` and `classes` tasks that are provided by default with the java plugin.

## Ant instrumentation

Here is an example project with Ant - based instrumentation: [Ant exampe](https://github.com/javalite/ant-example)

The class responsible for instrumentation is called `org.javalite.instrumentation.Main`, and here is an example of using it:

~~~~ {.xml  .numberLines}
<target name="instrument" depends="compile">
    <java classname="org.javalite.instrumentation.Main">
        <sysproperty key="outputDirectory" value="${classes}"/>
        <classpath refid="build_classpath"/>
    </java>
</target>
~~~~

where `${classes}` represents a directory where class files were compiled.

## Standalone instrumentation

If you are not using Maven or Ant, you can run instrumentation with a command similar to this:

~~~~ {.prettyprint}
java  -cp=$CLASSPATH  -DoutputDirectory=build org.javalite.instrumentation.Main
~~~~

where:

-   $CLASSPATH is your classpath (see the build.xml in the Ant example above for things you will need to have on the classspath)
-   build - is a directory where you compiled all classes in a "compile" step before instrumentation

There is an example of a standalone project which does not use any build tool, except Java itself.
Please follow this link for more information: [Standalone instrumentation example project](https://github.com/javalite/standalone-example)

## Speed of instrumentation

... is very fast - for large projects (50 - 60 models) it takes about 5 - 7 seconds, and for small projects (under 10 models) usually within a second or two.

## Build time classpath

The Instrumentation package is required on the classpath only during instrumentation and not required during runtime. For Maven projects, this is automatic. Even it finds its way to the runtime classpath, it will do no harm except for increasing the size.

## Bare bones Ant script

This Ant script can be used on any project in order to speed up development. The reason we use this script sometimes even on Maven projects is speed.
Maven takes a few seconds to startup, but this barebones script is almost instant. You can hook it into IDE to trigger before executing tests:

~~~~ {.xml  .numberLines}
<?xml version="1.0" encoding="UTF-8"?>
<!-- This script is used for fast instrumentation of the project's models-->
<project default="instrument" basedir=".">
    <property name="out.dir" value="target/test-classes"/>
    <path id="instrument_classpath">
        <pathelement location="${out.dir}"/>
        <path location="${user.home}/.m2/repository/org/javalite/activejdbc-instrumentation/1.4.13/activejdbc-instrumentation-1.4.13.jar"/>
        <path location="${user.home}/.m2/repository/javassist/javassist/3.8.0.GA/javassist-3.18.2-GA.jar"/>
        <path location="${user.home}/.m2/repository/org/javalite/activejdbc/1.4.13/activejdbc-1.4.13.jar"/>
    </path>
    <target name="instrument">
        <java classname="org.javalite.instrumentation.Main">
            <sysproperty key="outputDirectory" value="${out.dir}"/>
            <classpath refid="instrument_classpath"/>
        </java>
    </target>
</project>

~~~~

Replace versions with the most up-to-date: [Maven search for ActiveJDBC](http://search.maven.org/#search%7Cga%7C1%7Cactivejdbc)

## IDE Integrations

* [Intellij Idea Integration ](intellij_idea_integration)
* [Eclipse Integration](eclipseIntegration)
* [Netbeans Integration](netbeansIntegration)
