<div class="page-header">
   <h1>ActiveJDBC</h1> 
   <h4>Fast ORM for agile development
</h4>

</div>


## Documentation

Follow to: [ActiveJDBC documentation](documentation#activejdbc)

## 5 minute introduction

For a simple example we will use a table called PEOPLE created with this MySQL DDL:

~~~~ {.sql}
CREATE TABLE people (
  id  int(11) NOT NULL auto_increment PRIMARY KEY,
  first_name VARCHAR(56) NOT NULL,
  last_name VARCHAR(56),
  created_at DATETIME,
  updated_at DATETIME
  );
~~~~

> ActiveJDBC infers DB schema parameters from a database. This means you do not have to provide it in code.

The corresponding model looks like this:

~~~~ {.java  .numberLines}
public class Person extends Model {}
~~~~

There is no code in the body of the class, and yet it is fully functional and will
map to a table called `PEOPLE` *automatically*. Read more on [English Inflections](english_inflections).


### How to query

Simplest query example:

~~~~ {.java  .numberLines}
List<Person> people = Person.where("first_name = 'John'");
Person aJohn = people.get(0);
String johnsLastName = aJohn.get("last_name");
~~~~

The `where()` method takes a snippet of real SQL. The first line above will generate this statement:
`SELECT * FROM people WHERE first_name = 'John'`.

Finder methods can also be parametrized:

~~~~ {.java  .numberLines}
List<Person> people = Person.where("first_name = ?", "John");
Person aJohn = people.get(0);
String johnsLastName = aJohn.get("last_name");
~~~~

The `where()` method takes a vararg, allowing unlimited any number of parameters to be passed into a statement.

### Paging through data

~~~~ {.java  .numberLines}
List<Employee> people = Employee.where("department = ? and hire_date > ? ", "IT", hireDate)
    .offset(21)
    .limit(10)
    .orderBy("hire_date asc");
~~~~

This query will ensure that the returned result set will start at the 21st record and will return only 10 records,
according to the `orderBy`. The ActiveJDBC has a built in facility for various database flavors and it will generate
appropriate SQL statement that is specific for a DB (Oracle, MySQL, etc) and is efficient. It will not fetch all
records, starting with 1.

### Creating new records

There are several ways to do this, and the simplest is:

~~~~ {.java  .numberLines}
Person p = new Person();
p.set("first_name", "Marilyn");
p.set("last_name", "Monroe");
p.set("dob", "1935-12-06");
p.saveIt();
~~~~

There is also a shorthand version of doing the same:

~~~~ {.java  .numberLines}
new Person().set("first_name", "Marilyn").set("last_name", "Monroe").set("dob", "1935-12-06").saveIt();
~~~~

and yet shorter one :

~~~~ {.java  .numberLines}
Person.createIt("first_name", "Marilyn", "last_name", "Monroe", "dob", "1935-12-06");
~~~~

### Updating a record

~~~~ {.java  .numberLines}
Employee e = Employee.findFirst("first_name = ?", "John");
e.set("last_name", "Steinbeck").saveIt();
~~~~

### Deleting a record

~~~~ {.java  .numberLines}
Employee e = Employee.findFirst("first_name = ?", "John");
e.delete();
~~~~

There are more ways to delete, follow [Delete cascade](delete_cascade) to learn more.

## Getting started

If you want to get started, follow these links:

Please, see [Getting Started](getting_started) for a working example.

Look through these:

* See [5 minute introduction](#minute-introduction)
* Familiarize yourself with [Instrumentation](instrumentation)

Other working examples:

* [Maven example](https://github.com/javalite/simple-example)
* [Ant example](https://github.com/javalite/ant-example)
* [Standalone example](https://github.com/javalite/standalone-example) - neither Maven nor Ant

Here is the [JavaDoc for ActiveJDBC](http://javalite.github.io/activejdbc/snapshot)


## Design principles

* Infers metadata from DB
* Convention-based configuration.
* No need to learn another QL. SQL is sufficient
* Code often reads like English
* No sessions, no "attaching, re-attaching"
* No persistence managers.
* Models are lightweight, simple POJOs
* No proxy-ing. What you write is what you get (WYWIWYG :))
* No getters and setters. You can still write them if you like.
* No DAOs and DTOs
* No [Anemic Domain Model](http://www.martinfowler.com/bliki/AnemicDomainModel.html)

## Supported databases

Currently the following databases are supported:

* SQLServer
* MySQL
* Oracle
* PostgreSQL
* H2
* SQLite3
* DB2

Adding a new dialect is relatively easy. Just look at commits on this branch: [h2integration](https://github.com/javalite/activejdbc/tree/h2integration)


## Releases

Please, refer to the [Releases](releases) page.

## Getting the latest version

For the latest version  refer to [ActiveJDBC on Maven Central](http://search.maven.org/#search%7Cga%7C1%7Corg.javalite.activejdbc).
If you use Maven add this to your pom:

~~~~ {.xml  .numberLines}
<dependency>
    <groupId>org.javalite</groupId>
    <artifactId>activejdbc</artifactId>
    <version>LATEST_VERSION</version>
</dependency>
~~~~

Do not forget to replace LATEST_VERSION with the latest version deployed to Maven Central (see above)


Additionally, configure Instrumentation plugin:

~~~~ {.xml  .numberLines}
<plugin>
    <groupId>org.javalite</groupId>
    <artifactId>activejdbc-instrumentation</artifactId>
    <version>LATEST_VERSION</version>
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

Or download from: [ActiveJDBC Instrumentation plugin on Maven Central](http://search.maven.org/#search%7Cga%7C1%7Ca%3A%22activejdbc-instrumentation%22)

## Getting latest snapshot versions

If you are using Maven, add these repositories to your pom:

~~~~ {.xml  .numberLines}
<repositories>
    <repository>
        <id>javalite-snapshots</id>
        <name>JavaLite Snapshots</name>
        <url>http://repo.javalite.io/</url>
        <releases>
            <enabled>false</enabled>
        </releases>
        <snapshots>
            <enabled>true</enabled>
        </snapshots>
    </repository>
</repositories>
<pluginRepositories>
    <pluginRepository>
        <id>javalite-plugin-snapshots</id>
        <name>JavaLite Plugin Snapshots</name>
        <url>http://repo.javalite.io/</url>
        <releases>
            <enabled>false</enabled>
        </releases>
        <snapshots>
            <enabled>true</enabled>
        </snapshots>
    </pluginRepository>
</pluginRepositories>
~~~~

If you are not using Maven, you can pull down the latest snapshots from here:
<a href="http://repo.javalite.io">JavaLite Repo</a>
