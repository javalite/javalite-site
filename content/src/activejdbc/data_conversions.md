<div class="page-header">
   <h1>Data conversions</h1>
</div>


## Pass-through framework

Please, see [Pass-through framework](pass_through_framework) for more information on data conversions.  

## How to see mapped type

This is pretty easy, insert a record into a table using standard DBMS tools, and then query it like this:

~~~~ {.java  .numberLines}
Person p = Person.findAll().get(0);
System.out.println("DOB type: " + p.get("dob").getClass());
~~~~

## Convenience conversion methods

> Convenience conversion methods are used after data was loaded into models due to read operations

ActiveJDBC provides a number of getter methods for conversion. Most conversions use the
underlying [Convert](http://javalite.github.io/activejdbc/snapshot/org/javalite/common/Convert.html) class. Here are some examples:

~~~~ {.java  .numberLines}
Date date = person.getDate("dob");
Boolean projectCompleted = project.getBoolean("completed");
~~~~

Most all types can be converted to String, including a CLOB. Consider this example, where column CONTENT is defined as CLOB:

~~~~ {.java  .numberLines}
String text = article.getString("content");
~~~~



Here is a list conversion getters available in models: 

~~~~
BigDecimal	getBigDecimal(String attributeName)
Boolean	getBoolean(String attributeName)
byte[]	getBytes(String attributeName)
Date	getDate(String attributeName)
Double	getDouble(String attributeName)
Float	getFloat(String attributeName)
Integer	getInteger(String attributeName)
Long	getLong(String attributeName)
Short	getShort(String attributeName)
String	getString(String attributeName)
Time	getTime(String attributeName)
Timestamp	getTimestamp(String attributeName)
~~~~



## Converters


> Converters are triggered during model save operations

A [Converter](http://javalite.github.io/activejdbc/snapshot/org/javalite/activejdbc/conversion/Converter.html) can convert values from one type to another. Currently there are a few converters available: blank to null, zero to null, date (date to string and string to date), and timestamp (timestamp to string and string to timestamp).

Converters will always convert from the original type of the value (for example, java.lang.String for a value like "1926-06-01") to the type of the convenience conversion method called, and they are registered to model attributes. So for the `setDate("dob", "1926-06-01")` call, if there is a converter from String (original value type) to java.sql.Date (setting a date with setDate) registered for the attribute "dob", it will be used and the value set will be of type java.sql.Date. The same applies to getters, the other way around.

### Date converters

Date converters can do conversions between formatted string and java.sql.Date. Here is an example that registers date converters to "dob" attribute:

~~~~ {.java  .numberLines}
public class Person extends Model {
    static {
        dateFormat("MM/dd/yyyy", "dob");
    }    
}
~~~~

and here how to use them:

~~~~ {.java  .numberLines}
Person p = new Person();

// will convert String to java.sql.Date
p.setDate("dob", "06/23/1912"); 
// will convert Date to String, if dob value in model is of type Date
String str = p.getString("dob"); 

// will convert Date to String
p.setString("dob", new Date());
// will convert String to java.sql.Date, if dob value in model is of type String
Date date = p.getDate("dob");
~~~~

### Timestamp converters

Timestamp converters are identical to date converters, but do conversion to and from java.sql.Timestamp. Here is an example of declaration:

~~~~ {.java  .numberLines}
public class Message extends Model {
    static{
        timestampFormat("yyyy.MM.dd G 'at' HH:mm:ss z", "send_time");
    }
}
~~~~

### Blank-to-null converter

The blank to null converter transforms any `java.lang.String` values that are empty or contain only whitespaces to null. 
It works with any getter or setter. Here is an example that registers it to two attributes:

~~~~ {.java  .numberLines}
public class Person extends Model {
    static {
        blankToNull("name", "last_name");
    }    
}
~~~~

### Zero-to-null converter

The zero to null converter works as the blank to null converter, but transforms `java.lang.Number` values that are equal 
zero to null. Here is example of declaration:

~~~~ {.java  .numberLines}
public class Salary extends Model {
    static {
        zeroToNull("bonus");
    }    
}
~~~~

## Custom setters and getters

If you like more control over types, you can provide typed getters and setters:

~~~~ {.java  .numberLines}
public class Person extends Model{
    public void setName(String name){
       set("name", name);
    }
    public void setDob(Date dob){
       set("dob", dob);
    }
}
~~~~

and then use it like this:

~~~~ {.java  .numberLines}
Person p = new Person();
p.setName("John");
p.setDob(new Date(12345L));
~~~~

For more information on setters and getters, see [Setters and getters](setters_and_getters)

## What happens if I stick a wrong type?

If you do this:

~~~~ {.java  .numberLines}
Student p = new Student();
p.set("first_name", "John");
p.set("last_name", "Doe");
p.set("dob", 1); // ===>>  this is wrong type for DOB field
p.saveIt();
~~~~

you are going to get an exception from the DBMS itself, if it cannot convert the type:

~~~~ {.java  .numberLines}
org.javalite.activejdbc.DBException: com.mysql.jdbc.MysqlDataTruncation: Data truncation: Incorrect date value: '1' for column 'dob' at row 1, Query: INSERT INTO students (first_name, dob, last_name) VALUES (?, ?, ?), params: John,1,Doe
    at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:2868)
    at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:1573)
    at com.mysql.jdbc.ServerPreparedStatement.serverExecute(ServerPreparedStatement.java:1169)
    at com.mysql.jdbc.ServerPreparedStatement.executeInternal(ServerPreparedStatement.java:693)
~~~~

ActiveJDBC is a *pass-through* framework - it will pass data to lower level to handle.

## Different data types for the same attribute

Is this possible? Yes, for instance, take this example:

~~~~ {.java  .numberLines}
p.set("dob", "2011-12-3");
p.saveIt();
~~~~

This will work for MySQL, and the driver will convert the String "2011-12-3" during insert or update. However, if you retain a reference to this model, the internal value type is going to remain String.

## Should I care about types?

Not so much. Just use the models with types you think are appropriate, and ActiveJDBC together with the driver will handle most of what you need. In case you get a conversion exception from the driver, do a due diligence then.
