<div class="page-header">
   <h1>Record selection</h1>
</div>


## Writing a Model

Lets say this is SQL for the DB table (for MySQL)

~~~~ {.sql}
CREATE TABLE people (
   id  int(11) DEFAULT NULL auto_increment PRIMARY KEY,
   name VARCHAR(56),
   last_name VARCHAR(56),
   dob DATE,
   graduation_date DATE,
   created_at DATETIME,
   updated_at DATETIME
   );
~~~~

Simple models are written in one line of code. No need for setters or getters.

~~~~ {.java  .numberLines}
public class Person extends Model {}
~~~~

Tip: name of the model reflects a singular form of the table name. ActiveJDBC models feel similar to Map interface (although they do not implement it).
In order to access a model attributes, you usually use built-in dynamic setters and getters:

~~~~ {.java  .numberLines}
person.get("first_name");
...
person.set("first_name", "John");
~~~~

## Simple selection

~~~~ {.java  .numberLines}
List<Person> list = Person.where("name = 'John'");
~~~~

This will search a table PEOPLE. The framework will generate a SQL similar to this one:

~~~~ {.sql}
SELECT * FROM PEOPLE WHERE name = 'John'
~~~~

As you can see, the framework generates the query from SELECT to the WHERE. The only part that the developer is
required to provide is the actual criteria. This is just plain old SQL, albeit only a portion.

## Parametrized search

~~~~ {.java  .numberLines}
List<Person> list = Person.where("name = ?", "John");
~~~~

In this case, the value "John" will be substituted for a question mark. The number of question marks and substitute values is flexible, but must match one another.

## Processing large result sets

In all previous results, the entire result set was loaded into memory. This approach is fine in case of relatively small results,
but might prove a performance bottleneck for very large data sets. The approach below is somewhat reminiscent of SAX approach,
where a super large data set from a DB is read, and for every one record found, it produces a callback.
Within that callback, you perform whatever operation that makes sense for the application. The advantage of this
approach is not needing to allocate a ton of memory. This is usually a preferred method for batch processes. Think of this as streaming
of data from the database.

~~~~ {.java  .numberLines}
Person.find("name='John'", new ModelListener<Person>() {
    public void onModel(Person person) {
        System.out.println("Found person: " + person);
    }
});
~~~~

## Finding one record

Finding just one record can be achieved with `findFirst` method. As name suggests, even if the query can result in multiple records, only the first one is returned.

~~~~ {.java  .numberLines}
Person person = Person.findFirst("id = 2");
//parametrized:
person = Person.findFirst("id = ?", 2);
...
~~~~

## Finding all records

This is a method or returning all records from a table, use carefully as this will load them all into memory (when you start
processing the result, not when this method is called)

~~~~ {.java  .numberLines}
List<Person> list = Person.findAll();
for(Person p: list){   //<==== this line of code will initiate the actual query to DB
   System.out.println(p);
}
~~~~


## Dumping all records

This convenience method is used while writing tests.

~~~~ {.java  .numberLines}
Person.findAll().dump();
~~~~

Statement above will dump all records into standard output. Do not execute for large data sets.

## Create and save

There are many (more concise) methods of creation of models, this is being the most simple and self-explanatory:

~~~~ {.java  .numberLines}
Person p = new Person();
p.set("first_name", "Marilyn");
p.set("last_name", "Monroe");
p.set("dob", "1935-12-06");
p.saveIt();

System.out.println(p.getId());// <== this will print an ID assigned by DB.
~~~~

See more ways to [Create records](record_creation)

## Metadata is used to check valid attributes

If you look at the SQL at the top of this page, you will see that the table backing up the model does not have a column "name1".
Since the framework will interrogate the DB at the startup and retrieve all metadata information for each table,
it will know which model has which attributes. As such, setting a wrong attribute will generate a runtime exception.

~~~~ {.java  .numberLines}
Person p = new Person();
p.set("name1", "Bob"); //<=== this will throw exception
~~~~

Here is an example exception (generated from code snippet above):

~~~~ {.prettyprint}
java.lang.IllegalArgumentException: Attribute: 'name1' is not defined in model: 'class activejdbc.test_models.Person', available attributes: [id, updated_at, graduation_date, dob, name, last_name, created_at]
...
~~~~

We often cause this exception in tests on purpose, just to see the attributes of a model in question.

## Lookup and save

Putting it together, it is trivial to look up data from DB, modify it, and then save.

~~~~ {.java  .numberLines}
List<Person> list = Person.find("id = 1");
Person p = list.get(0);
p.set("name", "Bob");
p.saveIt();
~~~~

## Find by id

This is self-explanatory. If you know the ID, it is easy to get the model that represents this record.

~~~~ {.java  .numberLines}
Person p = Person.findById(1);
~~~~

## Count all records

Counting all records is as simple as calling the "count()" method

~~~~ {.java  .numberLines}
long personCount = Person.count();
~~~~

## Conditional count

Counting some records is equally easy, all you have to do is to provide criteria.

~~~~ {.java  .numberLines}
long johnCount = Person.count("name = ? ", "John");
~~~~

## Use raw SQL

In case, a query is really complicated, you can always resort to raw SQL like this:

~~~~ {.java  .numberLines}
List<Book> books = Book.findBySQL("select books.*, address from books, libraries where books.lib_id = libraries.id order by address");
~~~~

The only requirement to this method is that your select statement should select all columns from a table that this model represents. Since model knows which attributes belong to it, it will pluck them from the result set, and you will have a normal list of models (Book in this case) that are initialized from your query.

