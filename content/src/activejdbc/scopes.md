<div class="page-header">
   <h1>Scopes</h1>
</div>


Often times, developers use the same filters against the same table to categorize 
records by one or more columns, such as getting members of a marketing department: 

```
SELECT * from EMPLOYEES where department = 'marketing'
``` 

or getting people from a city:

```
SELECT * from PEOPLE where CITY = 'Chicago'
```

## Basic scope

If you find yourself doing the same over and over, you can abstract this away into a scope: 

```java
public class Employee extends Model {
    static {
        addScope("marketing", "department = 'marketing'");
    }
}
``` 

after that, just indicate what scope you need:

```java
 List<Employee> marketers = Employee.scope("marketing").all();
``` 

## Combine scopes

You can combine multiple scopes in the same request. If you have multiple scopes defined on your model: 

```java
public class Employee extends Model {
    static {
        addScope("marketing", "department = 'marketing'");
        addScope("active", "active = 1");
    }
}
``` 

then you can combine these scopes: 

```java
 List<Employee> activeMarketers = Employee.scopes("marketing", "active").all();
``` 

The framework will combine the scope filters together as expected.

## Combine scopes and conditions

Further filtering is possible to using the `where()` method as usual: 

```java
 List<Employee> activeMarketers = Employee.scopes("marketing", "active").where("position_level = ?", level).orderBy("created_at desc");
``` 

All the normal mechanisms and behavior is still in place. 

> Scopes allow to abstract away mundane requests and make the code more readable. 



 
