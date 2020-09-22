
<div class="page-header">
   <h1>Basic database operations</h1>
</div>


## Introduction

ActiveJDBC architecture has two layers: 

* Lower layer: Base  and DB classes
* Higher layer: Models as described in the [ActiveRecord pattern](https://en.wikipedia.org/wiki/Active_record_pattern).

The first layer is provided by two classes, `org.javalite.activejdbc.Base` and `org.javalite.activejdbc.DB`.
  
These two classes  mirror each other and provide two functions:

* [Database connection management](/database_connection_management)  
* Convenience access  over plain JDBC API. 

The differences and similarities of the `Base` and `DB` are described  on the  [Database connection management](/database_connection_management) page. 

The goal of this page is to familiarize the  user with the  rest of the functions of these two classes. 
 
> Moving forward,  all examples will be based on the Base class, considering only  one database connection. 
The reader can extrapolate the below examples for the `DB` class if  more than one connection isd needed.

The rest of the documentation (all other  pages) related to database access  describe a "Higher layer" access to data, see the [documentation](/documentation) page.  
 

## Batch operations 

See description on a page [Batch operations](/batch_operations)    


## Try-with-resources usage

When accessing a database,  you can run into exceptions (surprise!). While `Base` and `DB`  classes wrap all checked JDBC exceptions into subclasses of 
a `RuntimeException`, there is still a need to manage exceptions. Additionally, the DB class is an instance  of a Closeable interface, and the `Base.open(..)` methods
return an instance of a `DB`, which makes it easy to write code such as: 

```java
try(DB db = Base.open()){
   // use the connection on the  thread with the Base class or with models 
}
```
The code above will automatically close the  JDBC connection when  it exits.

The same as above, but with Lambdas; 

```java
Base.withDb(() -> {
        // some code that uses a connection
});

```

## Dumping data 

If you are [running tests](testing_with_db_connection) against a test database using `DBSpec` or its subclasses, 
the test database is always empty. This makes it harder to check the values of some table during a test. 
Here is a simple hack: 

```java
public void shouldDoX(){
    //send some test data to the database
    Base.findAll("select * from users").dump(); 
    //perform a test that changes data
    Base.findAll("select * from users").dump(); 
}
```
The line `Base.findAll("select * from users").dump();` will simply pull all records from the `users` table and will dump them to STDIO. 

This is a convenience method for  testing. 
   
   
## Reading entire dataset.

When  you need to read an entire dataset from a table(s), you can use this method: 

```java
    List<Map> usersList = Base.findAll("select * from users where company_id = ? ", companyId);
    for(Map  record: userList){
        System.out.println("first_name: " + record.get("first_name"));
        System.out.println("last_name: " + record.get("last_name")); 
    }
``` 

The query is anything you would type into a database console.  You can use joins, sorts, etc. The important thing to 
keep in mind is that you will read entire dataset into that list.

Each map will have keys that map to the columns  of the underlying resultset. 

> This example gives you a hint that the `Base` and `DB` classes are used by models under the hood! 


 *WARNING*: The example above will load a entire resultset in heap, be careful with your query!
 
## Streaming large resultsets

The example above will get you all records at once. What if you have millions of records to process? 
The example below will allow you to do just that: 


```java
Base.find("select first_name, last_name from really_large_table", ....).with(new RowListenerAdapter() {
         public void onNext(Map row) {
                 ///write your code here
                 Object o1 = row.get("first_name");
                 Object o2 = row.get("last_name");
             }
         });
```  
See more at:[Base.find](http://javalite.github.io/2.3.2-j8/org/javalite/activejdbc/DB.html#find-java.lang.String-org.javalite.activejdbc.RowListener-). 


## Reading a single value 

Sometimes  you need to do  just that!

```java
Long  lastLoginTime = Convert.toLong(Base.firstCell​("select time from logins  where user_id  ? order by created_at limit 1", 123));
```
The code above will be returning a first column of the first row returned from the database and will ignore all other values!
  
## Reading a single column

```java
  List ssns = Base.firstColumn("select ssn from people where first_name = ?", "John");
  for(Object ssn: ssns)
      System.out.println(ssn);
``` 

Just like the `firstCell`, this method will ignore any other values beyond a first column, so ensure your quiery only selects a single column. 
  
## Batch operations 


The base and DB classes also provide  an API  for [batch operations](/batch_operations). 


## JavaDoc

For more information, follow to the [Base JavaDoc](http://javalite.github.io/2.3.2-j8/org/javalite/activejdbc/Base.html).
 




 
