<div class="page-header">
   <h1>5 minute guide to ActiveWeb</h1>
</div>



At the heart of an ActiveWeb application is a controller. A controller is a component whose role is to accept and process
an HTTP request. This is similar to a Servlet, or a controller class other web frameworks.

> ActiveWeb is a convention-based framework. It requires no configuration by default.

Here is an example of the simplest controller:

~~~~ {.java  .numberLines}
public class GreetingController extends AppController{
   public void index(){}
}
~~~~

## URL mapping convention

Controllers are automatically mapped to a URL, such that a controller name underscored or hyphened is converted to CamelCase controller class name
(without the word Controller). Here is an example:

~~~~ {.prettyprint}
http://localhost:8080/testapp/greeting
~~~~

When this URL is accessed, the `GreetingController` is executed. Since no further information is provided on the URL,
the `index()` method will be processed.

> Controller methods processed as a result of an HTTP request are called **actions**.

For more information, please see [Routing](routing)

## Action mapping convention

If the URL contained more information, let's say:

~~~~ {.prettyprint}
http://localhost:8080/testapp/greeting/hello
~~~~

then the system would expect that the controller would have a "hello" action, as in:

~~~~ {.java  .numberLines}
public class GreetingController extends AppController{
   public void hello(){}
}
~~~~

However in the previous example if the action is omitted, it causes the framework to fall back on a default action "index".

## View mapping convention

In this case, since the action `index` does not have any code, the framework will pass control to a view. This view will be looked for under:

~~~~ {.prettyprint}
/WEB-INF/views/greeting/index.ftl
~~~~

Where `/WEB-INF/views/` is a base location for all views, directory `greeting` is named after controller, and a view template
`index.ftl` is called to render because action `index` of the controller was executed.
The content of the `index.ftl` will be displayed in browser wrapped in a default layout.

## Example passing data to view

In the graphic below, you see how ActiveWeb routes the request to `GreetingController` and action "hello". The complete sequence of operations:

1.  A URL `http://localhost:8080/simple-example/greeting/hello?name=Bob` is entered into the browser.
2.  ActiveWeb upon receiving the request, routes it to the controller `GreetingController`, action "`hello`.
The controller passes some data to view - `date` as internally generated data, as well as `name` - HTTP request parameter, accessed with `param("name")` method
3.  The Framework then passes the data to a view template `WEB-INF/views/greeting/hello.ftl` for rendering

![ActiveWeb flow](images/aw.png)

> The code you see on above is all that there is. There are no XML files, no property or any other configuration files.
