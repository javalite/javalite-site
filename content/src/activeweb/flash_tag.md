<div class="page-header">
   <h1>Flash tag</h1>
</div>


Flash is a concept which does not exist in standard Java API, but is very useful in web applications. Flash is a snippet
of HTML whose life cycle is limited by the next HTTP request. In other words, a flash is created during a request, then
it can be used in a subsequent request (of the same session), after which it dies.

Flash messages are useful in cases when a POST/Redirect to GET pattern is used.

## Use case 1: pass message from controller

Flash messages are created in controllers (or filters) like so:

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

In a code of controller above, a new book is submitted in a POST request.

* Line 5 is making attempt to save the book information to DB.

* Lines 6, 7, 8  - in case of failure, three instances of flash are created: "message", "errors" and "params", where "message"
is a generic message displayed at the top of page, "params" is a map with submitted values
(it is used  to re-populate input fields) and the "error" is a map with error messages

* Line 11 -  In case of success request is redirected to BooksController index method and the flash message is sent to view.
The file `/views/books/index.ftl` would have a flash message displayed with "flash" tag:

~~~~ {.html  .numberLines}
<@flash name="message"/>
~~~~

> For a complete example of using FlashTag, please refer to [BooksController#save()](https://github.com/javalite/activeweb-simple/blob/master/src/main/java/app/controllers/BooksController.java#L45)
and corresponding views. Also, please see [ActiveJDBC Validation](validations)


The Flash tag automatically detects if a flash message exists and displays it. If a message is missing, nothing is rendered.

Since the user was redirected to the BooksController with an HTTP GET method, the page can simply be reloaded if a user
presses "Reload" button on browser. However, if a user actually reloads the page, the flash message will disappear,
because it cannot survive across more than one request.

In general, POST/Redirect to GET is a good programming pattern to use in case you need "destructive" operations.
Leaving a user on a POSTed page is a bad idea, because the same request can be re-submitted if user presses Reload.



## Use case 2: Named FlashTag with body

If you need to display a more complex HTML than a simple string, you can do so by placing a flash tag with body on the page: 

~~~~ {.html  .numberLines}
<@flash name="warning">
 <div class="warning">${message}</div>
</@flash>
~~~~

and calling a single argument method inside the controller: 

~~~~ {.java  .numberLines}
@POST
public void create(){
//.. code before
    flash("warning");
//.. code after
}
~~~~


The body inside the flash tag lives by the same rules as any other in the template. You can use variables, normal syntax, lists or even 
partials: 

~~~~ {.html  .numberLines}
<@flash name="warning">
<@render partial="message"/>
</@flash>
~~~~

It allows to organize code for error and warning messages into reusable componets. 


## Use case 3: Anonymous FlashTag with body

In case you only need one flash tag with body, no need to specify a name:

~~~~ {.html  .numberLines}
<@flash>
    <div class="message">Hello, this is a flash message!</div>
</@flash>
~~~~


In controller:

~~~~ {.java  .numberLines}
@POST
public void create(){
    //...
    flash();
    //...
}
~~~~

## Testing named flash with message 

If you set this in the controller: 

~~~~ {.java  .numberLines}
@POST
public class BooksController extends AppController{
    public void create(){
        // ...
        flash("success", "Your book was saved successfully")
        // ...
    }
}
~~~~


Then you can write a test like this:

~~~~ {.java  .numberLines}
public class BooksControllerSpec extends DBControllerSpec{
   public void shouldSaveBook(){
        request().params("title", "To Kill a Mockingbird", "author", "Harper Lee").post("save");
        the(flash("success")).shouldBeEqual("Your book was saved successfully");
   }
}
~~~~




## Testing named flash with body 

If you set this in the controller: 

~~~~ {.java  .numberLines}
@POST
public class BooksController extends AppController{
    public void create(){
        // ...
        flash("success")
        // ...
    }
}
~~~~

and your view looks like this: 

~~~~ {.html  .numberLines}
<@flash name="success">
    <div class="success">Your book was saved successfully!</div>
</@flash>
~~~~


Then you can write a test like this:

~~~~ {.java .numberLines}
public class BooksControllerSpec extends DBControllerSpec{
   public void shouldSaveBook(){
        request().params("title", "To Kill a Mockingbird", "author", "Harper Lee").post("save");
        the(flashExists("success")).shouldBeTrue();
        the(responseContent()).shouldContain("Your book was saved successfully!");
   }
}
~~~~



## Rendering dynamic snippets of HTML (old method)

Older method is still operational, but not recommended: 

~~~~ {.html  .numberLines}
<#if (flasher.message) ??>
   <span style="background-color:red">
   <@flash name="message"/>
   </span>
</#if>
~~~~

The HTML code inside the IF condition has no restrictions to use any dynamic values from session of those passed into view by controller.

## Internationalization of flash messages


The FlashTag is not internationalized. However, you can do this using one of two methods.


### Method 1: Use class Messages in controller

Lets say your `activeweb_messages_properties` file contains this entry:

    book_added=A book {0} was added to your library. Author: {1}

Please, refer to [org.javalite.activejdbc.Messages](http://javalite.github.io/activejdbc/snapshot/org/javalite/activejdbc/Messages.html)

In controller write this:

~~~~ {.java  .numberLines}
flash("saved", Messages.message("book_added", "Hunger Games", "Suzanne Collins"));
~~~~ 

In view: 

~~~~ {.html  .numberLines}
<@flash name="saved" />
~~~~

This will print:  

~~~~ {.html  .numberLines}
A book Hunger Games was added to your library. Author: Suzanne Collins
~~~~ 

### Method 2: Use MessageTag

Lets say your `activeweb_messages_properties` file contains this entry:

~~~~ {.html  .numberLines}
book_added=A book was added to your library.
~~~~ 

In controller:

~~~~ {.java  .numberLines}
flash("saved");
~~~~ 

In view: 


~~~~ {.html  .numberLines}
<@flash name="saved">
  <@message key="book_added"/>
</@flash>
~~~~ 


This will print: 
    
~~~~ {.html  .numberLines}
A book {0} was added to your library. Author: {1}
~~~~ 

Method 1 should be used when you have parametrized messages. There is no way to pass a parameter to the MessageTag in method 2, 
because it is running in a different request (after redirect).

Choose a method that most appropriate for your app.
