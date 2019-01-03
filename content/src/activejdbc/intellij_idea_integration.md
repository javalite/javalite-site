<div class="page-header">
   <h1>Intellij idea integration</h1>
</div>

As a general rule of thumb, instrumentation needs to be performed in case you run a program or a test that will execute ActiveJDBC models.
See [Instrumentation](instrumentation) for more detail. Instrumentation needs to execute after compile and before running your code.



## Video: IntelliJ Idea + Instrumentation 

This video clip shows how to do rapid application development with IntelliJ Idea and integrated instrumentation step. 


<iframe width="560" height="315" src="https://www.youtube.com/embed/OHXJXzZNKCU" frameborder="0" allowfullscreen></iframe>


## Configuration


Perform these steps:

* Run -> Edit configurations -> Defaults -> JUnit

* Enter this as a post-Make step:

~~~~
org.javalite:activejdbc-instrumentation:[VERSION]:instrument
~~~~

![Intellij Idea](images/idea_config.png)

> Ensure to enter the latest (or appropriate) version of the library

Since you configured this as a JUnit default configuration, every new JUnit run you create will automatically have this
configuration.

## One-off manual instrumentation

If you just want to execute a one-off instrumentation, simply run it from the Maven tab:

![Intellij Idea manual instrumentation](images/idea_config.png)


## Non-Maven integrations

If you use Ant, simply add an Ant task in the same way as explained above. Same goes for simple command line scripts,
as long as they are executed after Make and before run time.
