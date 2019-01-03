<div class="page-header">
   <h1>Batch operations</h1>
</div>


In some cases, you will need to make changes to or delete all or some records in a tables. ActiveJDBC provides a couple of convenience methods for this.

## Updating all records in table

The static method `Model.updateAll()` provides a way to update all records in a corresponding table:

~~~~ {.prettyprint}
Person.updateAll("last_name = ?", "Smith");
~~~~

In the example above, all records in a table PEOPLE will be updates such, that the `last_name` column will be set to value "Smith".

## Updating selected records in table

The static method `Model.update()` will do the job:

~~~~ {.prettyprint}
Person.update("name = ?, last_name = ?", "name like ?", "Steve", "Johnson", "%J%");
~~~~

In the example above, all records `where name like '%J%'` will be updated to have name = Steve and last name = "Johnson". In other words, the first argument to the method is what to update to, the second is conditions for selection, followed by a list of replacement arguments for both.

## Updating of updated\_at

Both batch methods described above will respect ActiveJDBC conventions and will also update the `updated_at` column to the current system time for all updated records.

## Deleting records

Following the same pattern, `Model.delete()` is a convenient way to delete selected records:

~~~~ {.prettyprint}
Person.delete("age > ?", "10");
~~~~

Here, all records will be deleted where column `age` has a value greater than 10. This is self-explanatory

## Deleting all records

~~~~ {.prettyprint}
Person.deleteAll();
~~~~

This does not require explanation.

## Complex batch operations

ActiveJDBC provides a way to actually batch destructive operations into a single batch.
In some cases it can provide significant performance improvements

~~~~ {.java  .numberLines}
 PreparedStatement ps = Base.startBatch("insert into people (NAME, LAST_NAME, DOB) values(?, ?, ?)");
 Base.addBatch(ps, "Mic", "Jagger", "1962-01-01");
 Base.addBatch(ps, "Marilyn", "Monroe", "1932-01-01");
 Base.executeBatch(ps);
 ps.close();
~~~~
