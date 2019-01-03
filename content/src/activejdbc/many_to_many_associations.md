<div class="page-header">
   <h1>Many to many associations</h1>
</div>



Often times the database-driven applications require many to many relationships. These are the kind where an entity can
have many other entities and also belong to the same type of entities. Examples in real life are: doctor treats
many patients, and a patient sees many doctors. Another examples is when a university course has many students
and a student has registered for many courses. In order to replicate this type of a relationship, usually three
tables are created, one for the first type of entity, the other for another type of entity and a middle table which
binds entities from the first two tables.

## Example tables

Let's see an example based on doctors and patients.

Table `DOCTORS`:

+----+------------+-----------+-----------------+
| id | first_name | last_name | discipline      |
+===+============+===========+==================+
|  1 | John       | Doe       | otholaringology |
+----+------------+-----------+-----------------+
|  2 | Hellen     | Hunt      | dentistry       | 
+----+------------+-----------+-----------------+

Table `PATIENTS`:

+----+------------+-----------+
| id | first_name | last_name |
+====+============+===========+
|  1 | Jim        | Cary      |
+----+------------+-----------+
|  2 | John       | Carpenter | 
+----+------------+-----------+

There is nothing in these to tables that tell us that doctors and patients are somehow related.
The third table binds entities between the doctors and patients table:

Table `DOCTORS_PATIENTS`:

+----+-----------+------------+
| id | doctor_id | patient_id |
+====+===========+============+
|  1 |1          |2           |
+----+-----------+------------+
|  2 |1          |1           |
+----+-----------+------------+
|  3 |2          |1           |
+----+-----------+------------+

Looking at this table, we can discern that a doctor with ID = 1 (John Doe) has two patients:
Jim Cary and John Carpenter. However Jim Cary also sees doctor Hellen Hunt. Let's see what kind of a
support ActiveJDBC provides when it comes to many to many relationship. We will use the same table we outlined above.

## Writing models

Model for table `DOCTORS`:

~~~~ {.java  .numberLines}
public class Doctor extends Model {}
~~~~

Model for table `PATIENT`:

~~~~ {.java  .numberLines}
public class Patient extends Model {}
~~~~

Model for table `DOCTORS_PATIENTS`:

~~~~ {.java  .numberLines}
public class DoctorsPatients extends Model {}
~~~~

In cases when you override conventions, creation of a model that represents a join table is optional

ActiveJDBC will use inflections to map these models to the tables. It also expects the `DOCTORS_PATIENTS` table to
have `doctor_id` and `patient_id` columns. If everything is named appropriately (there are ways to override these
conventions, see below), then the many to many relationships are configured across Doctor and Patient models.
All the usual CRUD operations are supported right out of the box, see below.

## Many-to-many operations

### Select related objects

The select API for many to many is identical that of one to many, The framework is smart enough figure this out:

~~~~ {.java  .numberLines}
//Let's lookup a doctor:
Doctor doctor = Doctor.findById(1);
//get all patients of this doctor
List<Patient> patients = doctor.getAll(Patient.class);
System.out.println("Doctor 1 has " + patients.size() + " patient(s)");//prints "Doctor 1 has 2 patient(s)"

//Lookup a second doctor:
doctor = Doctor.findById(2);
patients = doctor.getAll(Patient.class);
System.out.println("Doctor 2 has " + patients.size() + " patient(s)");//prints "Doctor 1 has 1 patient(s)"
~~~~

The framework will generate appropriate select statement and execute it across two tables. This allows focusing on objects and abstract away from tabular nature of data in the DB.

### Conditional selection of related objects

ActiveJDBC provides a way to filter related objects. Let's say that there are tables `PROGRAMMERS`, `PROJECTS`
and `PROGRAMMERS_PROJECTS`. In this case, we will create a model `Assignments` that will represent the join table:

~~~~ {.java  .numberLines}
@Table("programmers_projects")
public class Assignments extends Model{}
~~~~

as well as other models:

~~~~ {.java  .numberLines}
public class Project extends Model{}
..
public class Programmer extends Model{}
~~~~

You can treat a Many-to-many relationship as two one-to-many relationships. In this case, you could say that a
project has many assignments and a programmer has many assignments. Armed with this knowledge, we can write some code:

~~~~ {.java  .numberLines}
Programmer programmer = Programmer.createIt("first_name", "Jim", "last_name", "Garnoe");

Assignment assignment = Assignment.createIt("duration_weeks", 3);
//use one to many notation here:
programmer.add(assignment);
Project project1 = Project.createIt("project_name", "Prove theory of everything");
project1.add(assignment);

