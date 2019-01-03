<div class="page-header">
   <h1>Writing tests</h1>
</div>




While you can use any Java technology to do this, JavaLite provides a combination of [JUnit](http://junit.org/) and
[JSpec](jspec). Test methods are written in a style where a name of a method is a phrase reflecting the
expectation of the author and usually start with a word "should".

## Specification jargon

Usually in the Java world, people call tests ... tests. The author and friends have been calling them specifications or specs for short.
This name fits better if you practice TDD, as in "specifications of behavior" rather than code testing after development.
While the change is in the name, it might be enough to have a slight shift in mentality towards TDD.

## Example process of writing a specification

Lets write a simple model:

~~~~ {.java  .numberLines}
public class Person extends Model{}
~~~~

Usually, at this point it is time to write a test:

~~~~ {.java  .numberLines}
public class PersonSpec{
  @Test
  public void shouldValidatePresenceOfFirstNameAndLastName(){
     Person p = new Person();
     a(p).shouldNotBe("valid");
  }
}
~~~~

When the code above runs, the spec is in red because the class Person does not specify any validations yet, and
therefore it is valid. This test will fail on line 5. However, our goal for this model is not be valid if it is
missing first and last name attributes. In order to make it pass, you need to add validations to the model:

~~~~ {.java  .numberLines}
public class Person extends Model{
   validatePresenceOf("first_name", "last_name");
}
~~~~

When you re-run test, it will pass.

At this point, we need to add values for first and last name, as well as an expectation of a valid state of the model:

~~~~ {.java  .numberLines}
public class PersonSpec{
  @Test
  public void shouldValidatePresenceOfFirstNameAndLastName(){
     Person p = new Person();
     a(p).shouldNotBe("valid");
     p.set("first_name", "Homer");
     p.set("last_name", "Simpson");
     a(p).shouldBe("valid");
   }
}
~~~~

At line 5, the test passes as before because the model still does not have the first and last names, but on lines
6 and 7, we add these, and on line 8 we expect the model to finally be valid.

We now have a complete specification of behavior and at the same time we built an implementation. It is typical to
switch from spec to a model and back a few times until all behavior is documented in the spec and implementation is
complete to satisfy it.

## Example of writing a test

In a real scenario, you would also need to open a database connection before the test and close it after the test.
This provides an example of a real working test from one of the example projects:

~~~~ {.java  .numberLines}
@Test
public void shouldValidateMandatoryFields(){
    Employee employee = new Employee();
    //check errors
    the(employee).shouldNotBe("valid");
    the(employee.errors().get("first_name")).shouldBeEqual("value is missing");
    the(employee.errors().get("last_name")).shouldBeEqual("value is missing");
    //set missing values
    employee.set("first_name", "John", "last_name", "Doe");
    //all is good:
    the(employee).shouldBe("valid");
}
~~~~

For a similar spec, refer to:
[MovieSpec.java](https://github.com/javalite/simple-example/blob/master/src/test/java/activejdbc/examples/simple/MovieSpec.java)
and enclosing project.
