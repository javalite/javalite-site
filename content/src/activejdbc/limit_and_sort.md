<div class="page-header">
   <h1>Limit and sort</h1>
</div>



Sometimes, you only need a few records to page through a resultset. This style of data usage is usually found in web applications.
An example could be paging through a catalog of products.

## Limiting Resultsets

The "finder" methods, such as `find()`, `findAll()` and `where()` return an instance of a `LazyList`. This class has a
 method called `limit(int)`. It will limit a number of results in the resultset when your programs starts to:

~~~~ {.java  .numberLines}
List<Person> people = People.findAll().limit(20);
~~~~

## Offsetting start of a page

Once you got a first page, you might want to get a next one. This is done with the offset method, found on the same `LazyList` class like so:

~~~~ {.java  .numberLines}
List<Person> people = People.findAll().limit(40).offset(20);
~~~~

The code snippet above will find and return 40 records, starting with the 21st record, inclusive.

## Ordering results (putting all together Fluent Interfaces style )

Usually, you would limit, offset and order results in one statement:

~~~~ {.java  .numberLines}
List<Person> people = People.findAll().limit(40).offset(20).orderBy("age asc");
~~~~

Sometimes this style of programming is called [Fluent Interfaces](http://martinfowler.com/bliki/FluentInterface.html) and
is credited to Martin Fowler. This style of API is concise, readable and self explanatory.

## Paginating for the web

Although `limit`, `offset` and `orderBy` themselves are quite simple and powerful methods, ActiveJDBC also provides a
convenience class called `Paginator` especially designed for web applications:

~~~~ {.java  .numberLines}
Paginator p = new Paginator(Page.class, 10, "description like ?", "%Java%").orderBy("created_at desc");
List<Page> items = p.getPage(1);
List<Page> items = p.getPage(2);
~~~~

The instances of this class are lightweight and usually attached to a session. It can be queried for a current page displayed:

~~~~ {.java  .numberLines}
int currentPage = paginator.getCurrentPage();
~~~~

and for page count like this:

~~~~ {.java  .numberLines}
int pageCount = paginator.pageCount();
~~~~

Using this class in a context of a web application makes it easy to build paging through resultsets.
