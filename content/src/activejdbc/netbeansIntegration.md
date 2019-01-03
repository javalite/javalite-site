<div class="page-header">
   <h1>Netbeans Integration</h1>
</div>



For general questions, refer to [Instrumentation](instrumentation) page.


* Create new Netbeans project
* Add dependent libraries:
    *  Right click on the newly created project -> Properties -> Libraries
    *  Add "Compile" libraries from [https://github.com/javalite/ant-example/tree/master/lib](https://github.com/javalite/ant-example/tree/master/lib)
    *   Add "Processor" libraries from [https://github.com/javalite/ant-example/tree/master/build_time_libs](https://github.com/javalite/ant-example/tree/master/build_time_libs)
    *  Close


> Ensure you add the latest versions: [Search in Maven Central](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.javalite%22%20AND%20a%3A%22activejdbc%22)

* Click "Files" tab and open build.xml
* Add "-post-compile" target :

~~~~ {.xml  .numberLines}
<target name="-post-compile">
    <java classname="org.javalite.instrumentation.Main" failonerror="true">
        <sysproperty key="outputDirectory" value="${build.classes.dir}"/>
        <classpath>
            <pathelement path="${build.classes.dir}" />
            <pathelement path="${javac.classpath}" />
            <pathelement path="${javac.processorpath}" />
        </classpath>
    </java>
</target>
 
~~~~

* Save and close the file

If you are running project from Netbeans you need to perform additional step:

*  Right click on the project -\> Properties -\> Compiling and uncheck "Compile on save"
