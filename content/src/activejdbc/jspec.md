<div class="page-header">
   <h1>JSpec</h1>
   <h4>Assertions that read like English</h4>
</div>


This page describes functionality and usage of a small testing library called JSpec. JSpec was originated from ActiveJDBC
project and was inspired by RSpec.

## The grand idea

The idea is to replace "assert" language with "should" language and make it as close to English as possible.
This forces the brain to work in a different mode, writing a "specification of behavior" for your program rather than
"assertion" that the program works. The difference might seem subtle, but requires a different style of thinking and promotes
true TDD/BDD - when specifications are written before implementation, sometimes even by different people.

JSpec uses 'should' word instead of 'assert'. Here is an example of an old style test:

~~~~ {.java  .numberLines}
@Test
public void testCalculator(){
   Calculator c = new Calculator();
   c.add(2, 2);
   assertEquals(c.result(), 4);
}
~~~~

The JSpec style of writing this test would be:

~~~~ {.java  .numberLines}
@Test
public void shouldAddNumbersCorrectly(){
   Calculator c = new Calculator();
   c.add(2, 2);
   a(c.result()).shouldBeEqual(4);
}
~~~~

The result of executing either test is the same, but the style is completely different:

-   The method name starts with "should", which implies that the functionality is not developed yet! It is very important
to write tests with clear understanding of the requirements and describe a system "behavior" in code before implementation is developed.
-   The expectation reads almost like an English sentence: "calculation result should be equal 4".

## The `the()`, `a()`, `it()` and `$()`

