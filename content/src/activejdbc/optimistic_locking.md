<div class="page-header">
   <h1>Optimistic locking</h1>
</div>



The idea of optimistic locking is described here: [Optimistic concurrency control](http://en.wikipedia.org/wiki/Optimistic_concurrency_control)

ActiveJDBC provides support for optimistic concurrency via a simple convention: A database table needs to provide a column named `record_version` with a type that is capable to store non-decimal types, such as LONG for MySQL, NUMBER for Oracle, etc.

## Creation of a new record

Say you have a model:

~~~~ {.java  .numberLines}
public class Profile extends Model{}
~~~~

which backs a table `PROFILES`:

+----+--------------+------------------+
| id | profile_type | record_version   |
+====+==============+==================+
|    |              |                  |
+----+--------------+------------------+


When you create a new record:

~~~~ {.java  .numberLines}
Profile.createIt("profile_type", "home");
~~~~

a new record is inserted into the table:

+----+--------------+------------------+
| id | profile_type | record_version   |
+====+==============+==================+
| 1  |   home       |1                 |
+----+--------------+------------------+


The value 1 in the `record_version` column signifies that this record has not been updated yet.

## Updating a record

When a record is updated, the value of column `record_version` is incremented by one:

~~~~ {.java  .numberLines}
Profile p = Profile.findById(1);
p.set("profile_type", "work");
p.saveIt();
~~~~

The resulting record in the database will look like this:

+----+--------------+------------------+
| id | profile_type | record_version   |
+====+==============+==================+
| 1  |   work       |2                 |
+----+--------------+------------------+


As you can see, ActiveJDBC tracks versions of the same record.

## When collisions happen

Sometimes you might have code that reads the same record from a table in order to be updated. In those cases, the first update succeeds, but the second does not. Let's examine this situation:

~~~~ {.java  .numberLines}
Profile p1 = Profile.findById(1);
Profile p2 = Profile.findById(1);

p1.set("profile_type", "hotel");
p1.saveIt();

p2.set("profile_type", "vacation");
p2.saveIt(); //<<<========= This will throw a StaleModelException
~~~~

In the code snippet above, at lines 1 and 2, the same record is loaded into models. Then, at line 5, the first one is updated. This will increment the version of the record to 3, and make the model p2 stale. Henceforth, when you try to save the model p2, you will get an exception. The content of a record in the table at this point will be:

+----+--------------+------------------+
| id | profile_type | record_version   |
+====+==============+==================+
| 1  |   hotel      |3                 |
+----+--------------+------------------+


Here is the output of the StaleModelException:

~~~~ {.prettyprint}
org.javalite.activejdbc.StaleModelException: Failed to update record for model 'class com.acme.Profile', with id = 1 and record_version = 2. Either this record does not exist anymore, or has been updated to have another record_version.
~~~~

This message provides enough detail to understand what happened.


## Override default version column


By default a version column is called `version_record`. In cases where there is already existing schema or you need compatibility
with other systems, you can override the name with annotation:


~~~~ {.java  .numberLines}
@VersionColumn("lock_version")
public class Item extends Model { ... }
~~~~

The version numbers will be stored in `lock_version` column, while everything else will work as expected.

## How optimistic locking is engaged

The rule is very simple, ActiveJDBC finds `record_version` column and dynamically configures itself to handle optimistic locking.
This means that if this column is present, optimistic locking will be engaged. If the record is not present, optimistic locking will not be engaged.
If you did not have this column, and later added it, you need to restart the system because ActiveJDBC scans database schema at the start.

Conversely, if you want to turn it off, drop column `record_version` and restart the system.

## Advice

Application developers using optimistic locking should be aware of exception [StaleModelException](http://javalite.github.io/activejdbc/snapshot/org/javalite/activejdbc/StaleModelException.html)
(even though it is a RuntimeException) and build controls into their code to intercept and handle it appropriately.
