<div class="page-header">
   <h1>Eclipse Integration</h1>
</div>


As a general rule of thumb, instrumentation needs to be performed in case you run a program or a test that will execute ActiveJDBC models.
See [Instrumentation](instrumentation) for more detail. Basically Instrumentation adds special byte code instructions for ActiveJDBC to
operate properly. Since Eclipse automatically recompiles classes each time you make modifications and save, it can blow away
instrumented ActiveJDBC classes and replace them with just compiled versions (non-instrumented).

When this happens, you will see an exception similar to:

~~~~
 org.javalite.activejdbc.InitException: failed to determine Model class name, are you sure models have been instrumented?
~~~~

This means that in before you run your program, model classes need to be instrumented.

## Create Maven instrumentation script

This page provides instructions based on a simple Maven ActiveJDBC example. Sources can be found here:
[https://github.com/javalite/simple-example](https://github.com/javalite/simple-example)

Create a directory scripts:

~~~~
mkdir scripts
~~~~

Create instrumentation script:

~~~~
vi ./scripts/instrumentation.sh
~~~~

and place this content into the script:

~~~~
mvn process-classes
~~~~

Since Instrumentation plugin is bound to the `process-classes` phase, it will be executed when this goal is invoked. Make script executable:

~~~~
chmod a+x ./scripts/instrumentation.sh
~~~~

Execute script from the root of project:

~~~~
./scripts/instrumentation.sh
~~~~

and observe output similar to this:

~~~~
**************************** START INSTRUMENTATION ****************************
Directory: /home/igor/tmp/simple-example/target/classes
Found model: org.javalite.activejdbc.examples.simple.Employee
Instrumented class: org.javalite.activejdbc.examples.simple.Employee in directory: /home/igor/tmp/simple-example/target/classes/
**************************** END INSTRUMENTATION ****************************
~~~~

If you see this output, everything is fine.


## Non-Maven instrumentation script

If you are not using Maven, you can create a shell script for Linux or Mac, or a batch script for Windows. 
More details are here: [Standalone instrumentation](instrumentation#standalone-instrumentation).

## Configure Eclipse builder

Now we need to configure Eclipse Builder to run Instrumentation before executing a unit test or running a program.

Select: Project -> Properties -> Builders, create a new builder and configure it like this:

eclipse-config.png

![Eclipse config](images/eclipse-config.png)


Once this is configured you can run your Java program or a JUnit test. Your Instrumentation builder will be executed 
after Java Builder and Maven Project builder, ensuring that instrumentation is executed just before run time. Eclipse
is also smart to call builders only if there are changes in code.

## If you get: "execution not covered by lifecycle"

Sometimes Eclipse has issues with Maven: ([m2 xecution Not Covered...](http://www.eclipse.org/m2e/documentation/m2e-execution-not-covered.html)). 
This is not related to ActiveJDBC.  Here is a similar question on 
[StackOverflow: How to solve Plugin execution not covered...](http://stackoverflow.com/questions/6352208/how-to-solve-plugin-execution-not-covered-by-lifecycle-configuration-for-sprin). 

Also you can refer to this thread: [Plugin execution not covered by lifecycle configuration](https://groups.google.com/forum/#!searchin/activejdbc-group/execution$20not$20covered$20by$20lifecycle/activejdbc-group/xQ5gUSnCalc/MWvALjevdAoJ). 


Generally you need to add `build > pluginManagement` tag and add the following content there: 


~~~~ {.xml  .numberLines}
<pluginManagement>
    <plugins>
        <!--This plugin's configuration is used to store Eclipse m2e settings only. It has no influence on the Maven build itself.-->
        <plugin>
            <groupId>org.eclipse.m2e</groupId>
            <artifactId>lifecycle-mapping</artifactId>
            <version>1.0.0</version>
            <configuration>
                <lifecycleMappingMetadata>
                    <pluginExecutions>
                        <pluginExecution>
                            <pluginExecutionFilter>
                                <groupId>org.javalite</groupId>
                                <artifactId>
                                    activejdbc-instrumentation
                                </artifactId>
                                <versionRange>
                                    [1.4.13,)
                                </versionRange>
                                <goals>
                                    <goal>instrument</goal>
                                </goals>
                            </pluginExecutionFilter>
                            <action>
                                <ignore></ignore>
                            </action>
                        </pluginExecution>
                    </pluginExecutions>
                </lifecycleMappingMetadata>
            </configuration>
        </plugin>
    </plugins>
</pluginManagement>
~~~~
