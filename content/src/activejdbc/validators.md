<div class="page-header">
   <h1>Validators</h1>
</div>

This page describes a list of the built-in validators, and also shows how to build custom ones.  


## AttributePresenceValidator

This class provides a way to detect presence of attributes on an `Validatable`. 
The `Validatable` can be a simple object, or an ActiveJDBC Model. 

Example, say you have a class: 

```java
public class Book extends ValidationSupport {
    private String title, isbn, authorFirstName, authorLastName;
    public Book() {
        validatePresenceOf("title", "authorFirstName");
    }
    //setters and getters below
}
```
You can check validations on it this way: 

```java
Book book = new Book();
book.setTitle("one flew over the cuckoo's nest");
System.out.println(book.isValid()); // will print false because the authorFirstName is not set.  

```

## DateValidator

Validates the date format. Class definition:

```java
public class Person extends ValidationSupport {
    private String firstName, lastName, dob, email;
    public Person(String firstName, String lastName, String dob, String email) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        validateWith(new DateValidator("dob", "yyyy-MM-dd"));
    }
}
```

Example usage: 

```java
Person person = new Person("John", "Doe", "abx-22-02", null);
System.out.println(person.isValid()); // will print false because the dob format is invalid
System.out.println(person.errors().get("dob")); // will print: attribute dob does not conform to format: yyyy-MM-dd
        
```


## EmailValidator

Validates that the email format is valid: 

```java
public class Person extends ValidationSupport {

    private String firstName, lastName, dob, email;

    public Person(String firstName, String lastName, String email) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        validatePresenceOf("firstName", "lastName");
        validateWith(new EmailValidator("email"));
    }
}
```

Usage: 
```java
Person person = new Person("John", "Doe", "john#doe.com");
System.out.println(person.isValid()); // will print false because the email format is invalid
System.out.println(person.errors().get("email")); // will print: email has bad format
```

## NumericValidator

Checks that a value is numeric (can be converted to a number).

Definition: 

```java

public class Group extends ValidationSupport {
    private String size;
    public Group(String size) {
        this.size = size;
        validateNumericalityOf("size");
    }
}
```

Usage: 

```java
Group group = new Group("1");
System.out.println(group.isValid()); // true

group = new Group("blah");
System.out.println(group.isValid()); // false
// System.out.println(group.errors().get("size")); // prints "value is not a number"
```

## RangeValidator


Definition: 

```java
public class Box extends ValidationSupport {
    private int width;
    public Box(int width) {
        this.width = width;
        validateWith(new RangeValidator("width", 1, 10));
    }
}
```

Usage: 

```java
Box box = new Box(3); // valid! 
box = new Box(30); // invalid
// System.out.println(box.errors().get("width")); // prints "value should be within limits: > 1 and < 10"
```

# RegexpValidator


```java
public class Blog extends ValidationSupport {
    private String title;
    public Blog() {
        validateWith(new RegexpValidator("title", ".*G.*"));
    }
    public Blog(String title) {
        this();
        this.title = title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
}
```

Usage: 

```java
Blog blog = new Blog("Helo");
System.out.println(blog.isValid());               // prints false
System.out.println(blog.errors().get("title"));   // prints: "value does not match given format");
blog.setTitle("Guns, Germs, and Steel");
System.out.println(blog.isValid());               // prints true
```


## TimestampValidator

Validates presence and correct format of a string.

```java
public class Person extends Model {
    static {
        //...
        validateWith(new TimestampValidator("dob", "yyyy-MM-dd"));
        //...
    }
    //...
}
```

This validator ensures that if an attribute `dob` is set with a String that is not following a format, 
it will fail. The usage is exacly the same as that of any other validator. 

## Converters

Converters are similar to validators, but they try to change the values they are responsible for
during a validation process. For more, see:  [Converters](/data_conversions#converters).

## Custom Validators

In case you missed  those: [Custom Validators](/validations#custom-validators)