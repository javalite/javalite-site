<div class="page-header">
   <h1>Testing with database connection</h1>
</div>

ActiveJDBC Models are easy to test, and there is a convenience class for opening and closing 
connections during tests. 

## Test database for testing

It is customary for JavaLite projects to use **one database** for testing and a **different** one for running the system locally. 
It makers it easy to preserve data in place in the "development" database, and still use the full power of database access 
to your test database during tests.

For example, you could have some user data in a development database which will allow you to log in, and perform other
operations, and yet you can run test logic against your test database, destroy and re-create any data in it, without
having to wipe clean your development database.


## DBSpec for database tests

`org.javalite.activejdbc.test.DBSpec`  is a super-class for tests that require a database connection. It is integrated with
[database file  configuration](database_configuration#property-file-configuration) and will automatically open a corresponding database connection before
a test execution and close it after the test.

> Please, see more on environments on [database file configuration](database_configuration#property-file-configuration) page.


## Example of a `DBSpec` test

Lets say we are developing a blog, and we need to persist a post. A post will have title, content and author.
All these attributes are required. Here is an example of a model we are testing: 


~~~~ {.java  .numberLines}
public class Post extends Model {
    static {
        validatePresenceOf("title", "content");
        validatePresenceOf("author").message("Author must be provided");
    }
}
~~~~


A test will look like this:

~~~~ {.java  .numberLines}
public class PostSpec extends DBSpec {
    @Test
    public void shouldValidateRequiredAttributes() {
        Post post = new Post();
        a(post).shouldNotBe("valid");
        a(post.errors().get("author")).shouldBeEqual("Author must be provided");
        post.set("title", "fake title", "author", "fake author", "content", "fake content");
        a(post).shouldBe("valid");
        post.save();
        a(post.getId()).shouldNotBeNull();
        a(Post.count()).shouldBeEqual(1);
    }
}
~~~~

Technically speaking, you can use it for any test requiring a connection, but it is also easy to use for Model tests.
 
### Steps of execution 

In the test above the `DBSpec` will: 

1. open a test connection defined in `database.properties`
2. start a transaction
3. make connection available during tests
4. roll back transaction after the test execution to keep the database clean 
5. close the connection

This class allows for tests to run in a "clean room" environment, since the database tables  will always have a 
clean state for any given test.
  
## Non-models database  tests 
  
While `DBSpec` is usually used to test models, it can be used to test any code that require a database connection.
If you need to get a hold of that connection, you can use class `Base`:

~~~~ {.java .numberLines}
java.sql.Connection connection = Base.connection();
~~~~
