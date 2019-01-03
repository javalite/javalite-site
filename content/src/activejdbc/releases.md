<div class="page-header">
   <h1>Releases</h1>    
</div>

## Current release version is: 2.2

The latest current release version is 2.2 and can be downloaded from [Maven Central](http://search.maven.org).

Please, see [2.2 release notes](release-notes-22).


## Where is release 2.1?

We had some issues in the process of releasing 2.1. As a result, it is not complete and should not be used. 

## Maven config

Here is the Maven  dependency config: 

```xml
<dependency>
    <groupId>org.javalite</groupId>
    <artifactId>activeweb</artifactId>
    <version>2.2</version>
</dependency>
```

Replace `activeweb` with the name of the module you are using (activejdbc, app-config, etc.).


## Current snapshot 2.3-SNAPSHOT

Can be downloaded from the Sonatype Repo: [https://oss.sonatype.org/content/repositories/snapshots/](https://oss.sonatype.org/content/repositories/snapshots/).

If you feel adventurous, you can automatically download snapshots from our repo by adding this config to your pom file:  

```xml
<repositories>
    <repository>
        <id>snapshots1</id>
        <name>Sonatype Snapshots</name>
        <url>https://oss.sonatype.org/content/repositories/snapshots/</url>
        <snapshots>
            <enabled>true</enabled>
            <updatePolicy>always</updatePolicy>
            <checksumPolicy>warn</checksumPolicy>
        </snapshots>
    </repository>
</repositories>

```
For Meven plugins: 

```xml
<pluginRepositories>
    <pluginRepository>
        <id>sonatype_plugin_snapshots</id>
        <name>Sonatype Plugin Snapshots</name>
        <url>https://oss.sonatype.org/content/repositories/snapshots/</url>
        <snapshots>
            <enabled>true</enabled>
        </snapshots>
    </pluginRepository>
</pluginRepositories>
```
  
## Past releases

* [JavaLite release notes 2.0](release-notes-20) 
* [ActiveWeb releases](activeweb_releases)
* [ActiveJDBC releases](activejdbc_releases)
