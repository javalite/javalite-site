<div class="page-header">
   <h1>ActiveJDBC & Kotlin</h1>
</div>


## Dependency Setup

In order to setup ActiveJDBC with Kotlin, add the [ActiveJDBC dependency](/activejdbc#getting-the-latest-version) 
as well as the Kotlin module: 

~~~~ {.xml}
<dependency>
    <groupId>org.javalite</groupId>
    <artifactId>activejdbc-kt</artifactId>
    <version>LATEST_VERSION</version>
</dependency>
~~~~

## Instrumentation

Setting up instrumentation is not any different, please follow instructions [here](instrumentation). 


## Usage

Unlike the Java layer, the Kotlin layer offers two similar ways of setting up a model.


### Approach #1

First define an entity

~~~~ {.java}
import org.javalite.activejdbc.Model;
import org.javalite.activejdbc.CompanionModel;

open class Person():Model() {
    companion object:CompanionModel<Person>(Person::class)
}
~~~~


Then use it as in Java

~~~~ {.java}
val person:Person = Person.findById(1)
~~~~


### Approach #2 (with English inflections)

The first class is only for the entity itself

~~~~ {.java}
import org.javalite.activejdbc.Model;

open class Person():Model()
~~~~



The second class stands for the table and its name matches English inflection (Person => People)

~~~~ {.java}
import org.javalite.activejdbc.CompanionModel;

open class People {
    companion object:CompanionModel<Person>(Person::class)
}
~~~~

Usage: 

~~~~ {.java}
val person:Person = People.findById(1L)
~~~~
