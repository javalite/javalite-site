<div class="page-header">
   <h1>Clob support and caching</h1>
</div>



While ActiveJDBC supports Clobs, developers should be aware that even though the APIs are easy to use, they could
stumble upon performance problems due to Clob sizes.

## Writing a Clob

For instance, if you have a table ARTICLES, which has a column CONTENT type of Clob, the writing into this column is
not any different than writing into a VARCHAR or any other text field:

~~~~ {.java  .numberLines}
Article a = new Article():
a.set("content", articleContent);
a.saveIt();
~~~~

Here, the string `articleContent` will be converted to a Clob by underlying JDBC driver. In other words, ActiveJDBC
support here is minimal.

## Reading from a Clob directly

ActiveJDBC does not perform an implicit data conversion. This means that the `get("name")` method will return exactly
the type that is provided by the driver. Armed with this knowledge, we can write code to fully read information from the Clob:

~~~~ {.java  .numberLines}
Article a = Article.findById(100);
Clob c = (Clob)a.get("content");
///read from Clob...
~~~~

## Convenient method for reading from a Clob

Since ActiveJDBC does not do implicit data conversions, it does provide explicit convenient methods for conversion.
One such method is `getString()`:

~~~~ {.java  .numberLines}
Article a = Article.findById(100);
String content = a.getString("content");
~~~~

In the example above, the Model will detect if this value is type Clob, and will read all content from it completely,
converting it into a String.

## Clobs in cached models

ActiveJDBC provides a mechanism of [Caching](caching). This means that entire resultsets of models filled with data will
be cached, and will exist in memory for some time. Clobs themselves would need an original JDBC `Connection`
object to read the data from (that was not closed yet). Unfortunately, there is no guarantee, that the connection is
still around if you are accessing a cached list of objects from a Cache Manager after the connection was closed.

ActiveJDBC then makes a distinction between cached models and the ones that are not cached. In cases of regular models,
it does not do anything special because it assumes that the Clobs are read immediately after models are selected and hydrated.

In cases of Cached models, ActiveJDBC performs an exhaustive read of content from Clobs, and conversion of them
into `java.lang.String`s. This allows to access the content of Clobs from cached models long after the connection was closed.

Getting strings is the same as in the first case:

~~~~ {.java  .numberLines}
String articleContent = a.getString("content");
~~~~

> If your model is cached, and uses Clobs that are large in size, you will (eventually) have huge RAM allocation problems.
Try to keep Clob sizes small for cached models, or not cache them at all.

For more information on caching, see [Caching](caching).
