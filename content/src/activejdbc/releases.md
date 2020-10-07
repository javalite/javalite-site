<div class="page-header">
   <h1>Releases</h1>    
</div>


## Current release 2.4-j8

* Java version: 8
* Date: October 5 2020.  
* [Download from Maven Central](https://search.maven.org/search?q=g:org.javalite).
* [Release notes](release-notes-24-j8).
* [JavaDoc 2.4-j8](http://javalite.github.io/2.4-j8/)

## Latest snapshots 

Can be downloaded from the Sonatype Repo: [https://oss.sonatype.org/content/repositories/snapshots/org/javalite/](https://oss.sonatype.org/content/repositories/snapshots/org/javalite/).

* Java 11 version: 3.0-SNAPSHOT, JavaDoc: [3.0-SNAPSHOT](http://javalite.github.io/3.0-SNAPSHOT)
* Java 8 version: 2.3.3-j8-SNAPSHOT, JavaDoc: [2.3.3-j8-SNAPSHOT](http://javalite.github.io/2.3.3-j8-SNAPSHOT/)

If you want to pull JavaLite snapshots,  add the snapshot repositories  to your pom: 

```xml
<repositories>
    <repository>
        <id>sonatype_snapshots</id>
        <name>Sonatype Snapshots</name>
        <url>https://oss.sonatype.org/content/repositories/snapshots/</url>
        <snapshots>
            <enabled>true</enabled>
            <updatePolicy>always</updatePolicy>
        </snapshots>
    </repository>
</repositories>
<pluginRepositories>
    <pluginRepository>
        <id>sonatype_plugin_snapshots</id>
        <name>Sonatype Snapshots</name>
        <url>https://oss.sonatype.org/content/repositories/snapshots/</url>
        <snapshots>
            <enabled>true</enabled>
        </snapshots>
    </pluginRepository>
</pluginRepositories>
         
```
 


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
