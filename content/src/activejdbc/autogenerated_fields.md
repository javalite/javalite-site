<div class="page-header">
   <h1>Autogenerated fields</h1>
</div>


ActiveJDBC will save special values into columns named according to conventions.

> Name of this page is somewhat misleading. ActiveJDBC does not generate any columns, it generates values for rows in a few
specific columns.

## Column "created_at"

If a table has this column (and the column type is one that corresponds to
`java.sql.Timestamp`), then a corresponding model will save value into this column only once when a new record is created.
Successive updates of even new model instances that represent this specific record will not modify data in this column,
hence you can use it to investigate data change issues.

## Column "updated_at"

This column will be updated each time there is an update to an existing record via a corresponding model.

## Example

Let\'s say we have an empty table PEOPLE:

+----+------------+-----------+---------------------+----------------------+
| id | first_name | last_name | created_at          | updated_at           |
+====+============+===========+=====================+======================+
|    |            |           |                     |                      |
+----+------------+-----------+---------------------+----------------------+

A model will look like this:

~~~~ {.java  .numberLines}
public class Person  extends Model{}
~~~~

Let's add some records:

~~~~ {.java  .numberLines}
Person p = new Person();
p.set("first_name", "John", "last_name", "Smith");
p.saveIt();
~~~~

At this point, we will have the following record in the DB:

+----+------------+-----------+---------------------+----------------------+
| id | first_name | last_name | created_at          | updated_at           |
+====+============+===========+=====================+======================+
| 1  | John       | Smith     | 2010-08-12 10:36:02 | 2010-08-12 10:36:02  |
+----+------------+-----------+---------------------+----------------------+


The dates are the same for `created_at` and `updated_at`.

Then, within the same program or another, we will do the following:

~~~~ {.java  .numberLines}
Person john = Person.findById(1);
john.set("first_name", "John", "last_name", "Smithe");
john.saveIt();
~~~~

We corrected the last name from "Smith" to "Smithe". After this operation, the same record will look like this:

+----+------------+-----------+---------------------+----------------------+
| id | first_name | last_name | created_at          | updated_at           |
+====+============+===========+=====================+======================+
| 1  | John       | Smithe    | 2010-08-12 10:36:02 | 2010-08-13 12:45:22  |
+----+------------+-----------+---------------------+----------------------+


The `updated_at` column reflects when this record was last updated.

## Disabling time attributes management

In some cases, you want to have a complete control of values of `created_at` and `updated_at` fields. For instance, you need to migrate data from one
database to another and want to preserve these values. You can simply turn off automatic management of these fields:

~~~~ {.java  .numberLines}
Person john = ...
p.manageTime(false);
p.set("created_at", createdVal);
p.set("updated_at", updatedVal);
p.saveIt();
~~~~

The model will simply save your values as any other attributes.
                                                                  
