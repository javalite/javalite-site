<div class="page-header">
   <h1>Pass-through framework</h1>
</div>


Unlike other ORMs, ActiveJDBC is a Pass-Through framework. It means that ActiveJDBC is not trying to be smart, but rather 
relies on underlying technology to pass data back and forth. It enables it have less magic, and makes it faster and leaner. 
Most older ORMs (Hibernate) do retain  references to related objects, but they were also created in the client-server days. 
 
Today, 99% of modern business
 application development has moved to the web (and web services). ActiveJDBC was built for the web, where models are 
 assembled together for a brief moment of time (serving one web request), used to generate a view (HTML, XML, JSON, etc.)
  and immediately discarded. 
  
In a context of short web requests, the Pass-through framework is smaller, faster, and simpler than the one that is 
based on reference graphs.
 
ActiveJDBC also does not attempt (by default) to convert data types but rather relies on the underlying JDBC driver for 
most data conversions during read and write operations. Most database drivers do a great deal of conversion

## Loading records

When loading child records, the parent used to load children does not retain references to children. Consider this: 

~~~~ {.java .numberLines}
 Author author = Author.findById(1);
 List<Articles> articles2015 = author.get(Article.class, "year = ?", 2015);
~~~~

The `author` does not retain references to articles, and if the same articles are requested from the author again, it 
 will again result in a trip to the database. 

## Storing records

When storing records, either as `model.save()`, `parent.add(child)` or any similar methods, the framework simply stored 
related information into appropriate table(s). The parent model does not retain a reference to a child model.
 
Example: 

~~~~ {.java .numberLines}
 Author author = Author.findById(1);
 author.add(new Article("How to use ActiveJDBC"));
 List<Article> articles = author.get("title = ?", "How to use ActiveJDBC").limit(1); 
~~~~

In a code sample above, the last line will fetch a record from the database because a previous line was simply used 
   to generate a new INSERT statement.

 

## Loading attributes

Think of a model as a Map. It has keys (attribute names) and values (attribute values). 
The keys are type of `java.lang.String` and mimic the underlying table's column names. The values are whatever you 
set using setter methods, or whatever comes from the database. 

> During select operations, the driver will populate your models with whatever types that are
mapped from DB table columns to appropriate Java types.

In other words, whatever the JDBC Driver loads, becomes the type of your attribute value.

For more on this, see [Data conversions](data_conversions). 

## Storing attributes

During inserts or updates, the DBMS driver will perform conversions where necessary
and possible. In cases a conversion is not possible, you are going to get a runtime exception from DBMS (see below)

For more on this, see [what happens if i stick a wrong type](data_conversions#what-happens-if-i-stick-a-wrong-type)? 

## Delete cascade and frozen

The side effect of ActiveJDBC being a Pass-through framework is that when deleting models with cascade, 
it cannot propagate "frozen" states. Here is an example: 
 
~~~~ {.java .numberLines}

Book book = new Book("All Quiet on the Western Front");
Author author = new Author("Erich Maria Remarque").
author.saveIt();
author.add(book); // book saved into child table
author.deleteCascade();
~~~~

The last line will result in the two DELETE statements: 

~~~~
DELETE FROM books WHERE author_id = ?
DELETE FROM authors WHERE id = ?
~~~~

As you can see, there were two queries issued to the database, the first one deleting all books (children) of the author.
The side effect of this is that the instance of `Book` in memory is not aware that its underlying data is gone, 
and as a result the `frozen()` will return incorrect value: 

~~~~ {.java .numberLines}
book.frozen() // < -- will return false. 
~~~~

While this is unpleasant, the only way to fix this is to retain references to child objects in memory which will make the 
 framework more complicated and slower.
  
Generally in web applications this will not happen, but in cases of desktop apps, the developers need to be aware of this 
behavior. 