//use many to many notation:
Project project2 = Project.createIt("project_name", "Find meaning of life");
programmer.add(project2);
~~~~

at this point, the table `PROGRAMMERS_PROJECTS` will have the following content:

+----+----------------+------------+---------------+---------------------+---------------------+
| id | duration_weeks | project_id | programmer_id | created_at          | updated_at          |
+====+================+============+===============+=====================+=====================+
|  1 |3               |1           |1              | 2010-10-04 14:08:04 | 2010-10-04 14:08:04 |
+----+----------------+------------+---------------+---------------------+---------------------+
|  2 |NULL            |2           |1              | 2010-10-04 14:08:04 | 2010-10-04 14:08:04 |
+----+----------------+------------+---------------+---------------------+---------------------+

Where the first assignment is set for 3 weeks, and a second has no `duration_weeks` value.

Having this data, we can query many to many relationship using a select filter on a join table:

~~~~ {.java  .numberLines}
List<Project> projects = programmer.get(Project.class, "duration_weeks = ?", 3);
~~~~

The result will be only one record. Unlike the [One-to-many associations](one_to_many_associations),
the query is applied to a join table, and not the "child".

### Checking for association

This is pretty simple:

~~~~ {.java  .numberLines}
System.out.println(Patient.belongsTo(Doctor.class));//prints "true"
~~~~

This API is symmetrical for Many-to-many associations.

> The same API also works for [One-to-many associations](one_to_many_associations).

### Adding new entries

In many to many associations, there are no parents or children, as both sides of the association are equal.

Adding new entries then is pretty easy:

~~~~ {.java  .numberLines}
Doctor doctor = Doctor.findById(1);
Patient patient = Patient.create("first_name", "Jim", "last_name", "Smith");
doctor.add(patient);
~~~~

Here you see an example of a shortcut for creation of models with the `create()` method.

> Adding a new entity is the same for  [One-to-many associations](one_to_many_associations).

Here, we are adding a newly created patient, which is does not exist in the database yet.
In this case, the framework will create two new records in the DB:
one for a new patient, and one in the `DOCTORS_PATIENTS1 table that binds a current doctor and a new patient.

In the case where a patient exists already, it will only add a join record in the `DOCTORS_PATIENTS` table.

### Removing Entries

Removing is also easy:

~~~~ {.java  .numberLines}
doctor.remove(patient);
~~~~

Here, only a join table record is being removed, the actual patient record stays unchanged.
In this case, the API for removing a child is the same for one-to-many as for many-to-many relationships,
but semantics are different. In one-to-many association the child record will be removed from the DB.

### Deleting Entries

Deleting entries is similar to deleting in One to Many associations:

~~~~ {.java  .numberLines}
doctor.deleteCascade();
~~~~

However, semantics are different. In many to many relationships, the `model.deleteCascade()` method will do more
than just delete this record. It will also discover all associated join tables and will delete records from them that
match this models' ID value, effectively dis-associating it from all many to many relationships.

For more see here: [Delete cascade](delete_cascade)

## Overriding associations

If the naming conventions cannot be used, you can override the convention to let the framework know which
models are bound in many-to-many association:

~~~~ {.java  .numberLines}
@Many2Many(other = Course.class, join = "registrations", sourceFKName = "astudent_id", targetFKName = "acourse_id")
public class Student extends Model {}
~~~~

Here, the `other` is a model that represents the other end of the relationship, `join` is a name of a join
table (table in the middle), `sourceFKName` is a source foreign key name. A source is this model, in
this case it is `Student`. This means that the framework will expect to find a column `astudent_id` in the
table `registrations` and will assume that it contains keys of records of the `student` table.
`targetFKName` is similar to the `sourceFKName`, but stands for a column `acourse_id` in the table `registrations`
that contains keys to the records in the `courses` table.

The annotation `@Many2Many` is one-sided. This means that it provides enough information to the framework, and
there is no need to add another one to the model Course (it will not break if you do though).


## Real models for join tables

If join tables are represented by real models, ActiveJDBC handles it transparently. To illustrate the
doctor - patient example above, you might want to indicate where a specific patient is treated.You would
then add a new column to the `DOCTORS_PATIENTS` table called `location`. Then you would define a model like so:

~~~~ {.java  .numberLines}
@Table("DOCTORS_PATIENTS")
class DocPat extends Model{}
~~~~

In the case of the student/course, the join table already has a good name, so it is easy to define a new model:

~~~~ {.java  .numberLines}
class Registration extends Model{}
~~~~

The table `REGISTRATIONS` might have additional data, such as registration type, etc.
