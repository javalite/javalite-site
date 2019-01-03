<div class="page-header">
   <h1>Generation of xml</h1>
</div>


Often developers need to generate XML from models. In more complicated situation, they probably would
write some XML generation code. However under simple condition, classes Model and LazyList already provide the
basics.

## Generate simple XML from a model

Here is code that will provide stock XML from a model:

~~~~ {.java  .numberLines}
Person p  = (Person)Person.findById(1);
String xml = p.toXml(2, true);
~~~~

The XML produced will look something like this:

~~~~ {.xml  .numberLines}
<?xml version="1.0" encoding="UTF-8" ?>
  <person>
    <updated_at>2010-11-09 19:02:11.0</updated_at>
    <created_at>2010-11-09 19:02:11.0</created_at>
    <dob>1934-12-01</dob>
    <last_name>Smith</last_name>
    <graduation_date>1954-12-01</graduation_date>
    <name>John</name>
    <id>1</id>
  </person>
~~~~

The first parameter (2) is a number of spaces for indent,
and second whether to add an XML declaration or not.

## Include attributes into generated XML

A variation on the example above is to provide a list of attributes that you are interested in,
so that only these attributes are included:

~~~~ {.java  .numberLines}
Person p  = (Person)Person.findById(1);
String xml = p.toXml(2, true, "last_name", "dob");
~~~~

The resulting XML will have nothing but the attributes specified:

~~~~ {.xml  .numberLines}
<?xml version="1.0" encoding="UTF-8" ?>
<person>
    <dob>1934-12-01</dob>
    <last_name>Smith</last_name>
</person>
~~~~

## Inclusion of dependencies

When a model has relationships, the generated XML will loop through them to include their XML into the
parent XML as well:

~~~~ {.java  .numberLines}
List<User> personList = User.findAll().orderBy("id").include(Address.class);
User u = personList.get(0);
String xml = u.toXml(2, true);
~~~~

result:

~~~~ {.xml  .numberLines}
<?xml version="1.0" encoding="UTF-8" ?>
  <user>
    <addresses>
      <address>
        <user_id>1</user_id>
        <address2>apt 31</address2>
        <state>IL</state>
        <zip>60606</zip>
        <address1>123 Pine St.</address1>
        <id>1</id>
        <city>Springfield</city>
      </address>
      <address>
        <user_id>1</user_id>
   ...
    truncated for brevity
   ...
    </addresses>
    <email>mmonroe@yahoo.com</email>
    <last_name>Monroe</last_name>
    <id>1</id>
    <first_name>Marilyn</first_name>
  </user>
~~~~

## Generate XML from a resultset

Generating XML from a LazyList is equally easy:

~~~~ {.java  .numberLines}
LazyList<User> personList = User.findAll().orderBy("id").include(Address.class);
String xml = personList.toXml(2, true);
~~~~

An example of generated XML:

~~~~ {.xml  .numberLines}
<?xml version="1.0" encoding="UTF-8" ?>
<users>
  <user>
    <addresses>
      <address>
        <user_id>1</user_id>
        <address2>apt 31</address2>
        <state>IL</state>
        <zip>60606</zip>
        <address1>123 Pine St.</address1>
        <id>1</id>
        <city>Springfield</city>
      </address>
      <address>
        <user_id>1</user_id>
        <address2>apt 21</address2>
        <state>IL</state>
        <zip>60606</zip>
        <address1>456 Brook St.</address1>
        <id>2</id>
        <city>Springfield</city>
      </address>
      <address>
        <user_id>1</user_id>
        <address2>apt 32</address2>
        <state>IL</state>
        <zip>60606</zip>
        <address1>23 Grove St.</address1>
        <id>3</id>
        <city>Springfield</city>
      </address>
    </addresses>
    <email>mmonroe@yahoo.com</email>
    <last_name>Monroe</last_name>
    <id>1</id>
    <first_name>Marilyn</first_name>
  </user>
  <user>
    <addresses>
      <address>
        <user_id>2</user_id>
        <address2>apt 34</address2>
        <state>IL</state>
        <zip>60606</zip>
        <address1>143 Madison St.</address1>
        <id>4</id>
        <city>Springfield</city>
      </address>
      <address>
        <user_id>2</user_id>
        <address2>apt 35</address2>
        <state>IL</state>
        <zip>60606</zip>
        <address1>153 Creek St.</address1>
        <id>5</id>
        <city>Springfield</city>
      </address>
      <address>
        <user_id>2</user_id>
        <address2>apt 36</address2>
        <state>IL</state>
        <zip>60606</zip>
        <address1>163 Gorge St.</address1>
        <id>6</id>
        <city>Springfield</city>
      </address>
      <address>
        <user_id>2</user_id>
        <address2>apt 37</address2>
        <state>IL</state>
        <zip>60606</zip>
        <address1>173 Far Side.</address1>
        <id>7</id>
        <city>Springfield</city>
      </address>
    </addresses>
    <email>jdoe@gmail.com</email>
    <last_name>Doe</last_name>
    <id>2</id>
    <first_name>John</first_name>
  </user>
</users>
~~~~

The two users were generated. Since the include was used, the corresponding children from the ADDRESSES
table were queried too for their XML.

