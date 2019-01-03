<div class="page-header">
   <h1>Generation of json</h1>
</div>


In context of a web application, especially when dealing with Ajax, it is handy to have your classes convert to to JSON to send to a browser. If you have a complex model with custom classes to be sent over, you will most likely write your JSON generation code, if however all you need is to convert ActiveJDBC models to JSON, this functionality is already available from your models without extra effort.

In more complicated situation, they probably would write some JSON generation code. However under simple condition, classes Model and LazyList already provide the basics.

## Generate simple JSON from a model

Here is code that will provide stock JSON from a model:

~~~~ {.java  .numberLines}
Person p  = (Person)Person.findById(1);
String json = p.toJson(true);
~~~~

The JSON produced will look something like this:

~~~~ {.json}
{
  "type":"org.javalite.activejdbc.test_models.Person",
  "id":"1",
  "updated_at":"2011-02-23 22:18:11.0",
  "graduation_date":"1954-12-01",
  "name":"John",
  "dob":"1934-12-01",
  "last_name":"Smith",
  "created_at":"2011-02-23 22:18:11.0"
}
~~~~

The boolean parameter to the method `toJson()` is whether to generate human readable format or a single string.

## Specify output attributes for generated JSON

A variation on the example above is to provide a list of attributes that you are interested in,
so that only these attributes are included:

~~~~ {.java  .numberLines}
Person p  = (Person)Person.findById(1);
String json = p.toJson(true, "last_name", "dob");
~~~~

The resulting JSON will only include the attributes specified:

~~~~ {.json}
{
  "dob":"1934-12-01",
  "last_name":"Smith"
}
~~~~

## Inclusion of dependencies

When a model is has relationships, the generated JSON will loop through them to include their
JSON into the parent JSON as well:

~~~~ {.java  .numberLines}
List<User> personList = User.findAll().orderBy("id").include(Address.class);
User u = personList.get(0);
String json = u.toJson(true);
~~~~

result:

~~~~ {.json}
{
  "type":"org.javalite.activejdbc.test_models.User",
  "id":"1",
  "first_name":"Marilyn",
  "email":"mmonroe@yahoo.com",
  "last_name":"Monroe",
  "children" : {
    addresses : [
    {
      "type":"org.javalite.activejdbc.test_models.Address",
      "id":"1",
      "zip":"60606",
      "state":"IL",
      "address1":"123 Pine St.",
      "address2":"apt 31",
      "user_id":"1",
      "city":"Springfield"
    },
    {
      "type":"org.javalite.activejdbc.test_models.Address",
      "id":"2",
      "zip":"60606",
      "state":"IL",
      "address1":"456 Brook St.",
      "address2":"apt 21",
      "user_id":"1",
      "city":"Springfield"
    },
    {
      "type":"org.javalite.activejdbc.test_models.Address",
      "id":"3",
      "zip":"60606",
      "state":"IL",
      "address1":"23 Grove St.",
      "address2":"apt 32",
      "user_id":"1",
      "city":"Springfield"
    }
    ]
  }
}
~~~~

## Generate JSON from a resultset

Generating JSON from a LazyList is equally easy:

~~~~ {.java  .numberLines}
LazyList<User> personList = User.findAll().orderBy("id").include(Address.class);
String json = personList.toJson(true);
~~~~

An example of generated JSON:

~~~~ {.json}
[
  {
    "type":"org.javalite.activejdbc.test_models.User",
    "id":"1",
    "first_name":"Marilyn",
    "email":"mmonroe@yahoo.com",
    "last_name":"Monroe",
    "children" : {
      addresses : [
        {
        "type":"org.javalite.activejdbc.test_models.Address",
        "id":"1",
        "zip":"60606",
        "state":"IL",
        "address1":"123 Pine St.",
        "address2":"apt 31",
        "user_id":"1",
        "city":"Springfield"
      },
        {
        "type":"org.javalite.activejdbc.test_models.Address",
        "id":"2",
        "zip":"60606",
        "state":"IL",
        "address1":"456 Brook St.",
        "address2":"apt 21",
        "user_id":"1",
        "city":"Springfield"
      },
        {
        "type":"org.javalite.activejdbc.test_models.Address",
        "id":"3",
        "zip":"60606",
        "state":"IL",
        "address1":"23 Grove St.",
        "address2":"apt 32",
        "user_id":"1",
        "city":"Springfield"
      }
    ]
    }
  },
  {
    "type":"org.javalite.activejdbc.test_models.User",
    "id":"2",
    "first_name":"John",
    "email":"jdoe@gmail.com",
    "last_name":"Doe",
    "children" : {
      addresses : [
        {
        "type":"org.javalite.activejdbc.test_models.Address",
        "id":"4",
        "zip":"60606",
        "state":"IL",
        "address1":"143 Madison St.",
        "address2":"apt 34",
        "user_id":"2",
        "city":"Springfield"
      },
        {
        "type":"org.javalite.activejdbc.test_models.Address",
        "id":"5",
        "zip":"60606",
        "state":"IL",
        "address1":"153 Creek St.",
        "address2":"apt 35",
        "user_id":"2",
        "city":"Springfield"
      },
        {
        "type":"org.javalite.activejdbc.test_models.Address",
        "id":"6",
        "zip":"60606",
        "state":"IL",
        "address1":"163 Gorge St.",
        "address2":"apt 36",
        "user_id":"2",
        "city":"Springfield"
      },
        {
        "type":"org.javalite.activejdbc.test_models.Address",
        "id":"7",
        "zip":"60606",
        "state":"IL",
        "address1":"173 Far Side.",
        "address2":"apt 37",
        "user_id":"2",
        "city":"Springfield"
      }
    ]
    }
  }
]
~~~~

Since the `include()` was used, the corresponding children from the ADDRESSES table were queried too for their JSON.

## Hydrate ActiveJDBC models from JSON

Sometimes you need to do the opposite of generating JSON. For instance, when I build webservices using ActiveWeb, often
a JSON document is posted in a web request, and it needs to be serialized to a model. This functionality is not
built into ActiveJDBC because this would require adding a dependency to parse JSON, but it is not needed by most
projects. The solution is super simple: add a class with this code to your project:


~~~~ {.java  .numberLines}
import org.codehaus.jackson.map.ObjectMapper;
import java.io.IOException; import java.util.Map;

public class JsonHelper {
 public static Map toMap(String json) {
   ObjectMapper mapper = new ObjectMapper();
   try {
       return mapper.readValue(json, Map.class);
   } catch (IOException e) { throw new RuntimeException(e); }
 }
 public static Map[] toMaps(String json) {
    ObjectMapper mapper = new ObjectMapper();
    try {
        return mapper.readValue(json, Map[].class);
    } catch (IOException e) { throw new RuntimeException(e); } }
}
~~~~

then add Jackson dependency:

~~~~ {.xml  .numberLines}
  <dependency>
    <groupId>org.codehaus.jackson</groupId>
    <artifactId>jackson-core-asl</artifactId>
    <version>1.8.2</version>
    <scope>test</scope>
  </dependency>

  <dependency>
    <groupId>org.codehaus.jackson</groupId>
    <artifactId>jackson-mapper-asl</artifactId>
    <version>1.8.2</version>
    <scope>test</scope>
  </dependency>
~~~~

After this, it is trivial to write code like this:

~~~~ {.java  .numberLines}
 Person p = new Person();
 String personJson = ... // initialized from web request or another source
 p.fromMap(JsonHelper.toMap(personJson));
~~~~

> In general, if there is another format, say XML or YML, you can convert that to a Java Map, then initialize a model from
> that Map
