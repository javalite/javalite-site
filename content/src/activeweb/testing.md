<div class="page-header">
   <h1>Testing</h1>
</div>



ActiveWeb promotes [TDD/BDD](http://en.wikipedia.org/wiki/Test-driven_development) approach to testing of web applications.
At the heart, it uses [JUnit](http://www.junit.org) as a testing framework, but it provides a number of
test classes to be sub-classed for  various purposes. ActiveWeb allows to do a full test of any web functionality during a 
regular build. 

All test classes have a suffix "Spec". This is a nod to [RSpec](http://rspec.info/), but
also a good practice - think of these not as tests that assert values, but as specs, or specifications of behavior.
The more you think of them as specifications/blueprints, the more you will think of writing them before actual implementations.

> This page is not an exhaustive list of test APIs, but rather a directional guide and a set of how-to instructions

## JSpec

While ActiveWeb tests are written with the popular JUnit testing framework, traditionally expectations are written
with [JSpec](jspec)


## DBSpec for database tests

You can use a class [DBSpec](testing_with_db_connection) for writing tests that depend on a database connection. 

## Configuration

Database configuration is described on [database configuration](database_configuration) page.
DBSpec class will look for connections configured with a method `testing()`.

Example:

~~~~ {.java  .numberLines}
public class DbConfig extends AbstractDBConfig {
    public void init(AppContext context) {
         environment("development").jndi("jdbc/kitchensink_development");
         environment("development").testing().jdbc("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/kitchensink_development", "root", "****");
         environment("jenkins").testing().jdbc("com.mysql.jdbc.Driver", "jdbc:mysql://172.30.64.31/kitchensink_jenkins", "root", "****");
         environment("production").jndi("jdbc/kitchensink_production");
    }
}
~~~~

Specifically, line 4 configures a test connection to be used during the test.
In case you work with multiple databases, you can configure more than one test connection. DBSpec will open all connections
marked for tests.

## Transaction management

`DBSpec` will  start a transaction before the test and roll it back after the test, ensuring that you have:

1. integrity of data in your test
2. no conflicts of data in the database from one test to another


## ControllerSpec - test your controllers


`org.javalite.activeweb.ControllerSpec` is a super class for controller tests. This class is used by unit tests that
test a single controller. Controllers are tested by simulating a web request to a controller (no physical network is
involved, and no container initialized).

> All APIs available to controllers in `ControllerSpec` are also available to all other controller and integration specs

## Spec naming convention

> Spec class name must be made of two words: 
1. controller short class name and 
2. Word "Spec".

For example, if there is a controller:

~~~~ {.java .numberLines}
package app.controllers;
public class GreeterController extends AppController {
   ///...
}
~~~~

then the spec will be called:

~~~~ {.java .numberLines}
package app.controllers;
public class GreeterControllerSpec extends ControllerSpec {
 ///...
}
~~~~


Note that the package name is the same for spec as it is for controller, since ActiveWeb will use reflection to determine
the controller to be tested


## Sending HTTP requests from specs

~~~~{.java  }
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldSendGetToIndex() {
        request().get("index");
     }
}
~~~~

In a snippet above on line `request()...`, the method `request()` allows to simulate a call to a controller `HomeController`.

> This line reads: Send GET request to `HomeController`, action `index`.

There are other methods for sending different HTTP methods:

* `post(action)`
* `put(action)`
* `delete(action)`

Here ActiveWeb expects the following conventions: 

1. Controller name is deducted from the spec name, which leads it to search `app.controllers.HelloController` in this case. 
2. Methods `get("action_name")`, `post("action_name")` will translate to invoking corresponding actions in controller. 
 Refer to [Routing](routing) for definitions  of actions and action methods. 
3. HTTP GET method will be simulated for controller. 

## Sending parameters with HTTP requests

~~~~ {.java .numberLines}
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldSendParamsToIndex() {
        request().param("first_name", "John").param("last_name", "Deere").get("index");
        a(val("message")).shouldBeEqual("Hello, John Deere, welcome back");
    }
}
~~~~

This test is a little more complex, we are sending two parameters with the request, and also checking the value
controller assigned to a view.

The above example can be simplified with a use of a ` params()` method that takes an even number of names an values for parameters:

~~~~ {.java .numberLines}
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldSendParamsToIndex() {
         request().params("first_name", "John", "last_name", "Deere").get("index");
         a(val("message")).shouldBeEqual("Hello, John Deere, welcome back");
    }
}
~~~~


## Generating views during testing

ActiveWeb allows you to generate a full HTML during tests, without starting containers or sending real HTTP requests 
over network. At the same time, controllers have no awareness that they are executed from tests. 

