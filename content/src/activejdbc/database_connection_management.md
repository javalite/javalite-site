<div class="page-header">
   <h1>Database connection management</h1>
</div>



ActiveJDBC provides two classes for connection management: [Base.java](http://javalite.github.io/activejdbc/org/javalite/activejdbc/Base.html)
and [DB.java](http://javalite.github.io/activejdbc/snapshot/org/javalite/activejdbc/DB.html).

## Thread connection propagation

ActiveJDBC models when operate, utilize a connection found on a current thread. This connection is put on the local thread by
Base or DB class before any DB operation. This approach allows for more concise API where there is no need for DB Session or persistent
managers as in other Java ORMs.

Here is a simple program:

~~~~ {.java  .numberLines}
public static void main(String[] args) {
   Base.open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "the_user", "the_password");
   Employee.findAll().dump();
   Base.close();
}
~~~~

On line 2, class Base will open a new connection and attach it to the current thread. This connection will also be
marked with name "default".

On line 3, connection is looked up from the thread and used by the model(and result dumped to STDIO)

On line 4, connection is closed and cleared from thread.

## Database names

ActiveJDBC has a concept of a logical "database". However, an application can be connected to multiple databases at
the same time. In this case, ActiveJDBC allows for assigning different logical names to different databases.

For example, one might have an Oracle database with accounting data, and a MySQL database with inventory control data.
In this case, you might want to have an "accounting" database and an "inventory" database as logical names assigned
to these databases.

## DB and Base classes

Opening and closing connections is done with classes Base or DB. The DB class is used in cases where you have more
than one database in the system, such as "accounting" and "inventory".

Example:

~~~~ {.java  .numberLines}
new DB("inventory").open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "dbuser", "...");
~~~~

In this code example, there is a database connection opened, and attached to a local thread under name "inventory".

The classes Base and DB mirror one another, having exactly the same APIs, except:

-   All methods on DB are instance methods, while all methods on class Base are static ones.
-   class DB constructor accepts a DB name, while Base always operates with DB name: "default"

This means that these lines are equivalent:

~~~~ {.java  .numberLines}
new DB("default").open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "root", "p@ssw0rd");
~~~~

and:

~~~~ {.java  .numberLines}
Base.open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "root", "p@ssw0rd");
~~~~

> Use `Base` class if you have only one database in the system, otherwise, use `DB`.

## Use Try-with-resources

You can use the try-with-resources to automatically close a connection regardless if your code causes exception or not: 

~~~~ {.java  .numberLines}
try(DB db = new DB()){
  db.open();
  // your code here
}
~~~~

## Use with Lambdas

If you static-import `Base.withDB()`, you can execute code in the context of a 
connection using a simple block like this: 

~~~~ {.java  .numberLines}
withDb(() -> {
        // some code that uses a connection
}); 
~~~~

