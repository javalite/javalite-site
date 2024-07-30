<div class="page-header">
   <h1>Releases</h1>    
</div>

## Latest snapshots 

Can be downloaded from the Sonatype Repo: [https://oss.sonatype.org/content/repositories/snapshots/org/javalite/](https://oss.sonatype.org/content/repositories/snapshots/org/javalite/).

* Java 16 version: 3.1-SNAPSHOT
* Java 8 version: 2.7-j8-SNAPSHOT

If you want to pull JavaLite snapshots,  add the snapshot repositories  to your pom:

## Release 3.5-j11

* Java version: 11
* Date: July 30, 2024.
* [Download from Maven Central](https://central.sonatype.com/search?q=g%3Aorg.javalite&smo=true&namespace=org.javalite&sort=published).

The purpose of this release is to back-port a single issue [Handle concurrent calls to getModelRegistry #1291](https://github.com/javalite/javalite/pull/1291)
to Java 11. 

## Release 3.0

* Java version: 16
* Date: April 19, 2023.
* [Release notes](https://github.com/javalite/javalite/releases/tag/javalite-3.0).
* [Download from Maven Central](https://central.sonatype.com/search?q=g%3Aorg.javalite&smo=true&namespace=org.javalite&sort=published).
* [JavaDoc 3.0](http://javalite.github.io/3.0/)


Main goal: implementation will run on OpenJDK 16.

* [#1119 - Add LocalDate and LocalDateTime suppport - LocalDate added to class Convert.](https://github.com/javalite/javalite/issues/1119)
* [#1104 - Add ability to provide variables in migrations](https://github.com/javalite/javalite/issues/1104)
* [#1115 - Fix a failing test in SessionFacadeSpec](https://github.com/javalite/javalite/issues/1115)
* [#1116 - org.javalite.app_config.EnvironmentSpec cannot be executed in Windows](https://github.com/javalite/javalite/issues/1116)
* [#1114 - Provide a better exception login into the application log file in case Guice prevents from starting the app](https://github.com/javalite/javalite/issues/1114)
* [#1108 - Change  Mysql driver to latest MariaDB](https://github.com/javalite/javalite/issues/1108)
* [#1106 - ActiveWeb: The HTTP method is incorrectly defined if another annotation exists for the action.](https://github.com/javalite/javalite/issues/1106)
* [#1078 - Prevent unexpected session creation - update tests & fix one error](https://github.com/javalite/javalite/issues/1078)
* [#1094 - ActiveWeb: Implement an exclusive routing flag](https://github.com/javalite/javalite/issues/1094)
* [#1101 - Base.find(String query, Object... params) is fetching the whole resultset instead of streaming it](https://github.com/javalite/javalite/issues/1101)
* [#1103 - kotlin-maven-plugin chokes on Java 16 - disconnecting the module activejdbc-kt for now](https://github.com/javalite/javalite/issues/1103)
* [#1089 - Async command serialization might fail in some cases (jdk 16)](https://github.com/javalite/javalite/issues/1089)
* [#1120 - Implement all methods of Map in AppConfig](https://github.com/javalite/javalite/issues/1120)
* [#1119 - Add LocalDate and LocalDateTime suppport](https://github.com/javalite/javalite/issues/1119)
* [#1040 - Implement automatic generation of Open API / Swagger documentation from JavaDoc comments in controllers](https://github.com/javalite/javalite/issues/1040)
* [ #1177 - Implement a Websockets support](https://github.com/javalite/javalite/issues/1177)

## Release 3.4-j11

* Java version: 11
* Date: January 5, 2023
* [Release notes](https://github.com/javalite/javalite/releases/tag/javalite-3.4-j11).

## Release 2.6-j8

> NOTE This release fixes the Log4j vulnerability bug [1175](https://github.com/javalite/javalite/issues/1175). For more changes, please see the release notes (link below). 

* Java version: 8
* Date: Dec 21, 2021.  
* [Release notes](https://github.com/javalite/javalite/releases/tag/javalite-2.6-j8).
* [Download from Maven Central](https://search.maven.org/search?q=g:org.javalite).
* [JavaDoc 2.6-j8](http://javalite.github.io/2.6-j8/)


http://javalite.github.io/2.6-j8/


## Release 2.5-j8

* Java version: 8
* Date: Apr 06, 2021.  
* [Release notes](https://github.com/javalite/javalite/releases/tag/javalite-2.5-j8).
* [Download from Maven Central](https://search.maven.org/search?q=g:org.javalite).
* [JavaDoc 2.5-j8](http://javalite.github.io/2.5-j8/)


## Release 2.4-j8

* Java version: 8
* Date: October 5 2020.  
* [Download from Maven Central](https://search.maven.org/search?q=g:org.javalite).
* [Release notes](release-notes-24-j8).
* [JavaDoc 2.4-j8](http://javalite.github.io/2.4-j8/)



## Release 2.3.2-j8

This release supports Java 8. 

* [Download from Maven Central](https://search.maven.org/search?q=g:org.javalite).
* [Release notes](release-notes-232-j8).
* [JavaDoc 2.3.2-j8](http://javalite.github.io/2.3.2-j8/)


## Release 2.3.1-j8

This release supports Java 8. 

* [Download from Maven Central](https://search.maven.org/search?q=g:org.javalite).
* [Release notes](release-notes-231-j8).
* [JavaDoc 2.3.1-j8](http://javalite.github.io/2.3.1-j8/)

## Release 2.3

* [Download from Maven Central](https://search.maven.org/search?q=g:org.javalite).
* [Release notes](release-notes-23).

JavaDoc: 

* [ActiveJDBC Docs](http://javalite.github.io/activejdbc/2.3)
* [ActiveWeb Docs](http://javalite.github.io/activeweb/2.3)
* [Async](http://javalite.github.io/activeweb/2.3/org/javalite/async/package-summary.html)
* [JSpec Docs](http://javalite.github.io/activejdbc/2.3/org/javalite/test/jspec/JSpec.html)
* [Http Docs](http://javalite.github.io/activejdbc/2.3/org/javalite/http/Http.html)
* [DB-Migrator](http://javalite.github.io/activejdbc/2.3/org/javalite/db_migrator/maven/package-summary.html)
* [AppConfig](http://javalite.github.io/activeweb/2.3/org/javalite/activeweb/AppConfig.html)

## Release version is: 2.2

* [Download from Maven Central](https://search.maven.org/search?q=g:org.javalite).
* [Release notes](release-notes-22).

JavaDoc:

* [ActiveJDBC Docs](http://javalite.github.io/activejdbc/2.2)
* [ActiveWeb Docs](http://javalite.github.io/activeweb/2.2)
* [JSpec Docs](http://javalite.github.io/activejdbc/2.2/org/javalite/test/jspec/JSpec.html)
* [Http Docs](http://javalite.github.io/activejdbc/2.2/org/javalite/http/Http.html)


## Where is release 2.1?

We had some issues in the process of releasing 2.1. As a result, it is not complete and should not be used. 

## Maven config

Here is the Maven  dependency config: 

```xml
<dependency>
    <groupId>org.javalite</groupId>
    <artifactId>activeweb</artifactId>
    <version>CURRENT_VERSION</version>
</dependency>
```

Replace `activeweb` with the name of the module you are using (activejdbc, app-config, etc.).

  
## Past releases

* [JavaLite release notes 2.0](release-notes-20) 
* [ActiveWeb releases](activeweb_releases)
* [ActiveJDBC releases](activejdbc_releases)

## Past Release JavaDoc

## Release 1.4.13 

* [ActiveJDBC Docs - 1.4.13](http://javalite.github.io/activejdbc/1.4.13)
* [ActiveWeb Docs - 1.15](http://javalite.github.io/activeweb/1.15)
* [JSpec Docs - 1.4.13](http://javalite.github.io/activejdbc/1.4.13/org/javalite/test/jspec/JSpec.html)
* [Http Docs - 1.4.13](http://javalite.github.io/activejdbc/1.4.13/org/javalite/http/Http.html)

## Release 1.4.12 

* [ActiveJDBC Docs - 1.4.12](http://javalite.github.io/activejdbc/1.4.12)
* [ActiveWeb Docs - 1.14](http://javalite.github.io/activeweb/1.14)
* [JSpec Docs - 1.4.12](http://javalite.github.io/activejdbc/1.4.12/org/javalite/test/jspec/JSpec.html)
* [Http Docs - 1.4.12](http://javalite.github.io/activejdbc/1.4.12/org/javalite/http/Http.html)


## Release 1.4.11 

* [ActiveJDBC Docs - 1.4.11](http://javalite.github.io/activejdbc/1.4.11)
* [ActiveWeb Docs - 1.13](http://javalite.github.io/activeweb/1.13)
* [JSpec Docs - 1.4.11](http://javalite.github.io/activejdbc/1.4.11/org/javalite/test/jspec/JSpec.html)
* [Http Docs - 1.4.11](http://javalite.github.io/activejdbc/1.4.11/org/javalite/http/Http.html)
