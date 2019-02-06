<div class="page-header">
   <h1>Context parameters</h1>
</div>


ActiveWeb provides a number of context parameters available in the views. 
Any of these parameters can be rendered on a page or used in conditional logic 
like any other parameters passed from a filter or a controller.
  
All these parameters are members of the object `activeweb`.
For example, if you use a [DebugTag](views#debug-tag) to reflect the contents of this object: 
 
```html
<@debug print=activeweb/>
```

you will see the following output: 

```
{environment=development, controller=/pages, restful=true, action=show}
```


## ActiveWeb parameters

Currently these parameters are set on every view by the framework:

* `activeweb.environment`
* `activeweb.controller` 
* `activeweb.action` 
* `activeweb.restful`. 
  
> The ActiveWeb parameters are always present in a view. 
 
### The environment parameter

This a value of the environment variable `environment`. Normally, it has such values as `development`, `test`, `staging`, `production`. 

Most of the time it is used to configure different database connection parameters for different execution environments. 
For more information, refer to [AppConfig](app-config), [Database Connection Management](database_connection_management), [Database Configuration](database_configuration).

  
### The controller parameter 

Full path of the controller:
 
controller path                              controller
-------------------------                    ----------------------------------------
 /package1/books                              app.controllers.package1.BooksController
 /people                                      app.controllers.PeopleController

 

### The action parameter

This is simply an action of the controller that is being executed according to the route. For more information, refer to [Routing](routing). 



### The restful parameter

It simply contains the boolean value that shows if this controller is [Restful](routing#restful-routing). 
  
### Usage

Generally you might use the `environment` parameter to expose a special feature in let's say development environment:  


```html
<#if activeweb.controller == "/pages">
    <#--display an important hidden feature-->
</#if>

```

Using other parameters might be considered a hack - you decide.

## The `context_path` parameter

The `context_path` parameter defines the path to context for a web application. 
You can use it to dynamically define the root of the app for your web resources that is transparent 
to your environment. If you are  deploying multiple pplication on your container, then each app will have a defined context. 
This parameter  is to get a direct value passed into the app by the container. See more: [HttpServletRequest.html#getContextPath()](https://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletRequest.html#getContextPath()).
  
> Always use `context_path` as a base for your resources, such as below: 

`<script src="${context_path}/js/jquery-3.1.min.js" type="text/javascript"></script>`. 
 
## The `request_props` parameter
 
 This is an obscure parameter, which is a map. At the time of this writing, it holds a single value named `url`, which is a URL of a current request. 
 for instance, if you are accessing a page on your app at `http://localhost:8080/books`, then that will be the value of this parameter.
 
 In the future, more parameters describing various properties of a current request might be added here as well. 
  

 
## Session parameters

The session object is always available in views, just like it does in a standard Servlet applicaiton. 
Setting and reading the session from controllers and filters is described here: 
[Session management](http://javalite.io/controllers#session-management). 

On the views, you would simply use: 

```html
And the session parameter is: ${session.param1}. 

```


## Request parameters

If your request has any parameters attached to it, they will be available on the view by accessing the `request` object. 
For example, if your URL looks like this: 
 
```
http://mysite.com/controller1?name=John
```

Then you can access the `name` from a view directly: 

```html
Your name is: ${request.name}. 
```
