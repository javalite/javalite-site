<div class="page-header">
   <h1>In clause</h1>
</div>




In some cases you need to write something like this:

~~~~ {.prettyprint}
SELECT my_column FROM my_table where search_column IN (?)
~~~~

Unfortunately this feature is not supported by JDBC, hence we have workarounds like these:
[Preparedstatement IN clause alternatives/StackOverflow](http://stackoverflow.com/questions/178479/preparedstatement-in-clause-alternatives)


## 'IN' Clause Workaround

The workaround is pretty simple, if you want to execute this:

~~~~ {.java  .numberLines}
String sql = "name IN ('John', 'Hellen', 'Henry')";
~~~~

Then you join this list with single quotes and commas:

~~~~ {.java  .numberLines}
List names = Util.list("John", "Hellen", "Henry");
List<Person> people = Person.where("name IN ('" + Util.join(names, "', '") + "')");
~~~~

You can use this approach with relatively small lists, as the bigger the list, the longer the generated query. Every database has a limit on size of a query,
so  your mileage may vary.


> Please, see references to methods [Util#join](http://javalite.github.io/activejdbc/snapshot/org/javalite/common/Util.html#join-java.lang.String:A-java.lang.String-)
and [Collections#list](http://javalite.github.io/activejdbc/snapshot/org/javalite/common/Collections.html#list-T...-) .
These classes are already on a classpath of every ActiveJDBC application.



