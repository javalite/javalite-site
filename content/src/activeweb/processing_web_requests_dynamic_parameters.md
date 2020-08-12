<div class="page-header">
   <h1>Processing Web Requests - Dynamic Parameters</h1>
</div>


## Getting request parameters

Getting request parameters is the most important part of any web application. ActiveWeb provides a few methods to
achieve this goal:

### Getting a single parameter

~~~~ {.java  .numberLines}
public class GreetingController extends AppController{
   public void index(){
       String name = param("name");
   }
}
~~~~

### Getting all parameters

~~~~ {.java  .numberLines}
public class GreetingController extends AppController{
   public void index(){
      Map<String, String[]> allParams = params();
   }
}
~~~~

### Getting all values for a single parameter

This is in cases for submit parameters with multiple values, such as selects:

~~~~ {.java  .numberLines}
public class GreetingController extends AppController{
   public void index(){
      List<String> states = params("states");
   }
}
~~~~

### Getting a first value from each submitted parameter

99% of the time, there is only one value for a single parameter. This makes the method `params1st()`  very useful:

~~~~ {.java  .numberLines}
public class GreetingController extends AppController{
   public void index(){
      Map<String, String> firstValues = params1st()
   }
}
~~~~

The return value is a map where keys are names of all parameters, while values are first value for each parameter,
even if such parameter has more than one value submitted.

This method is used quite often whe a form is submitted. Using ActiveJDBC makes it trivial to accept a form as well as validate it:

~~~~ {.java  .numberLines}
Post p = new Post();
p.fromMap(params1st());
~~~~

The `Post` is an ActiveJDBC model. `params1st()` method returns a map of first values (the most typical case) of all submitted parameters,
 which are set in on call on a model instance. A  this point, it is easy to use ActiveJDBC validation to display a page
 with error messages defined on the `Post` model. See
 [PostController](https://github.com/javalite/javalite-examples/blob/master/kitchensink/src/main/java/app/controllers/PostsController.java)
 for more information.





In [ActiveWeb](activeweb):

~~~~ {.java  .numberLines}
@POST
public void create(){
    Book book = new Book();
    book.fromMap(params1st());
    if(!book.save()){
        flash("message", "Something went wrong, please  fill out all fields");
        flash("errors", book.errors());
        flash("params", params1st());
        redirect(BooksController.class, "new_form");
    }else{
        flash("message", "New book was added: " + book.get("title"));
        redirect(BooksController.class);
    }
}
~~~~

Here is a link to controller: [ActiveWeb BookController](https://github.com/javalite/javalite-examples/blob/master/activeweb-simple/src/main/java/app/controllers/BooksController.java)


Read next: [processing web requests implicit conversion](processing_web_requests_implicit_conversion). 