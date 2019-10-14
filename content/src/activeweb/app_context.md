<div class="page-header">
   <h1>App context</h1>
</div>



## Lifecycle

This object essentially is a map of objects you want to keep for the duration of  your running app. 
It is not intended for large and complex object. Use it only to contain small dynamic configuration if you need it. 

## Access from Java

Sometimes you need to configure and  keep some values in the application for the duration of application life cycle. Use AppContext for this.
In order to set the values to the AppContext, write some code in the AppBootstrap:

~~~~ {.java .numberLines}
public class AppBootstrap extends Bootstrap {
    public void init(AppContext context) {
        context.set("app_name",  "Best App Ever");
    }
}
~~~~


Once this is done, you can access the context from any controller filter or controller:

~~~~ {.java .numberLines}
public class HomeController extends AppController {
    public void index(){
         view("app_name",    appContext().get("app_name"));
    }
}
~~~~

## Access from templates

This object is always available from templates, here is how to access: 

```
AppContext Value: ${app_context.name-of-object}

```



