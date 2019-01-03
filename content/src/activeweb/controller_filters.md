<div class="page-header">
   <h1>Controller filters</h1>
</div>



Controller filters are similar to that of Servlet filters, but designed to wrap execution of controllers.
They can be used for many tasks that need to trigger before and after execution of a controller, such as login in,
loggin, opening a DB connection, timing, etc. Controller filters are implementation of a
[Chain of responsibility](http://en.wikipedia.org/wiki/Chain-of-responsibility_pattern) design pattern.

Filters are almost as powerful as controllers. They can inspect any aspects of a request, including request parameters,
headers, etc. They can also preempt controllers and send different responses than a controller
(think of a permission access filter for example, which will redirect to a login screen in case there is an attempt to
access a protected resource).

All filters extends this class:


~~~~ {.java  .numberLines}
package org.javalite.activeweb.controller_filters;
public class HttpSupportFilter {
    void before(){}
    void after(){}
    void onException(Exception e){}
}
~~~~

## Filter configuration

Configuration of filters is done in a class called `app.config.AppControllerConfig`, which needs to extend
`org.javalite.activeweb.AbstractControllerConfig`. This class provides ways to bind filters to controllers.
It has coarse as well as fine grained grain methods for binding .


## Filter ordering

Filters follow a so-called The Onion pattern. The `before()` methods are executed before a controller executer

> The `before()` methods are executed in the same order as filters are registered.

The `after()` methods are executed .. after a controller.

> The `after()` methods are executed in the opposite order as filters are registered.

For example, lets say we have the following configuration: 

~~~~ {.java  .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
    public void init(AppContext appContext) {
        add(new GlobalFilter1(), new GlobalFilter2());
        add(new ControllerFilter1(), new ControllerFilter2()).to(DoFiltersController.class);
    }
}
~~~~
 
 The order of execution will be: 
 
 
~~~~ {.numberLines}
GlobalFilter1#before()
GlobalFilter2#before()
ControllerFilter1#before()
ControllerFilter2#before()
DoFiltersController#index()
ControllerFilter2#after()
ControllerFilter1#after()
GlobalFilter2#after()
GlobalFilter1#after()
~~~~



## Filter interruptions

A filter may interrupt a flow  of execution in case where it generates a response to a web client.
 A classic example is checking authentication filter: 

~~~~ {.java  .numberLines}
public class AuthorizationFilter extends HttpSupportFilter {
    @Override
    public void before() {
        if(!sessionHas("user"){
            redirect(LoginController.class);
        }
    }
}
~~~~

In this case, if the session has no object called "user", the filter will redirect to a login controller. 

> If a filter generated a response to a controller from the `before()` method, all following `before()` methods of downstream filters
as well as the target controller are skipped.
 
This rule does not affect the `after()` methods, which will execute in the same  order as described above. 


## Adding global filters

Adding global filter adds the to all controllers. It makes sense to use  this feature to add logging, authentication filters, etc.

~~~~ {.java  .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
  public void init(AppContext context) {
    add(new AuthenticationFilter());
  }
}
~~~~

Not specifying what controller a filter is added to makes it a global filter(will execute fro any controller)

## Excluding controllers

In some cases, you need to add filters to all controllers, except a few. For example, you might have a security filter,
and there is no point to add it to non-secure controllers, or you have a DBConnectionFilter, and you do not want to
open connections for controllers which you know will not use a DB connection (expensive resource).
Then you can exclude some controllers from global filters:

~~~~ {.java  .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
  public void init(AppContext context) {
    add(new DBConnectionFilter()).exceptFor(HomeController.class);
  }
}
~~~~

The `exceptFor()` method, takes a vararg, so you can pass multiple controllers there.

## Adding filters to specific controllers

To add filters to specific controllers:

~~~~ {.java  .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
  public void init(AppContext context) {
    add(new TimingFilter()).to(HomeController.class);
  }
}
~~~~

Both the `add()` an the `to()` methods take in varargs, allowing to bind multiple filters to multiple controllers in
one line of code.


## Adding filters to specific actions

Here is an example of adding a filter to specific actions:

~~~~ {.java  .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
  public void init(AppContext context) {
    add(new TimingFilter(), new DBConnectionFilter()).to(PostsController.class).forActions("index", "show");
  }
}
~~~~

## Exception handling


The `void onException(Exception e);` method can be used to handle exceptions occurred during execution of a
controller of other (inner) filters. It is typical on a project to register a "catch all filter" as a global
top-most filter. You probably saw default error page coming from the application server in cases when there is a
failure in the application. If you declare a "catch all " filter, this can be avoided, and users would see a friendly
page with a message.

Here is an example:

~~~~ {.java  .numberLines}
public class CatchAllFilter extends HttpSupportFilter {
    public void onException(Exception e) {
        logError(e.toString(), e);
        render("/system/error", Collections.map("message", "Apologies for inconvenience");
    }
}
~~~~

In the code snippet above, the `CatchAllFilter` will be given a chance to log an exception to a log system, but then
also to display a friendly styled error page in default layout.

## Out of the box filters

ActiveWeb provides a number of filters for easy configuration of projects.

### DBConnectionFilter

`DBConnectionFilter` opens a connection before execution of a controller and closes it after execution. Here is an
example of usage of this filter from the [Kitchensink](https://github.com/javalite/kitchensink) project:

~~~~ {.java  .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
    public void init(AppContext context) {
        add(new DBConnectionFilter()).to(PostsController.class, RpostsController.class);
    }
}
~~~~

> `DBConnectionFilter` works with connections configured in [Database configuration](database_configuration).

In the example above, the filter is attached only to controllers PostsController and RpostsController. Presumably
other controllers do not require a DB connection. If you use [ActiveJDBC](activejdbc)
for persistence layer, you do not need to do anything else. If you just want to get access to the underlying DB
connection, you can do this inside a controller or inner filter:

~~~~ {.java  .numberLines}
java.sql.Connection connection = Base.connection();
~~~~

which gives you a full control over this connection.

### RequestPropertiesLogFilter

This filter will log properties of a request to a log system. It is useful for debugging. Example output of this filter:

~~~~ {.prettyprint}
32644 [2132827533@qtp-1457284258-0] INFO org.javalite.activeweb.controller_filters.RequestPropertiesLogFilter -
Request URL: http://localhost:8080/kitchensink/
ContextPath: /kitchensink
Query String: null
URI Full Path: /kitchensink/
URI Path: /
Method: GET
~~~~

### RequestParamsLogFilter

This filter will log parameters of the request, here is an example:

~~~~ {.prettyprint}
176575 [2090322800@qtp-1699024671-2] INFO org.javalite.activeweb.controller_filters.RequestParamsLogFilter -
Param: content=content to be determined...
Param: id=3
Param: author=Igor Polevoy
Param: title=What good for Ruby is good for Java: JSpec
~~~~

### HeadersLogFilter

This filter will dump all HTTP request headers:

~~~~ {.prettyprint}
176576 [2090322800@qtp-1699024671-2] INFO org.javalite.activeweb.controller_filters.HeadersLogFilter -
Header: Accept-Language=en-us,en;q=0.5
Header: Cookie=JSESSIONID=6trloxem6xib; remember_me=3f654b9f-8abd-4693-bf62-43ccc7c6
Header: Host=localhost:8080
Header: Content-Length=106
Header: Accept-Charset=ISO-8859-1,utf-8;q=0.7,*;q=0.7
Header: Referer=http://localhost:8080/kitchensink/posts/edit_post/3
Header: Accept-Encoding=gzip,deflate
Header: Keep-Alive=115
Header: User-Agent=Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.16) Gecko/20110323 Ubuntu/10.10 (maverick) Firefox/3.6.16
Header: Content-Type=application/x-www-form-urlencoded
Header: Connection=keep-alive
Header: Accept=text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
~~~~

### Changing log levels

You can add a filter to AppContext before registration:

~~~~ {.java  .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
    public void init(AppContext context) {
        HeadersLogFilter headersLogger = new HeadersLogFilter();
        context.set("headersLogger", headersLogger);
        add(new TimingFilter(), new RequestPropertiesLogFilter(), new RequestParamsLogFilter(),
                headersLogger);
    }
}
~~~~

This will ensure that you can get to these filters from controller later on:

~~~~ {.java  .numberLines}
public class AdminController extends AppController {
    public void setHeadersLogLevel(){
        //how to disable logging of headers at run time:
        appContext().get("headersLogger", HeadersLogFilter.class).logAtLevel(Level.valueOf(param("log_level")));
    }
}
~~~~

Moving log level of these filters above or below current log system log level is easy and very useful.
In production you might want to have these at INFO level, but you might want to temporarily enable DEBUG logging to trace
some problem, then turn it off again, all without having to redeploy or restart a server.