There are various versions of `withDB` on classes [DB](http://javalite.github.io/activejdbc/snapshot/org/javalite/activejdbc/DB.html#withDb-javax.sql.DataSource-java.lang.Runnable-) 
and [Base](http://javalite.github.io/activejdbc/snapshot/org/javalite/activejdbc/Base.html#withDb-javax.sql.DataSource-java.lang.Runnable-). 


## Models associated with multiple databases

ActiveJDBC allows to have a mix of models in the application representing tables from different databases. By default
a model belongs to a database "default", but an association of a model to a database can be overriden with annotation `@DbName`:

~~~~ {.java  .numberLines}
@DbName("corporation")
public class Employee extends Model {}
~~~~

## Multiple database example

See sources here: [multimple-db-example](https://github.com/javalite/multiple-db-example).

For this example, we will have two models, one representing a table in Oracle database, while the other in MySQL

The two models are defined like this:

~~~~ {.java  .numberLines}
@DbName("corporation")
public class Employee extends Model {}
~~~~

and:

~~~~ {.java  .numberLines}
@DbName("university")
public class Student  extends Model {}
~~~~

and the main class looks like this:

~~~~ {.java  .numberLines}
public class Main {
    public static void main(String[] args) {
        new DB("corporation").open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "root", "p@ssw0rd");
        new DB("university").open("oracle.jdbc.driver.OracleDriver", "jdbc:oracle:thin:@localhost:1521:xe", "activejdbc", "activejdbc");

        Employee.deleteAll();
        Student.deleteAll();

        Employee.createIt("first_name", "John", "last_name", "Doe");
        Employee.createIt("first_name", "Jane", "last_name", "Smith");

        Student.createIt("first_name", "Mike", "last_name", "Myers");
        Student.createIt("first_name", "Steven", "last_name", "Spielberg");

        System.out.println("*** Employees ***");
        Employee.findAll().dump();
        System.out.println("*** Students ***");
        Student.findAll().dump();

        new DB("corporation").close();
        new DB("university").close();
    }
}
~~~~

At the start of this app the two named connections are opened, then we proceed to use the models associated
with these connections. At the end of the app, the two named connections are closed. The class DB is lightweight,
and it is OK not to retain a reference to it, but rather to create a new instance each time.
If you do want to retain a reference, there is no harm done though.

## Database connection pools

ActiveJDBC does not maintain connection pools and does not integrate with any pools. Instead, it provides a
few `DB.open()` and `Base.open()` methods to open connections. If a version of methods used that takes standard JDBC
parameters, then no pool is used this is only a convenience method to open a brand new connection, such as:

~~~~ {.java  .numberLines}
Base.open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "root", "pwd");
~~~~

If however, this call is used:

~~~~ {.java  .numberLines}
Base.open("java:comp/env/jdbc/testdb");
~~~~

it will use a JDNI name to lookup a connection. Usually this is called from within a container and the name points
to a pooled JNDI DataSource.

If you want to work directly with some connection pool, you can do so by feeding a datasource to Base/DB class:

~~~~ {.java  .numberLines}
new DB("default").open(datasourceInstance);
~~~~


## Multiple environments (property file method)

The easiest way to configure multiple connections for different environments is to use a property file. 
 By convention, this file is called `database.properties` and located at the root of classpath. 

Here is an example of such a file:


~~~~
development.driver=com.mysql.jdbc.Driver
development.username=user1
development.password=pwd
development.url=jdbc:mysql://localhost/acme_development

test.driver=com.mysql.jdbc.Driver
test.username=user2
test.password=pwd
test.url=jdbc:mysql://localhost/acme_test

production.jndi=java:comp/env/jdbc/acme

~~~~

In order for this to work, you need to configure an environment variable `ACTIVE_ENV` to a value that is equal to a 
property set key.  According to a file above, the `ACTIVE_ENV` can take on values `development` and `production`. 
The `test` is special because it is used in development environment, but for running tests. 

Once the file is configured and placed at the root of classpath, you would open connections with a no-argument 
method like this: 

~~~~ {.java .numberLines}
new DB("default").open();
~~~~
 
A configuration related to the current environment will be selected and used to open a connection. This makes it easy 
to develop applications that live on different environments, and simply "know" where to connect on each. 

> If environment variable `ACTIVE_ENV` is not defined, the framework defaults to environment `development`.


## Location of property file

### Using system property
 
You can tell the framework the location of the file by supplying a system property at the start of your program: 

```
java com.company.project.Main -cp myprogram.jar -Denv.connections.file=/path/to/file/database.properties
```
 
Even if you have `database.properties` packaged into your Jar/war file, this setting will override the packaged file. 
Use it for production environments where database passwords cannot be checked into source control.

### Using `activejdbc.properties`

In some cases it is inconvenient to bundle the `database.properties` file with class files on classpath. 
There can be different reasons for it: you want to be able to change passwords, do not want to commit credentials to
code repoository, etc. 

The database connection properties file can be given any name and can reside on a file system somewhere. 


Here is how to configure: 

Add a file `activejdbc.properties` to your project at root of classpath and configure a property in it: 

~~~~
env.connections.file=/etc/my_project123/database.properties
~~~~

Then, simply add connection properties to the file as usual. The methods `DB.open()` and `Base.open()` will locate 
a connection from this file using the usual `ACTIVE_ENV` conventions.
 
 

## Environment variables override

In some cases you will need to specify parameters as environment variables. 
This may happen on cloud based-environments such as Heroku, Jenkins CI, etc. 
If you use direct JDBC parameters, there are 4 environments variables you can use: 

~~~~
ACTIVEJDBC.URL
ACTIVEJDBC.USER
ACTIVEJDBC.PASSWORD
ACTIVEJDBC.DRIVER
~~~~

If you use JNDI connection, you can use 1 environment variable: 

~~~~
ACTIVEJDBC.JNDI
~~~~

These are self-explanatory JDBC connection parameters. 

> Environment variable - based parameters will override any configuration provided in the `database.properties` file for current environment.


## System properties override

In some cases you will need to specify connection parameters as JVM system properties. 
If you are using standard JDBC parameters, there are 4 system properties you can use: 

~~~~
activejdbc.url
activejdbc.user
activejdbc.password
activejdbc.driver
~~~~

If you are using JNDI, the system property is: 

~~~~
activejdbc.jndi
~~~~

> System properties - based configuration will override any configuration provided as environment variables as 
> well as by the  `database.properties` file for current environment.


## Specifying DB Schema

In most cases you do not need to worry about this. However, for Oracle and PostgreSQL, some schema elements may leak
into your account if a schema is not specified. If you find that your model for instance has an attribute(column)
that is not part of this table description, it means that the DB mixed in this column from another table (public schema)
that has the same name as your table.

In a case like this, you need to specify a schema for a database. If you use a default database,
simply add this system property:

~~~~ {.prettyprint}
-Dactivejdbc.default.schema=myschema
~~~~

where "default" is a name of a database and "myschema" is a name of your schema in Oracle or PostgreSQL.

In case you do use multiple connections to different databases and you use DbName annotation, replace "default"
to your DB name. For example:

~~~~ {.java  .numberLines}
@DbName("university")
public class Student extends Model{}
~~~~

then you can add a property like this:

~~~~ {.prettyprint}
-Dactivejdbc.university.schema=myschema
~~~~

> The schema specification is used in order to retrive metadata for tables at start time, and not used in generating queries. 