Views are generated in tests by default: 

~~~~{.java  }
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldSendParamsToIndexAndGenerateHTML() {
        request().params("first_name", "John", "last_name", "Deere").get("index");
        a(responseContent()).shouldContain("<span class="greeting">Hello, John Deere, welcome back</span>");
    }
}
~~~~


Line `request()...` causes the framework to execute the controller, and pass all data from it to the view and the generate HTML as
in a normal application flow.

Method `responseContent()` simply returns entire HTML generated by the view. Now, that you have the generated content, you can use variety of
technologies in Java to test its structure (easier if you stick to XHTML in your templates), as well as content.

We simply test on line 5 that there exists a span with specific content merged by template from data passed in from controller.


## Testing HTML content 
 
 The method `responseContent()` returns text generated as a single string. Your application may generate HTML, XML, JSON, 
  or any other format. However, majority of modern application development deals with generating HTML, and ActiveWeb provides 
  two convenience methods to validate structure and content of generated HTML: 
   
**Finding content of node**

Use the `text(cssSelector)` method to find content of a node by CSS selectors.

~~~~ {.java .numberLines}
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldHaveContentHello() {
        request().get("index");
        a(text("div[class='main']")).shouldEqual("Hello!");
    }
}
~~~~

**Counting HTML elements**

Sometimes you need to verify a number of nodes in HTML (expected number of specific elements generated on page).   
Use the `count(cssSelector)` method to find nodes matching a CSS selector.

~~~~ {.java .numberLines}
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldCountListElements() {
        request().get("index");
        a(count("li[class='disabled']")).shouldEqual(3);
    }
}
~~~~

> Implementation is based on the Open Source Project [JSoup](http://jsoup.org), which can be used in combination 
 with the `responseContent()` directly for more sophisticated cases. 


## Mocking and testing

Mocking and testing of services is related to the concept of Dependency Injection and is described in
[Dependency Injection](dependency_injection#mocking-and-testing) section.


## Posting binary content

Sometimes you need to test a case when binary data is POSTed to a web application. This can be easily tested with the
`content()` method:

~~~~ {.java .numberLines}
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldSendBytes() {
        byte[] mybytes = ...
        request().content(mybytes).post("index");
        a(responseContent()).shouldBe("<message>success</message>");
    }
}
~~~~

## Testing uploads

Simulating file upload can be done with the formItem() method:

~~~~ {.java .numberLines}
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldUploadImageFile() {
        byte[] imagebytes = ...
        request().contentType("multipart/form-data").formItem("file.png", "image", true,  "application/png", imagebytes).post("upload");
        a(responseContent()).shouldContain("<message>success</message>");
    }
}
~~~~

Most methods chained after method `request()` are chained because they all return a special instance of `RequestBuilder`.
This allows to call the same method more than once, including `formItem()` to simulate uploading of multiple files.



## Testing downloads

