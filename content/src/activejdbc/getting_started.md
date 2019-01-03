<div class="page-header">
   <h1>Getting started</h1>
</div>


Although ActiveJDBC has advanced features, simple things are very easy. This page shows simplest cases of DB access with ActiveJDBC.

## Pre-requisite

- Java :)
- Maven
- Database

## Create a standard Maven project structure

While ActiveJDBC does not have to be used with Maven, this example (as well as ActiveJDBC itself) was built with Maven.

> See example project: [Simple Maven - based example](https://github.com/javalite/simple-example).

## Create a table

This is an SQL statement to create a table (MySQL used for this example):

~~~~ {.prettyprint}
CREATE TABLE employees (
      id  int(11) DEFAULT NULL auto_increment PRIMARY KEY,
      first_name VARCHAR(56),
      last_name VARCHAR(56)
  );
~~~~

## Maven configuration

### Add ActiveJDBC dependency

~~~~ {.xml  .numberLines}
<dependency>
    <groupId>org.javalite</groupId>
    <artifactId>activejdbc</artifactId>
    <version>1.4.13</version>
</dependency>
~~~~

> Change version to latest.

### Add ActiveJDBC Instrumentation plugin

Add the     following to the plugins section of the POM:

~~~~ {.xml  .numberLines}
<plugin>
    <groupId>org.javalite</groupId>
    <artifactId>activejdbc-instrumentation</artifactId>
    <version>1.4.13</version>
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

## Write a model

This is the easiest thing - writing a simple model is usually done with one line of code:

~~~~ {.java  .numberLines}
import org.javalite.activejdbc.Model;

public class Employee extends Model {}
~~~~

Please, note that the name of a table is "employees" - plural, and the name of a model is "Employee" - singular.
If you are wondering how this is done, you can take a look at the [Inflector](https://github.com/javalite/activejdbc/blob/master/javalite-common/src/main/java/org/javalite/common/Inflector.java#L120)
class.
ActiveJDBC uses inflections of English language to do conversion of plural and singular forms of words.
This of course can be overridden by a `@Table` annotation.

## Open a connection

~~~~ {.java  .numberLines}
Base.open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "user1", "xxxxx");
~~~~

Replace the values for the ones that make sense for your environment. Base is a utility class that allows to perform
some basic (hence the name) JDBC operations, one of them is opening a connection. The connection object is then attached
to the current thread, and can be consumed by any ActiveJDBC API.

## Create a new record

~~~~ {.java  .numberLines}
Employee e = new Employee();
e.set("first_name", "John");
e.set("last_name", "Doe");
e.saveIt();
~~~~

This is self-explanatory. Models are somewhat like maps. There are no setters or getters.
You can still write them if you like, see [Setters and getters](setters_and_getters) for more information.

The same logic can be written in one line:

~~~~ {.java  .numberLines}
new Employee().set("first_name", "John", "last_name", "Doe").saveIt();
~~~~

The framework has quite a few shortcuts like this one.

## Finding a single record

~~~~ {.java  .numberLines}
Employee e = Employee.findFirst("first_name = ?", "John");
~~~~

This line will find an instance of Employee (conditionally), if one exists, or null if one does not exist.

## Finding some records

~~~~ {.java  .numberLines}
List<Employee> employees = Employee.where("first_name = ?", "John");
~~~~

## Updating a record

This snippet should also be self-explanatory:

~~~~ {.java  .numberLines}
Employee e = Employee.findFirst("first_name = ?", "John");
e.set("last_name", "Steinbeck").saveIt();
~~~~

## Deleting a record

~~~~ {.java  .numberLines}
Employee e = Employee.findFirst("first_name = ?", "John");
e.delete();
~~~~

## Deleting all records

~~~~ {.java  .numberLines}
Employee.deleteAll();
~~~~

## Selecting all records

~~~~ {.java  .numberLines}
List<Employee> employees = Employee.findAll();
~~~~

## Sample project using Ant

If you are not using Maven, you can use Ant. Example of exactly the same project with all necessary dependencies can be found
here: [https://github.com/javalite/ant-example](https://github.com/javalite/ant-example) Please see README file there.

## Conclusion

This introduction provides enough information to get started. It also shows how simple ActiveJDBC APIs are.
This ORM has many advanced features, such as automatic recognition of associations, caching, validations, polymorphic
associations, etc. The code used on this page can be found in this simple project:
[https://github.com/javalite/simple-example](https://github.com/javalite/simple-example).

Enjoy :)
