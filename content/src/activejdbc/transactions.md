<div class="page-header">
   <h1>Transactions</h1>
</div>



The goal of AciveJDBC from the ground up was to be a very thin veneer on top of JDBC. As such, the attention was
given to simplify the DB access API, but at the same time not take control away from a developer.

## Basic flow of DB program

In any DB - backed program, you would:


* Open connection
* Do stuff
* Close connection

Usually in Java ORMs there is an explicit connection or a manager object (EntityManager in JPA, SessionManager in Hibernate, etc.).
Such an object is absent in ActiveJDBC.

## Simple ActiveJDBC Example

Here is an example of the most basic of the ActiveJDBC application without transaction management:

~~~~ {.java  .numberLines}
public static void main(String[] args) {
   Base.open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "the_user", "the_password");
   Employee e = new Employee();
   e.set("first_name", "John");
   e.set("last_name", "Doe");
   e.saveIt();
   Base.close();
}
~~~~

The call `Base.open()` opens a connection and attaches it to the current thread. All subsequent methods of all models
reuse this connection. The call `Base.close()` closes connection and removes it from the current thread.

## Transaction related APIs

...so far so good, but to transactions. ActiveJDBC does provide a few transaction-related convenience calls:

Starting transaction:

~~~~ {.java  .numberLines}
Base.openTransaction();
~~~~

Committing transaction:

~~~~ {.java  .numberLines}
Base.commitTransaction();
~~~~

and rolling back:

~~~~ {.java  .numberLines}
Base.rollbackTransaction();
~~~~

All these methods simply call `java.sql.Connection.setAutocommit(false)`, `java.sql.Connection.commit()` and `java.sql.Connection.rollback()`
respectively, wrapping exceptions and logging events at INFO level.

As you can see, ActiveJDBC is not trying to do much here, just trying to not get in the way.

In cases where you need a finer control, you can get a current connection and perform pure JDBC operations on it:

~~~~ {.java  .numberLines}
java.sql.Connection con = Base.connection();
con.setAutocommit(false);
...//or:
Base.connection().setAutocommit(false);
~~~~

## Transacted ActiveJDBC Example

A simple program using transactions will look like this:

~~~~ {.java  .numberLines}
public static void main(String[] args) {
   try{
      Base.open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/test", "the_user", "the_password");
      Base.openTransaction();
      Employee e = new Employee();
      e.set("first_name", "John");
      e.set("last_name", "Doe");
      e.saveIt();
      Base.commitTransaction();
   catch(Exception e){
      Base.rollbackTransaction();
   }finally{
      Base.close();
   }
}
~~~~

## Transactions with JNDI

Usually though, a connection is requested from a pool of a container, and transaction configuration is already
provided by container configuration. In these cases, the usage is the same (almost), but you have to be aware
that that some calls might not succeed, or you might have unexpected side effects by the driver.
For example, if you request a connection from a pool, the transaction might start then, and when you call:

~~~~ {.java  .numberLines}
Base.connection().setAutocommit(true/false);
~~~~

, you might accidentally commit a transaction in progress (...or driver will ignore your call and do nothing).

ActiveJDBC does not add anything special here to what J2EE and JDBC already provide.

Here is an example of ActiveJDBC used in a MessageDriven Bean (JMS):

~~~~ {.java  .numberLines}

public void onMessage(Message m){
   Base.open("myConnectionJNDIName");
   TextMessage tm = (TextMessage)m;
   String content = tm.getText();
   String name = tm.getStringProperty("name");
   try{
      Article.create("name", name, "content", content).saveIt();
   }
   catch(Exception e){
     ctx.setRollbackOnly(); // == this will send the message back into queue
   }
   finally{
      Base.close();//always close connection
   }
}
~~~~

In the example above, the container will manage transactions. It will roll back both: the JDBC, as well as JMS transactions.