Downloading files or streaming data from a controller to a browser is described here: [Controllers: downloading of files](controllers#downloading-of-files).

Lets say you have a controller that streams out some CSV data like this: 

~~~~ {.java .numberLines}
public void csv(){
    OutputStream out = outputStream("text/csv", map("Content-Disposition", "attachment; filename=messages.csv"), 200);
    Base.find("select * from messages where user_id = ?", param("user_id")).with(row -> {
        try {
            out.write(toCSV(row));
        } catch (IOException e) {
            flash("csv_error", "Apologies, we experienced an error while generating a CSV file. ");
            redirect(CSVController.class, "download");
        }
        return true;
    });
}
~~~~ 

Testing such a controller can be done in this manner: 

~~~~ {.java .numberLines}
public class CSVControllerSpec extends ControllerSpec {
    @Test
    public void shouldDownloadCSV() {
        request().param("user_id", 123).get("download");
        String csvContent = new String(bytesContent());
        /// provide ways to test the content, such as parse CSV, etc. 
    }
}
~~~~


## Working with sessions

The `session()`  method allows to setting objects into session before a
test and also used to inspect objects in session after some action (execution of a controller)

~~~~ {.java .numberLines}
public class LoginControllerSpec extends ControllerSpec {
   @Test
   public void shouldLoginByIdAndPassword() {
        request().params("id", "mmonroe", "password", "kennedy").post("index");
        a(session("user")).shouldNotBeNull();
  }
}
~~~~

Conversely, you could "login" by placing a User object into a session before executing a controller of interest.

## Working with cookies

Cookies can be sent with a response using a `cookie()` method:

~~~~ {.java .numberLines}
public class HelloControllerSpec extends ControllerSpec {
    @Test
    public void shouldCookie() {
        request().cookie(new Cookie("app_id", "12345")).get("index");
        a(cookie("last_access")).shouldNotBeNull();
    }
}
~~~~


In this spec, we are sending one cookie with the request, but also are checking that "HelloController" sent another
cookie to the client.


## Great for TDD

ActiveWeb controller specs allow for true TDD, since they do not have a compiler dependency on controllers.
You can describe full behavior of your controller before a controller class even exists. Simplest example:

~~~~ {.java .numberLines}
public GreeterControllerSpec extends ControllerSpec {
    @Test
    public void shouldRespondWithGreetingMessage() {
        request().get("index");
        a(responseCode()).shouldBeEqual(200);
        a(val("message")).shouldBeEqual("Hello, earthlings");
    }
}
~~~~

In a code snippet above, a request with HTTP GET method is simulated to the `GreeterController`, `index()` action.
Controller is expected to assign an object called "message" with value "Hello, earthlings" to a view.

It is easy to describe a controller behavior in a `ControllerSpec`, making it easy to practice real TDD.


## DBControllerSpec - test controllers with DB connection

`org.javalite.activeweb.DBControllerSpec` class serves as a super class for controller tests requiring database
connections. In effect, this class combines the logic of `ControllerSpec` and `DBSpec`. When it comes to naming convention
of a controller to be tested, the functionality is identical that of `ControllerSpec`, but at the same time it will
open a connection to DB before test and close after (will also roll back transaction)

## IntegrationSpec - test multiple controllers together

While `ControllerSpec` and `DBControllerSpec` allow to test a single controller, the class `IntegrationSpec` allows
to write entire scenarios for testing multiple controllers.

Example:

~~~~ {.java .numberLines}
public class SimpleSpec extends IntegrationSpec {
    @Test
    public void shouldNavigateToTwoControllers() {
        controller("home").get("index");
        a(statusCode()).shouldBeEqual(200);
        controller("greeter").param("name", "Bob").get("index");
        a(responseContent()).shouldContain("Our special greeting is extended to Bob");
    }
}
~~~~

Lets decompose code snippet:

* **Line 4**: a controller `HomeController` is executed with HTTP GET  request which is dispatched to its action `index()`
* **Line 5**: we verify that the response code of execution was 200
* **Line 6**: controller GreeterController's `index()` action is executed with HTTP GET and parameter `name="Bob"`.
              Controller, provide us with that view's output - usually HTML, but can be XML, JSON, whatever that view is producing.
* **Line 7**: we examine the content of the produced view output.

Note that we can run this code in the absence of both controllers (of course it will fail).

Lets write a `GreetingController` (as being the most "complicated" of the two):

~~~~ {.java .numberLines}
public void GreeterController extends AppController {
    public void index() {
        view("name", param("name"));
    }
}
~~~~

The corresponding view might look like:

~~~~{.html}
<span>Our special greeting is extended to ${name}</span>
~~~~

and will be located in file:

~~~~{.prettyprint}
/greeter/index.ftl
~~~~


## DBIntegrationSpec - combines IntegrationSpec and DBSpec

`org.javalite.activeweb.DBIntegrationSpec` class serves as a super class for controller integration tests requiring
database connections. In effect, this class combines the logic of IntegrationSpec and DBSpec. It will allow
to write scenarios to test multiple controllers, but at the same time it will open a connection to DB before the
test and will close after (will also roll back transaction).

## AppIntegrationSpec - bootstraps ControllerFilters into test

`org.javalite.activeweb.AppIntegrationSpec` is a class that will bootstrap entire application, complete with
ControllerFilters. The only difference of running your application under AppIntegrationSpec and running it live, is that
the `DBConnectionFilter` is disabled, and instead database connection is provided exactly the same way as in `DBSpec`,
`DBControllerSpec` or `DBIntegrationSpec`.

In other words, think of `AppIntegrationSpec` as the same with `DBIntegrationSpec`, but all filters will trigger as in
a real application.


> None of the IntegrationSpecs require  the same naming convention as `ControllerSpec` or `DBControllerSpec`.


## Testing Views

It is possible to test just a view template with ActiveWeb. There is a special class for that called ViewSpec.
Here is an example of a template to be tested:

Template file name `/person/show.ftl`:

~~~~{.prettyprint}
Name: ${name}
~~~~

The view test might look something like this:

~~~~ {.java .numberLines}
public class PersonSpec extends ViewSpec {
    @Test
    public void shouldRenderShow() {
        a(render("/person/show", "name", "John").shouldEqual("Name: John");
     }
}
~~~~

There is also a way to test for `<@content for>` output, inject mock or real services into custom tags, etc.
In other words, one can write very stringent tests for views independent of the rest of the application,
just as if views were first grade application components.

