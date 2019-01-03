<div class="page-header">
   <h1>Lessc</h1>
</div>

[Less compiler](http://lesscss.org/) is a better way to write CSS. ActiveWeb provides a built-in mechanism to generate
CSS file on the fly with a use of a Less compiler.

> Less configuration below requires that you install a Less compiler from: [Less compiler](http://lesscss.org/)


Here is how to configure:

## Configure routes

First, configure the routes to ignore "/bootstrap.css" route in all environments except development:

~~~~ {.java  .numberLines}
public class RouteConfig extends AbstractRouteConfig {
    public void init(AppContext appContext) {
        ignore("/bootstrap.css").exceptIn("development");
    }
}
~~~~

## Create controler for development environment

Then, create a new controller:

~~~~ {.java  .numberLines}
public class BootstrapController extends AbstractLesscController {
    @Override
    protected File getLessFile() {
        return new File("src/main/webapp/less/bootstrap.less");
    }
}
~~~~

And override the `getLessFile()` method to return a location of your main Less file.

Additionally, add a Maven plugin to your pom file:

## Configuration for a Single LESS file

~~~~ {.xml  .numberLines}
<plugin>
    <groupId>org.javalite</groupId>
    <artifactId>activeweb-lessc-maven-plugin</artifactId>
    <version>${activeweb.version}</version>
    <configuration>
        <lesscMain>${basedir}/src/main/webapp/less/bootstrap.less</lesscMain>
        <targetDirectory>${basedir}/target/web</targetDirectory>
        <targetFileName>bootstrap.css</targetFileName>
    </configuration>
    <executions>
        <execution>
            <goals><goal>compile</goal></goals>
        </execution>
    </executions>
</plugin>
~~~~

## Configuration for Multiple LESS files 

If your project has more than one LESS files, you can use alternative configuration to compile multiple files during the build: 

~~~~ {.xml  .numberLines}
<plugin>
    <groupId>org.javalite</groupId>
    <artifactId>activeweb-lessc-maven-plugin</artifactId>
    <version>${activeweb.version}</version>
    <configuration>
        <lessConfigs>
            <lessConfig implementation="org.javalite.lessc.maven.LessConfig">
                <lesscMain>src/main/webapp/less1/bootstrap.less</lesscMain>
                <targetDirectory>target/web1</targetDirectory>
                <targetFileName>bootstrap.css</targetFileName>
                <lesscArguments>--modify-var=base-url='${build.number}'</lesscArguments>
            </lessConfig>
            <lessConfig implementation="org.javalite.lessc.maven.LessConfig">
                <lesscMain>src/main/webapp/less2/bootstrap.less</lesscMain>
                <targetDirectory>target/web2</targetDirectory>
                <targetFileName>bootstrap.css</targetFileName>
                <lesscArguments>--modify-var=base-url='${build.number}'</lesscArguments>
            </lessConfig>
        </lessConfigs>
    </configuration>
    <executions>
        <execution>
            <goals>
                <goal>compile</goal>
            </goals>
        </execution>
    </executions>
</plugin>
~~~~

> The `lesscArguments` has an issue with quotes. Seems that the double quots are not needed. 


## Package the CSS into War file

Configure to package the CSS file into the app with a War plugin:

~~~~ {.xml  .numberLines}
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>2.4</version>
    <configuration>
        <webResources>
            <resource>
                <directory>target/web</directory>
            </resource>
        </webResources>
    </configuration>
</plugin>
~~~~ 

As a result, when your application is running in development environment, the `BootstrapController` is compiling CSS
from less files in cases there are changes in the files. It checks for changes and re-compiles if needed on each request.
During the build, the plugin fully compiles all Less files into a single target CSS file, which then gets packaged
into the war file. The file `bootstrap.css` is then served from container, because this path is ignored in any
environment except development. In fact, in a real production system this file like any other static files will
be served by a web server or a CDN.




