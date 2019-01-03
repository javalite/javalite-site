<div class="page-header">
   <h1>Mvc pattern</h1>
</div>


At the heart of the ActiveWeb project there is an MVC pattern - [Model-View-Controller](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller).
ActiveWeb project is an implementation of a famous MVC pattern but adopted for the web.

## Model

A model in the ActiveWeb application is represented by custom objects that contain data. These can be [ActiveJDBC](activejdbc)
models, or any other custom objects which represent information specific to the business domain of the application.

## View

View in the ActiveWeb project is represented by [FreeMarker](http://freemarker.sourceforge.net/) templates.
While ActiveWeb can be used with other templating frameworks, FreeMarker is currently the only implementation.

## Controller

A controller in ActiveWeb is a Java class which extends class
[org.javalite.activeweb.AppController](http://javalite.github.io/activeweb/org/javalite/activeweb/AppController.html) and provides one
or more public void methods. An instance of such a class is used to process web requests.

For better understanding of control flow of HTTP request from controllers to views, please refer
to [Five Minute Guide To ActiveWeb](five_minute_guide_to_activeweb). For more information on controllers, navigate
to [Controllers explained](controllers) page.
