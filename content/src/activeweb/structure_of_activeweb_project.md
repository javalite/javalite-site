<div class="page-header">
   <h1>Structure of ActiveWeb project</h1>
</div>

An ActiveWeb project a Maven project, therefore it has all the usual Maven conventions.
However there are some specifics regarding ActiveWeb, which are discussed below. Here is a structure of a typical ActiveWeb project:

![](images/aw-structure.png)

## Configuration

ActiveWeb uses Java code for configuration, instead of XML or other files. The picture above shows a package `app.config`. This package contains 2 - 3 classes
responsible for configuration of AvtiveWeb project. In fact, it barely has any configuration. Most configuration of the
application is dealing with configuring database connections. For more on configuration, see here:
[Database configuration](database_configuration)

## Location of controllers

Controllers are *always* located in a package `app.controllers` (and sub-packages). At first this looks strange, but
this is a requirement of the framework and a general convention. Developers after a while get used to and start to
appreciate it. A controller is a Web component, and as such is not a subject of sharing across multiple applications.
Controllers of one web applications will not intermingle with controllers of another. This approach
yields the following benefits:

-   ActiveWeb application structure is identical from one project to another, making it easier to onboard new developers
-   Controllers are compiled on the fly and reloaded on every request in development mode.

## Location of models

ActiveWeb has excellent integration with [ActiveJDBC](activejdbc), and the `app.models` package is for ActiveJDBC models.
Placing models into package `app.models` is a convention and a recommendation. In more complex projects models are kept in a
different shared module used across multiple project modules.

## Location of services

The package `app.services` is a suggestion and a convention for services.
If a service is not shared across multiple modules, it makes sense to place it into this package.
If a service is used in other places, it might actually be in a completely different module/package.

ActiveWeb also provides automatic dependency injection of services into controllers and filters. ActiveWeb is integrated with
[Google Guice](http://code.google.com/p/google-guice/). For more information, please refer to [Dependency injection](dependency_injection).

## Location of views

ActiveWeb uses [FreeMarker](http://freemarker.sourceforge.net/) for rendering and does not use JSPs.
The FreeMarker templates are located in directory

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views
~~~~



The subdirectories indicate controller names.

In an example above, there are three directories under `WEB-INF/views`: `books`, `layouts` and `system`

`books` is a directory specific to this small example project. It hosts templates for `app.controllers.BooksController`

`system` is a directory provided by ActiveWeb. It contains two templates which are used by framework. Application developers are free to customize these according to the look and feel of the website.

-   The `404.ftl` is rendered when a resource not found (no controller, or action, or template)
-   the `system.ftl` is used when there is an internal system error (exceptions in controllers, etc.).

`layouts` is a directory to hold default and other layouts. The default layout is called `default_layout.ftl` and is invoked automatically by default (wraps every page into a layout)

## RequestDispatcher configuration


ActiveWeb framework is a Servlet filter. As a result it is easy to set it up in a file `web.xml`.
Below is a configuration file from a real commercial project. Usually these files do not get any more complicated:

~~~~ {.xml  .numberLines}
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/javaee" version="2.5"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">
    <display-name>activeweb</display-name>
    <filter>
        <filter-name>dispatcher</filter-name>
        <filter-class>org.javalite.activeweb.RequestDispatcher</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
        <init-param>
            <param-name>exclusions</param-name>
            <param-value>css,images,js,html,ico,png</param-value>
        </init-param>
        <init-param>
            <param-name>root_controller</param-name>
            <param-value>home</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>dispatcher</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
</web-app>
~~~~

There are three parameters you can use to configure the framework:

* **encoding** - this is what encoding to set on HTTP request and response just before using either.
    We recommend to always set it to UTF-8 to avoid issues with internationalization
* **exclusions** - this is a comma-separated list of strings on URI which the framework should ignore
    (not attempt to process are requests to controllers). These are static files, like images, HTML, CSS,
    JavaScript, PDF downloads, etc. The format is a comma separated list of sub-strings that are present on URIs of
    requests that are to be excluded.
* **root_controller** - this is a name if a controller that the framework will automatically call if no path
    is provided, such as: `http://yourdomain.com`. For this specific example, the controller called will be
    `app.controllers.HomeController` with default action `index`.
    It is equivalent to calling URL: `http://yourdomain.com/home`.