In the code above, you see the usage of `a()` method. This method returns an object "Expectation", which you really do not
care about, because it is never used directly. It is used as a form of a
[fluent interface](http://martinfowler.com/bliki/FluentInterface.html) and  has all the `should..()` methods for verifications.

### The `a()`, `the()` and `$()` methods

All the three methods `a()`, `the()` and `$()` return the expectation object and do exactly the same. They are
synonyms of each other. 

The reason for having three methods is to provide English words to make the
expectation "sentence" sound better. Use whichever method that makes your assertion sound the best.


### Numeric type indifference in `a()`, `the()` and `$()`

The `a()`, `the()` and `$()` methods are numeric type agnostic. In JUnit this will fail:

~~~~ {.java  .numberLines}
assertEqual(3, 3L); // will fail
~~~~

while the two numbers are identical in value for all practical purposes, the JUnit assertion will fail just because the
types are different, one being an Integer, and another a Long. The same test in JSpec using either 'a' or 'the' will succeed:

~~~~ {.java  .numberLines}
a(3).shouldBeEqual(3L); // will succeed
~~~~

### The `it()` method

The only difference between the `it()` method and `a()` or `the()` is that in the `it()` method the tested object type and
expected object type are parametrized with Java Generics. This means that they must be the same type:

~~~~ {.java  .numberLines}
it(3).shouldBeEqual(3L);// will not compile
~~~~

## Expectation methods


### The `shouldEqual()`, `shouldBeEqual()` and `shouldNotBeEqual()`

Expect that the two objects are equal with the use of a standard `java.lang.Object.equals()` method:

~~~~ {.java  .numberLines}
a(obj1).shouldEqual(obj2);
~~~~

The great thing about this method is that it will check that the objects are the same type, has a protection for
`null` and will produce a good quality message in case objects are not equal. This code:

~~~~ {.java  .numberLines}
String a = "a", b = "b";
a(a).shouldBeEqual(b);
~~~~

Will produce this message:

~~~~ {.prettyprint }
Test object: 
java.lang.String == <a> 
and expected
java.lang.String == <b> 
~~~~

while this code:

~~~~ {.java  .numberLines}
String a = "a", b = null;
a(a).shouldBeEqual(b);
~~~~

will produce this message:

~~~~ {.prettyprint}
Test object: 
java.lang.String == <a> 
and expected
null == <null>
~~~~

As you can see, the messages not only provide values of tested and expected objects, but also provide their types,
which is often important.

### The `shouldHave()`, `shouldBe()`, `shouldNotBe()`

There are three dynamic boolean methods that are supported by JSpec:

-   `shouldHave(String)`
-   `shouldBe(String)`
-   `shouldNotBe(String)`

For all three methods, the argument is an abridged boolean method of a tested class. This means that if there is such a class Person:

~~~~ {.java  .numberLines}
class Person{
  private String name;
  ... setter/getter
  public boolean isValid(return name != null; )
}
~~~~

you can write an expectation in this style:

~~~~ {.java  .numberLines}
Person person = new Person();
a(person).shouldBe("valid");
~~~~

What happens here is that the JSpec will dynamically execute the method `person.isValid()` and will evaluate its
return value. If the value returned is false, the expectation is not met, and test will fail with exception.

Example for shouldHave():

~~~~ {.java  .numberLines}
class Validation{
  public boolean hasErrors(){...};
}
~~~~

and the expectation is:

~~~~ {.java  .numberLines}
Validation validation = new Validation();
a(validation).shouldHave("errors");
~~~~

The goal of this style of expectations to make them as close as possible to sound like an English sentence.

### The `shouldBeNull()` and `shouldNotBeNull()`

Expects that the tested reference is not null (or is):

~~~~ {.java  .numberLines}
a(x).shouldNotBeNull();
~~~~

In case the x is actually `null`, the test will fail with:

~~~~ {.bash }
org.javalite.test.jspec.TestException: Object is null, while it is not expected
~~~~

### The `shouldBeType()` and `shouldBeA()`

Sets up expectation for a tested object's type:

~~~~ {.java  .numberLines}
the(count).shouldBeType(Long.class);
~~~~

If expectation not met, the error can be:

~~~~ {.bash }
org.javalite.test.jspec.TestException: class java.lang.String is not class java.lang.Long
~~~~

`shouldBeA` is a synonym of `shouldBeType`, use either one for a better sounding sentence.

### The `shouldBeFalse()` and `shouldBeTrue()`

These are self-explanatory:

~~~~ {.java  .numberLines}
a( 2 * 2 == 4).shouldBeTrue();
~~~~

and:

~~~~ {.java  .numberLines}
a( 2 * 2 == 5).shouldBeFalse();
~~~~

### The `shouldBeTheSameAs()` and `shouldNotBeTheSameAs()`

These methods are to check if the tested and expected references point to the same (or not) object.

### The `shouldContain()` and `shouldNotContain()`

Tests that an expected value is contained in the tested object. The tested object can be of the following types:

-   Any object - the string representation of this object is tested to contain a string representation of
expected value as a substring. For example, this will pass:

~~~~ {.java  .numberLines}
  the("meaning of life is 42").shouldContain("meaning");
~~~~

-   `java.util.List` - the tested list is expected to contain an expected object. For example, this will pass:

~~~~ {.java  .numberLines}
  a(Arrays.asList(1, 2, 3)).shouldContain(3);
~~~~

-   `java.util.Map` - the tested map is expected to contain an object whose key is the expected object. For example, this will pass:

~~~~ {.java  .numberLines}
  Map map = new HashMap();
  map.put("one", 1);
  map.put("two", 2);
  map.put("three", 3);
  a(map).shouldContain("two");
~~~~

The method `shouldNotContain()` is exactly the opposite of shouldContain().

### Expecting difference

Often times you need to ensure that some number before and after the operation is different. For instance, this could
be a total count of specific records in a table, or a size of a list. Here is an example of using a difference expectation with JSpec:

~~~~ {.java  .numberLines}
expect(new DifferenceExpectation(Person.find("last_name like ?", "Smith").size()) {
  public Object exec() {
     Person.updateAll("last_name = ?", "Smith");
     return Person.find("last_name like ?", "Smith").size();
  }
});
~~~~

In the code snippet above, the constructor of `DifferenceExpectation(..)` is passed an initial value, and
the method `exec()` returns a final value. The initial and final are compared to be different at the end of a test.
If they are the same, then the test fails. An example message:

~~~~ {.bash}
javalite.test.jspec.TestException: Objects: '1' and '1' are equal, but they should not be
~~~~

~~~

## Using with other technologies

JSpec is really a few classes, and as such can be used with any other testing technology. Sometimes people use it
outside tests, just to assert correct argument values passed into methods.

Here is a good [Example of using JSpec and Cucumber](https://github.com/javalite/cucumber-jspec).



## Where to find

JSpec is packaged into JavaLite Common library, which is published into [Maven Central](http://search.maven.org/#search|ga|1|javalite-common). 

Adding it to your project is easy:

~~~~ {.xml  .numberLines}
<dependency>
    <groupId>org.javalite</groupId>
    <artifactId>javalite-common</artifactId>
    <version>LATEST_VERSION</version>
</dependency>
~~~~

Releases and versions of JavaLite Common are on the same schedule as [ActiveJDBC](activejdbc).

