<div class="page-header">
   <h1>Delete cascade</h1>
</div>



ActiveJDBC provides two methods for deleting with cascade: `deleteCascade()` and `deleteCascadeShallow()`.

Method  `deleteCascade()` is deep but not high performance, while `deleteCascadeShallow()`is fast, but not deep
(hence the name). Please, see below for more information.

## Method deleteCascade()

ActiveJDBC class `Model` provides a method:

This method deletes current record from associated table, as well as children. Deletes current model and all
of its child and many to many associations. This is not a high performance method, as it will load every row into a
model instance before deleting, effectively calling (N + 1) per table queries to the DB, one to select all
the associated records (per table), and one delete statement per record. Use it for small data sets.

In cases of simple one to many and polymorphic associations, things are as expected, a parent is deleted an all
children are deleted as well, but in more complicated cases, this method will walk entire tree of associated tables,
sometimes coming back to the same one where it all started. It will follow associations of children and their
associations too; consider this a true cascade delete with all implications (circular dependencies, referential
integrity constraints, potential performance bottlenecks, etc.)

Imagine a situation where you have `DOCTORS` and `PATIENTS` in many to many relationship (with `DOCTORS_PATIENTS` table
as a join table), and in addition `PATIENTS` and `PRESCRIPTIONS` in one to many relationship, where a patient
might have many prescriptions:


`DOCTORS`:

+----+------------+-----------+-----------------+
| id | first_name | last_name | discipline      |
+====+============+===========+=================+
|  1 | John       | Kentor    | otolaryngology  |
+----+------------+-----------+-----------------+
|  2 | Hellen     | Hunt      | dentistry       |
+----+------------+-----------+-----------------+
|  3 | John       | Druker    | oncology        |
+----+------------+-----------+-----------------+


`PATIENTS`:

+----+------------+-----------+
| id | first_name | last_name |
+====+============+===========+
|  1 | Jim        | Cary      |
+----+------------+-----------+
|  2 | John       | Carpenter |
+----+------------+-----------+
|  3 | John       | Doe       |
+----+------------+-----------+

`DOCTORS_PATIENTS`:

+----+-----------+------------+
| id | doctor_id | patient_id |
+====+===========+============+
|  1 |1          |2           |
+----+-----------+------------+
|  2 |1          |1           |
+----+-----------+------------+
|  3 |2          |1           |
+----+-----------+------------+
|  4 |3          |3           |
+----+-----------+------------+

`PRESCRIPTIONS`:

+----+------------------------+------------+
| id | name                   | patient_id |
+====+========================+============+
|  1 | Viagra                 |1           |
+----+------------------------+------------+
|  2 | Prozac                 |1           |
+----+------------------------+------------+
|  3 | Valium                 |2           |
+----+------------------------+------------+
|  4 | Marijuana (medicinal)  |2           |
+----+------------------------+------------+
|  5 | CML treatment          |3           |
+----+------------------------+------------+


Lets start with a simple example, Doctor John Druker. This doctor has one patient John Doe, and the patient has one
prescription. So, when an instance of this doctor model is issued statement:

~~~~ {.java  .numberLines}
drDruker.deleteCascade();
~~~~

the result is as expected: the DOCTORS:ID=3 is deleted, DOCTORS_PATIENTS:ID=4 is deleted,
PATIENTS:ID=3 is deleted and PRESCRIPTIONS:ID=5 is deleted.

However, when doctor Kentor(#1) is deleted, the results are devastating. The following records are also deleted:

DOCTORS_PATIENTS:ID=1, 2 - these are links to patients PATIENTS:ID=1,2 these are patients themselves

PRESCRIPTIONS:ID=1,2,3,4 - these are prescriptions of patients 1 and 2

But, in addition, since this is a many to many relationship, deleting patients 1 and 2 results in also deleting doctor
Hellen Hunt(#2), since she is a doctor of patient Jim Cary(#1), deleting all corresponding join links from table
DOCTORS_PATIENTS. So, deleting doctor Kentor, deleted most all records from related tables, leaving only these records in place:

~~~~ {.prettyprint}
DOCTORS:ID=3
DOCTORS_PATIENTS:ID=4
PATIENTS:ID=3
PRESCRIPTIONS:ID=5
~~~~

Had doctor Hellen Hunt(#2) had more patients, it would delete them too, and so on. This goes a long way to say that it
could be easy to be tangled up in web of associations, so be careful out there.

> After deletion, this instance becomes `frozen()` and cannot be used anymore until `thaw()` is called.

## Method deleteCascadeExcept()

The method `deleteCascade()` will navigate to all relationships of a model and their relationships, etc. This can
lead to some unexpected results - you might find that it deleted some important records. If this is the case, use
method `deleteCascadeExcept(Association ... associations)`.

Lets say you have models: Article, Comment and Tag such that Article has many Comments, and Comment has many Tags.

This method then allows to skip some associations of a model from following:

~~~~ {.java  .numberLines}
Comment comment = Comment.findFirst(...criteria ...);
comment.deleteCascadeExcept(Comment.getMetaModel().getAssociationForTarget("articles"));
~~~~

In the example above, the comment will be deleted along with its tags, but the article will stay intact.

## Method deleteCascadeShallow()

Deletes current record from associated table, as well as its immediate children. This is a high performance method
because it does not walk through a chain of child dependencies like `deleteCascade()` does, but rather issues one
DELETE statement per child dependency table. Also, its semantics are a bit different between that `deleteCascade()`.
It only deletes current record and immediate children, but not their children (no grand kinds are dead as a result :)).

### One to many and polymorphic associations  and deleteCascadeShallow()

The current record is deleted, as well as immediate children.

### Many to many associations and deleteCascadeShallow()

The current record is deleted, as well as links in a join table. Nothing else is deleted.
