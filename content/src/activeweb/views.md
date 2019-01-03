<div class="page-header">
   <h1>Views</h1>
</div>


Views in ActiveWeb are also called templates. They are located in the following directory:

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views
~~~~

## No JSPs

ActiveWeb does not use JSPs. The main reason for not using JSPs is their inability to test generated HTML with JSPs in a
test environment. For more on testing, see ... [Generating views in tests](testing#generating-views-during-testing).

## ActiveWeb uses FreeMarker

ActiveWeb uses FreeMarker as a templating engine. Please see [Freemarker](http://freemarker.org/) for more information.

The framework provides a pluggable architecture that allows to integrate any other engine, such as Velocity, as long as it
implements [TemplateManager](https://github.com/javalite/activeweb/blob/master/activeweb/src/main/java/org/javalite/activeweb/TemplateManager.java)
interface.

## FreeMarker configuration

Freemarker configuration is optional. If an application needs to have access to configuration of Freemarker, the application
needs to have a class:

~~~~ {.java  .numberLines}
package app.config;
public class FreeMarkerConfig extends AbstractFreeMarkerConfig {
    @Override
    public void init() {
        //this is to override a strange FreeMarker default processing of numbers
        getConfiguration().setNumberFormat("0.##");
     }
}
~~~~

This class extends `AbstractFreeMarkerConfig`, which provides an instance `freemarker.template.Configuration` class,
allowing to perform configuration on FreeMarker. The lines of code presented above are recommended default configuration.

## Templates

ActiveWeb templates are in fact FreeMarker templates. However, there are a number of ActiveWeb conventions for template
naming and placement. Templates are located in sub-directories of this top directory:

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views
~~~~

The sub-directories are usually named after controllers. Controller name would loose suffix "Controller", and the
remainder would be transformed from CamelCase to under_score, for example, `HomeController` templates are located in sub-directory

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views/home
~~~~

and `OuterSpaceController` templates are located in:

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views/outer_space
~~~~

Controller package is not considered in search of templates. Usually templates belong to a controller, but there can
also be shared template. In that case, you can create any arbitrary directory under template views directory and
place your shared templates there:

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views/shared
~~~~


## Layouts

Layouts are a way to decorate a page with additional HTML. ActiveWeb layouts serve the same purpose as frameworks Apache
Tiles or Sitemesh. Using a layout you decorate every page with the same header, footer, and other common elements for your application.
Layouts are FreeMarker templates like any other.

### Default layout

A default layout is called `default_layout.ftl` and located in the layouts directory along with other template directories:

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views/layouts/default_layout.ftl
~~~~

Default layout is used by default to wrap any page generated as a result of controller execution. The content of the
`default_layout.ftl` from a startup project looks like this (few lines omitted for clarity):

~~~~ {.html  .numberLines}
<title>ActiveWeb - <@yield to="title"/></title>
<div class="main">
    <#include "header.ftl" >
<div class="content">
    ${page_content}
</div>
    <#include "footer.ftl" >
</div>
~~~~

* **Line 1** has a `<@yield` tag. For explanation, please see section below.
* **Line 3** includes a `header.ftl`, which is another template with code for the top portion of your site. It is not strictly
necessary, since you can copy all code from header directly into layout, but it is a good practice to keep it in a separate file.
* **Line 7** serves the same purpose for footer
* **Line 5** is where entire page generated from rendering a controller response is inserted.

### ContentFor and Yield tags

When using layout, you quite often need to pass information from a rendered page up to a layout. Examples are: page title.
As in the example of a layout above, on line 3, there is a `title` tag, but the information for title of a page is of
course in the page itself. The tags `content for` abd `yield` work together to allow to pass information from page up to a layout.

#### Simple ContentFor  and Yield case

Here is an example of passing a page title from a page template to layout:

~~~~ {.html  .numberLines}
<@content for="title">Books List</@>
~~~~

When the entire page with layout is rendered, the  line 3 will read like this:

~~~~ {.html  .numberLines}
<title>ActiveWeb - Books List</title>
~~~~


Think of `<@content for..` as setting some content for a location in layout, and `yield` as yielding to that content.

> `<@content for..` for and `yeld` are not limited to sending plain text, you can send arbitrary HTML chunks, including `<script>` tags, CSS,
links to various resources, etc.

This feature is useful to inject a JavaScript library into a layout from a page in cases you only need this JavaScript
code on this one page. This way loading a library will be avoided for all other pages, where it is not used.

#### Multiple chunks of `content for`  for single `yield`

Sometimes you need to send multiple chunks of text from a page to layout. You can declare more than one `<@content for`
with the same yield target:


~~~~ {.html  .numberLines}
<@content for="js">
<script type="text/javascript">
    Window.alert("hello1");
</script>
</@>
~~~~

and more:

~~~~ {.html  .numberLines}
<@content for="js">
<script type="text/javascript">
    Window.alert("hello2");
</script>
</@>
~~~~

... declare more if needed


The yield tag in layout looking like this:

~~~~ {.html  .numberLines}
<@yield to="js"/>
~~~~

It will generate the following output in its place:

~~~~ {.html  .numberLines}
<script type="text/javascript">
    Window.alert("hello1");
</script>
<script type="text/javascript">
    Window.alert("hello2");
</script>
~~~~


### Rendering without layout

By default ActiveWeb will use a `/views/layouts/default_layout.ftl`. However, in some cases you do not need a layout (for
instance, you are developing a web service or responding to Ajax calls). You can return a layout rendering programmaticaly from controller:

~~~~ {.java  .numberLines}
public class HomeController extends AppController {
    public void index() {
      render().noLayout();
    }
}
~~~~

In this case, the template will be rendered without a layout. 

### Override default layout

If you wonder how default layout is set, the answer is simple: the class `AppController` has a method `String getLayout()`
which returns a string with value `/layouts/default_layout`. The easiest way to change a layout for a controller is
to override this method to return a different value.

~~~~ {.java  .numberLines}
public class DifferentLayoutController extends AppController {
    @Override
    protected String getLayout() {
        return "/layouts/my_other_layout";
    }
}
~~~~

If you have 2 - 3 super classes for controllers that override this method, you can have different areas of the site
decorated by different layouts, based on which child controller is rendering.


~~~~ {.java  .numberLines}
public class HelloController extends AppController {
    public void show() {
        // code to add stuff to view ...
        render().layout("my_special_layout");
    }
}
~~~~

In the example above,   a layout is overridden only for a specific action. 
    

##Partials

Partials are snippets of HTML pages, hence the word. Usually they host chunks of code repeating in a few places.
In much the same way that a regular programming language allows develpers to refactor and keep repeating patterns of
code in one place, partials a used to keep HTML code that is repeated. It is not to say though that you cannot put any
arbitrary HTML code, you can.

The main power of partials is in their ability to iterate HTML snippets over data collections, as well as ability to
"widgetize" HTML junks.

Partials are somewhat similar to JSP includes, but they have some special characteristics that JSPs do not.

### Partials naming and location

Partials are FreeMarker templates as any other, but the name of file must start with underscore:

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views/greeting/_hello.ftl
~~~~

Location of partials is the same as for regular templates, that is they are located in sub-directories of the top
view directory.

### Include partials with Render tag

Partials are included into a host page with a Render tag. Lets say there is a template called `index.ftl` located in
directory `market` and partial `_fruit.ftl` located in the same directory:

~~~~ {.prettyprint}
src/main/webapp/WEB-INF/views/market/index.ftl
src/main/webapp/WEB-INF/views/market/_fruit.ftl
~~~~

then you can render `_fruit.ftl` inside `index.ftl` like this:

~~~~ {.html  .numberLines}
<@render partial="fruit"/>
~~~~

As you can see, when you are referring to a partial, you _specify name without underscore_.

> The Render tag requires at least one attribute present: "partial" which refers to a local or shared partial by name.

### Rendering shared partials

In a previous example, you can see that a partial was co-located with the host template. Sometimes you need to render
a partial in a number of templates. To accomplish this, you can place a partial into a new view directory and refer
to a partial with "absolute" path, such as:

~~~~ {.html  .numberLines}
<@render partial="/shared/fruit"/>
~~~~

This assumes that you have a partial fruit at this location:
~~~~ {.html  .numberLines}
src/main/webapp/WEB-INF/views/shared/_fruit.ftl
~~~~

Use this technique to include a common widget across multiple templates.

### Iterating with partials

It is quite common to iterate over collections in a web application. Sometimes  you need to build a `<ul>` list
or repeating pattern of HTML code. Usually developers resort to loops inside templates, and although FreeMarker provides
this functionality, using partials provides a cleaner solution, as partials can iterate automatically.

Lets say we have a partial called `_fruit.ftl`:

~~~~ {.html  .numberLines}
Fruit name: ${fruit}<hr>
~~~~

If we have a collection named fruits in context (`java.util.List` passed from controller) with these values: ["apple", "prune", "pear"],
then we can render this partial as a collection from host page like this:

~~~~ {.html  .numberLines}
<@render partial="fruit" collection=fruits/>
~~~~

Rendering will result in this output:

~~~~ {.html  .numberLines}
Fruit name: apple<hr>Fruit name: prune<hr>Fruit name: pear<hr>
~~~~

> Convention: the iteration variable inside of a partial is the same as the name of partial

Iteration is easier with partials compared to loops. The partial will take care ot iterating automatically.

### Implicit counter in partial

Partials iterating over a collection have a built-in implicit variable maintaining an index of a collection. The name of
this variable is made up of a name of a partial and word "counter". This means that for the above example, the name will
be "fruit_counter". You can use this value inside a partial like any other context value. The above example with
the counter modification:

~~~~ {.html  .numberLines}
Fruit name: ${fruit}, index: ${fruit_counter}<hr>
~~~~

will yield:

~~~~ {.html  .numberLines}
Fruit name: apple, index: 0<hr>Fruit name: prune, index: 1<hr>Fruit name: pear, index: 2<hr>
~~~~

### Partials with collections and spacers

Notice in above examples  that the horizontal line `<hr>` is rendered at the bottom of each iteration of a partial.
This is because it is really a part of a partial. It is quite common that you need to space the iterating snippets of
HTML with some sort of a spacer made up of arbitrary HTML. Partials provide this capability with the use of a
"spacer" partial. Lets say we use this partial as a spacer
(located in `src/main/webapp/WEB-INF/views/shared/_divider.ftl`):

~~~~ {.html  .numberLines}
<div class="spacer"></div>
~~~~

If we then render our fruits with this spacer such that:

~~~~ {.html  .numberLines}
<@render partial="fruit" collection=fruits spacer="divider"/>
~~~~

we will get the following output:

~~~~ {.html  .numberLines}
Fruit name: apple<hr><div class="spacer"></div>
Fruit name: prune<hr><div class="spacer"></div>
Fruit name: pear<hr>
~~~~

As you can see, the content of the spacer was inserted between the elements of the iterating partial, and the good
thing is that it was not appended after the last iteration.


### Passing arguments to partials

You can pass an argument value to a partial in much the same way as you can to a method.

Lets say we have a host template:

~~~~ {.html  .numberLines}
<@render partial="fruit_name" a_fruit=fruit_name/>
~~~~

and a partial (`_fruit_name.ftl`) with content:

~~~~ {.html  .numberLines}
Fruit name is: ${a_fruit}
~~~~

Then the output of a partial will be:

~~~~ {.html  .numberLines}
Fruit name is: apple
~~~~

considering that there is a variable `fruit_name` in context. This variable could be passed in by controller, or created inside the template. The types of values passed in like this are not limited to strings.


### Boundary indicators for collection partials

If you have a partial that iterates over a collection and you need to render special content conditionally if this is
a first or last time in the iteration, you can use special variables set by the framework called `first` and `last`:

~~~~ {.html  .numberLines}
<#if first>
I'm the first in line
</#if>

<#if last>
I'm the last in line
</#if>

more content...
~~~~


## Message tag

The message tag is designed to display messages in view templates. Message values are defined in resource bundle called
`activeweb_messages`. This means that this tag will be looking for file called `activeweb_messages.properties` as default name and
others, such as `activeweb_messages_fr_FR.properties` in case French locale was specified.

Examples:

### Simple usage

Given that there is a file `activeweb_messages.properties` with content:

~~~~ {.prettyprint}
greeting=Hello
~~~~

and tag code:

~~~~ {.html  .numberLines}
<@message key="greeting"/>
~~~~

then the output will be:

~~~~ {.html  .numberLines}
Hello
~~~~



### Message with parameters

Lets say a message in resource bundle is declared like this:

~~~~ {.prettyprint}
meeting=Meeting will take place on {0} at {1}
~~~~

You can then specify the tag with parameters:

~~~~ {.html  .numberLines}
<@message key="meeting" param0="Wednesday" param1="2:00 PM"/>
~~~~

When a view template renders, the outcome will be:

~~~~ {.prettyprint}
Meeting will take place on Wednesday at 2:00 PM
~~~~

### Defaulting to key if value not found

In case a resource bundle does not have a key specified, the key is rendered as value verbatim:

~~~~ {.html  .numberLines}
<@message key="greeting"/>
~~~~

The output:

~~~~ {.html  .numberLines}
greeting
~~~~

### Detection of locale from request

If there is a locale on the request supplied by the agent, then this locale is automatically picked up by this tag.
For instance, if a browser supplies locale "fr_FR" and there is a corresponding resource bundle: `activeweb_messages_fr_FR.properties`,
with this property:

~~~~ {.prettyprint}
greeting=Bonjour
~~~~

then this tag:

~~~~ {.html  .numberLines}
<@message key="greeting"/>
~~~~

will produce:

~~~~ {.prettyprint}
Bonjour
~~~~

### Overriding request locale

There is a "locale" argument you can pass to the tag to override the locale from request:

~~~~ {.html  .numberLines}
<@message key="greeting" locale="de_DE"/>
~~~~



## link_to tag and unobtrusibe JavaScript

ActiveWeb provides a `<@link_to/>`. This tag generates an HTML anchor tag and is capable of regular HTML links, as
well as Ajax capability.

> Unobtrusive `link_to` functions require that you have the [aw.js](https://github.com/javalite/kitchensink/blob/master/src/main/webapp/js/aw.js) script  file loaded on your page. 

### Attributes for configuration

* `controller` : path to controller, such as: `/admin/permissions` where "admin" is a sub-package and "permissions" is a
name of a controller. In this example, the controller class name would be: `app.controllers.admin.PermissionsController`.
If a controller path is specified, the preceding slash is mandatory. Optionally this could be a name of a controller
from a default package: "permissions", and in this case, the controller class name is expected to be `app.controllers.PermissionsController`.
If a name of controller is specified, the preceding slash can be omitted. This attribute is optional. If this attribute is omitted,
 the tag will use the controller which was used to generate the current page. It makes it convenient to write links on
 pages for the same controller.
* `action` : name of a controller action (method). Optional. If this attribute is omitted,
the action will default to "index".
* `id`: id, as in a route: `/controller/action/id`. Optional.
* `html_id` : value of this attribute will be used to set the HTML ID of the Anchor element. Optional.
* `query_string`: query string as is usually used in GET HTTP calls - part of a URL after the question mark.
Optional. Either `query_string` or `query_params` allowed, but not both.
* `query_params` : `java.util.Map` with key/value pairs to be converted to query string. Optional. Either
`query_string` or `query_params` allowed, but not both.
* `destination` : id of an element on page whose content will be set with a result of an Ajax call. Optional.
* `form` : id of a form element on the page, whose content will be serialized into the Ajax call. This content will be submitted to the server controller/action as input. Optional.
* `method` : HTTP method to use. Acceptable values: GET (default), POST, PUT, DELETE. Optional.
* `before` : Name of a JavaScript function to call before making Ajax call. Optional. This function does not receive any arguments.
* `before_arg` : Value for the JS function argument provided in "before" attribute. This could be an ID of an element,
string, or any other arbitrary parameter. Any object will be converted to string. Optional.
* `after` : Name of a JavaScript function to call after making Ajax call. This function receives the value of a
`after_arg` attribute as a first argument and result of the Ajax call as a second argument. Optional.
* `after_arg` : Value for the JS function argument provided in "after" attribute. This could be an ID of an element,
string, or any other arbitrary parameter. Any object will be converted to string. Optional.
* `confirm` :  Presents a JavaScript confirmation dialog before making an Ajax call. The dialog will present the text
with content from the attribute value.  If No or Cancel was selected on the dialog, the Ajax call is not made. Optional.
* `error` : Name of a JS function which will be called in case there was an Ajax error of some sort. The first
parameter is HTTP status code, the second is response text sent from server.


### Example 1: Non-Ajax link

~~~~ {.html  .numberLines}
<@link_to controller="books" action="fetch">Get Books</@>
~~~~

This will generate a simple non-Ajax link, such as: "..books/fetch"

### Example 2: Ajax link, sets data to destination element

~~~~ {.html  .numberLines}
<@link_to controller="books" action="fetch" destination="result">Get Books</@>
~~~~

This will generate a simple Ajax link. The method by default is GET. After Ajax call, the result will be inserted into
an element with ID: "result", similar to: `<div id="result"></div>`


### Example 3: Confirmation and before/after callbacks


~~~~ {.html  .numberLines}
<@link_to controller="books"  id="123"
         method="delete" before="beforeDelete" after="afterDelete"
         confirm="Are you really sure you want to delete this book?">Delete Book</@>

function beforeDelete(beforeArg) { ... }
function afterDelete(afterArg, data) { ... }
~~~~

Here, the JS confirmation dialog will present the message before posting an Ajax call,
then function `beforeDelete` will be called. After that, it will make an Ajax call,
and will execute function `afterDelete`, passing it the result of Ajax invocation as an argument. In the JS code
above, the `beforeArg` and `afterArg` arguments have values null since the `before_arg` and `after_arg` attributes were not used.

### Example 4: Before/after callback arguments

~~~~ {.html  .numberLines}
<@link_to controller="books" action="fetch" before="doBeforeWithArg" before_arg="books_result" after="doAfterWithArg"
 after_arg="books_result">Get Books</@>
~~~~

This code expects to find JS functions similar to these:

~~~~ {.javascript}
function doBeforeWithArg(elm) {
    $("#" + elm).html("wait...");
}

function doAfterWithArg(elm, data) {
    $("#" + elm).html(data);
}
~~~~

This is presuming that there is an element like this on the page:

~~~~ {.html  .numberLines}
<div id="books_result"></div>
~~~~

In this example, the "books_result" string is passed as argument to "doBeforeWithArg" as only one argument and the same is passed as a first argument to function "doAfterWithArg". The second argument to the "doAfterWithArg" is a result of Ajax invocation (presumably HTML representing books generated from some partial).

### Example 5 - Error handling

~~~~ {.html  .numberLines}
<@link_to controller="books" action="doesnotexist" error="onError" destination="callbacks_result">Will cause error</@>

<script>
function onError(status, responseText) {
    alert("Got error, status: " + status + ", Response: " + responseText);
}
</script>
~~~~


In this example, the link is making an Ajax call to a controlled action which does not exists. This causes onError() function to be triggered.

## FlashTag

Please, see: [FlashTag](flash_tag)


## SelectTag

Select tag generates the `<select>` HTML tag based on data passed in dynamically into a view.
Parameters:

*  **list** - is a mandatory parameter, and it needs to be type of `java.util.List<SelectOption>`

In addition to the collection, you can also add body to the tag. For instance, if you write the tag like this:

~~~~ {.html  .numberLines}
<@select list=books>
   <option>Please, make a selection</option>
</@>
~~~~

And pass this data from controller:

~~~~ {.java  .numberLines}
public class BooksController extends AppController{
   public void index(){
       view("books", list(new SelectOption(1, "The Hitchhiker's Guide to the Galaxy"),
                          new SelectOption(2, "All Quiet on Western Front", true)));
   }
}
~~~~

then the output from the tag will be:

~~~~ {.html  .numberLines}
<select>
    <option>Please, make a selection</option>
    <option value="1">The Hitchhiker&amp;aposs Guide to the Galaxy</option>
    <option value="2" selected="true">All Quiet on Western Front</option>
</select>
~~~~

As you can see, the first hardcoded option was preserved, and  the dynamic options were added below it. 
The first options is usually used in forms to force the user to make any selection in this input.



## FormTag

`<@form/>` tag generates an HTML form tag and has functionality specific for ActiveWeb. Like any other ActiveWeb tag,
it has ability to pass through any non - ActiveWeb attributes. This means that if you specify any attribute that is not
mentioned here, it will be passed through as a regular HTML attribute.

Attributes:

* `controller` - name of a controller to post this form to. Optional. If this attribute is not provided, the tag will
find a current controller in context which was used to generate a data for the current view and uses it.  It makes
it convenient to write many views for the same controller.
* `action` - name of an action to post this form to.This is different from  regular HTML form@action attribute, as
controller, action and id attributes will be used to form an appropriate HTML form action value.  Optional.
* `id` - value of URI "id". Used as URI "id" in forming an HTML Form action attribute, such as: `<form action="controller/action/id"`
do not confuse with html element id optional
* `html_id` - value of HTML Form element ID, as in `<form id="my_form" ... >`
* `method` - HTTP method. Allowed values: GET (default), POST, PUT, DELETE

In case the values are "put" or "delete", additional hidden input names `_method` will be generated, and the actual HTML
method will be set to "post". This workaround is necessary because browsers still do not support PUT and DELETE. Optional.


Examples (given that the current context is "example"):

### Simple form

code:

~~~~ {.html  .numberLines}
<@form controller="simple" action="index" method="get"/>
~~~~

will generate this HMTL:

~~~~ {.html  .numberLines}
<form action="/example/simple/index" method="get" />
~~~~

POST form with ID
code:

~~~~ {.html  .numberLines}
<@form controller="simple" action="index" id="123" method="post" html_id="formA"/>
~~~~

will generate:

~~~~ {.html  .numberLines}
<form action="/example/simple/index/123" method="get" id="formA" />
~~~~



### PUT form

code:

~~~~ {.html  .numberLines}
<@form controller="simple" action="index" method="put">
     <input type="hidden" name="blah">
</@>
~~~~ {.html  .numberLines}

will generate this HMTL:

~~~~ {.html  .numberLines}
<form action="/example/simple/index" method="put" id="formA" >
    <input type="hidden" name="_method" value="put">
    <input type="hidden" name="blah">
</form>
~~~~


### PUT form for RESTful controller

FormTag also is REST-aware, and will generate appropriate formats for HTML Form tag action value depending if the
controller is RESTful or not.

code:

~~~~ {.html  .numberLines}
<@form controller="photos"  id="x123" method="put" html_id="formA">
      <input type="hidden" name="blah">
</@>
~~~~

will generate:

~~~~ {.html  .numberLines}
<form action="/example/photos/index" method="put" id="formA" >
    <input type="hidden" name="_method" value="put">
    <input type="hidden" name="blah">
</form>
~~~~

## Debug tag

Debug tag prints an arbitrary object from page context. FreeMarker special handling of types sometimes makes it hard
to see the value(s) of an object when debugging, but this tag makes it easy:

~~~~ {.html  .numberLines}
<@debug print=objectname/>;
~~~~

For instance, for a `java.util.Map` object it will print this:

~~~~ {.prettyprint}
{key1=value1, key2=value2}
~~~~

## Custom tag development

TODO

## System error pages

### General

ActiveWeb will render two system error pages under typical error conditions: `/views/system/404.ftl` and `/views/system/error.ftl`.

The 404.ftl is rendered in cases resources are not found:

* Controller is missing
* Controller has a compilation problem (development mode )
* Action method is missing
* View template is missing

The `error.ftl` will be rendered in cases:

* Template has a problem rendering
* Any internal application problem
* Internal framework exception

In all these cases, the definitive exception will be printed to the log.

### Use custom layouts with system error pages

By default, error pages are displayed in default layout `/views/layouts/default_layout.ftl`. In some cases, you want to conditionally display error pages in different layouts. This can be achieved by turning the default layout for error pages off:

~~~~ {.java  .numberLines}
public class AppBootstrap extends Bootstrap {
    public void init(AppContext context) {
        Configuration.setUseDefaultLayoutForErrors(false);
    }
}
~~~~

and then using a `<@wrap ..>` tag inside pages:

~~~~ {.html  .numberLines}
<@wrap with="/layouts/system_error_layout">
    <h1>404 - Resource Not Found</h1>
</@>
~~~~

### Exception parameters passed into error views

There are two parameters that the framework passes into error views:


* `message`
* `stack_trace`

These can be rendered on a page as any other parameters:

~~~~ {.html  .numberLines}
Error message: <code>${message}</code>
Stack trace: <code>{stack_trace}</code>
~~~~

However, this information is only interesting to developers, and usually not displayed to end users.
