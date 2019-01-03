<div class="page-header">
   <h1>View routing</h1>
</div>


ActiveWeb allows  to render the same values and collections in a variety of formats, such as XML, JSON, etc, as long as they are
based on text (not binary).

## URL mapping

A URL can have the following structure:

    http://host:port/controller.format?param=val

where `format` is... format which can be detected to match an appropriate view


## Mapping URLs to formats

The format portion of the URL is used to map a view automatically:

| URL example                       | Format | View file location               |
|-----------------------------------|--------|----------------------------------|
|  http://host:port/controller.xml  | xml    | /vews/controller/action.xml.ftl  |
|  http://host:port/controller.json | json   | /vews/controller/action.json.ftl |
|  http://host:port/controller.xyz  | xyz    | /vews/controller/action.xml.ftl  |


where `xyz` is just a bogus example, which will work nonetheless!

## Format detection in controller

Inside the controller, you can use a method `format()` n order to detect what format was requested by the client.
Here is an example from [ActiveWeb-Simple](https://github.com/javalite/activeweb-simple) example project:

~~~~ {.java  .numberLines}
public class BooksController extends AppController {
    public void index(){
        if("xml".equals(format())){
            render().noLayout().contentType("text/xml");
        }
        if("json".equals(format())){
            render().noLayout().contentType("application/json");
        }
        view("books", Book.findAll().toMaps());
    }
~~~~

As  you can see, the detection of a format and appropriate logic is easy. The conditional logic in this example is needed only
because this controller serves HTML, XML and JSON outputs. Their respective sources are below.

The controller by calling `noLayout()` method tells the framework to not use a layout for these views.
If you are building a controller like this one, that may serve HTML, and in addition, XML or JSON, which do not require a layout,
you have to call these methods to prevent your view wrapped in an HTML layout.

 If you are building a true webservice, you will not need any layouts. You can then override the `getLayout()` methods
 in your controller and simply return `null` from it. Do it in a a super class of all controllers to concentrate this in one place.
Please, see such an example: [APIController](https://github.com/javalite/activeweb-rest/blob/master/src/main/java/app/controllers/APIController.java).


## HTML View

Found in a file: `src/main/webapp/WEB-INF/views/books/index.ftl`:

```html
<table>
    <tr>
        <td>Title</td>
        <td>Author</td>
        <td>Edit</td>
    </tr>
<#list books as book>
    <tr>
        <td>
            <@link_to action="show" id=book.id>${book.title}</@link_to>
        </td>
        <td>
            ${book.author}</td>
        <td>
            <@form  id=book.id action="delete" method="delete" html_id=book.id >
                <button type="submit">delete</button>
            </@form>
        </td>
    </tr>
</#list>
</table>
```

## XML View

Found in a file: `src/main/webapp/WEB-INF/views/books/index.xml.ftl`:

```xml
<books>
<#list books as book>
    <book>
        <id>${book.id}</id>
        <title>${book.title}</title>
        <author>${book.author}</author>
    </book>
</#list>
</books>
```

## JSON View

Found in a file: `src/main/webapp/WEB-INF/views/books/index.json.ftl`:

```json
[
<#list books as book>
    {
        "id": "${book.id}",
        "title": "${book.title}",
        "author": "${book.author}"
    }
    <#if book_has_next>,</#if>
</#list>
]
```
