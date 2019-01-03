<div class="page-header">
   <h1>Sharding</h1>
</div>


Sharding is a method of spreading data across multiple tables. Please, see more on 
[Sharding and database architecture](https://en.wikipedia.org/wiki/Shard_(database_architecture)). 
While sharding can be a complicated architectural approach, and every database provides some sort of sharding, 
The ActiveJDBC has a built-in mechanism that is at the framework level, which makes it  available for all supported databases. 
 

## Changing table name at run time

It is now possible to change a table name associated with a model at runtime. 

For example, this code: 
 
~~~~ {.java .numberLines}
public class Person{}
~~~~

defines a model automatically mapped to a table PEOPLE according to [English Inflections](english_inflections). 

If this model's data is sharded across multiple tables (say named 'shard1_people', 'shard2_people', etc.), then 
you can change the table  name before using a model like this: 

~~~~ {.java .numberLines}
Person.metaModel().setShardTableName("shard2_people");
~~~~

> It is imperative that all tables representing shards for the same model MUST have exactly the same schema
 
## Propagation of table name 

The call: 

~~~~ {.java .numberLines}
Person.metaModel().setShardTableName("shard2_people");
~~~~

attaches a new table name for this model to a current thread using [ThreadLocal](http://docs.oracle.com/javase/7/docs/api/java/lang/ThreadLocal.html). 
This means that if you are using a thread pool (working within a web app), you might run into issues in case threads are re-used. 

Always ensure that you are cleaning the table name from a current thread: 

~~~~ {.java .numberLines}
Person.metaModel().clearShardTableName();
~~~~

The call above ensures that the model `Person` will revert to its natural table name (in this case `PEOPLE`). 
 
## Initialization of sharded models
 
Since models load their metadata (columns, types, etc) during runtime, there needs to be a base table that is always 
mapped to a model. 

There are two ways to go about this: 1. use of a base table, and 2. only use sharded tables. 

In the first scenario, you would have tables: `people`, `shard1_people`, `shard2_people`, `shard3_people`...
The model will look like this:

~~~~ {.java .numberLines}
public class Person{}
~~~~

So, the model `Person` will read the schema from table `people`, and will use it across all other tables. This is
why it is so important that all these tables have exactly the same structure.

In the second scenario, you would only have sharded tables: `shard1_people`, `shard2_people`, `shard3_people`. 
You would use one of the sharded tables as a model base table:

~~~~ {.java .numberLines}
@Table("shard1_people")
public class Person{}
~~~~

It is up to you which scenario to choose. 

## Table name strategy

The strategy for changing the name of a table for a model is external to ActiveJDBC framework. You, the developer
choose when to change it and to what value. However, we can recommend a few typical approaches for these cases: 

1. You use ActiveWeb: we recommend creating a [Controller Filter](controller_filters) and make changes to 
specific model table names in the `before()` method. The logic for this can be anything: date, user name, session, etc.

2. You develop web app and it is not ActiveWeb. We recommend creating a [Servlet Filter](http://www.oracle.com/technetwork/java/filters-137243.html)
 and putting logic there, the same way as in #1

3. You develop a standalone app (console, or desktop). We recommend to use some sort of 
[Aspect-Oriented programming](https://en.wikipedia.org/wiki/Aspect-oriented_programming) in order to keep 
 logic for changing table names out of business logic.  

 


