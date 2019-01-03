<div class="page-header">
   <h1>One to many associations</h1>
</div>



One to many associations are pretty common in modern projects. Examples are: university has students, library has books, etc.
There are two sides to a one to many association, the "parent" **has a** "child" and a "child" **belongs to** "parent".

ActiveJDBC supports this type of a relationship in two ways: 1. Inferred and 2. Overridden

## Example tables

Lets define a couple of tables to start with:

Table `USERS`:

+----+------------+-----------+-----------------+
| id | first_name | last_name | discipline      |
+===+============+===========+==================+
|  1 | John       | Doe       | otholaringology |
+----+------------+-----------+-----------------+
|  2 | Hellen     | Hunt      | dentistry       | 
+----+------------+-----------+-----------------+


Table `ADDRESSES`:

+----------+----------+------+-------+-----+---------+
| address1 | address2 | city | state | zip | user_id |
+----------+----------+------+-------+-----+---------+


## Writing models

Model for USERS table:

~~~~ {.java  .numberLines}
public class User extends Model {}
~~~~

Model for ADDRESSES table:

~~~~ {.java  .numberLines}
public class Address extends Model {}
~~~~

> Just because table `ADDRESSES` has a column called `user_id`, the framework assumes that there is a one-to-many
> relationship here, and makes special arrangements. The framework (internally) creates two associations
> (User has many Address(es) and Address belongs to User).

## Adding children

Adding children is the same as in any other association:

~~~~ {.java  .numberLines}
user.add(address);
~~~~

As in other associations, the requirement is that the parent record in DB must exist already. This way, a child model
is immediately saved to its appropriate table.

>
> ActiveJDBC is a pass-through model. Models do not retain references to child model instances.
>

In case the User model is new (has not been save yet), the method `user.add(child)` will throw an exception.

## How to get children

Nothing can be simpler:

~~~~ {.java  .numberLines}
List<Address> addresses = user.getAll(Address.class);
~~~~

Here the `Address.class` needs to be passed in because a model User might have many other relationships with other models.

## Conditional selection of related objects

Sometimes you need to collect children of a model based on a selection criteria: In such cases, use the `get(type)` method:

~~~~ {.java  .numberLines}
List<Address> shippingAddresses = customer.get(Address.class, "address_type = ?", "shipping");
~~~~

It is expected that the table `ADDRESSES` will have a column `address_type`. Condition is applied to a child table.

## How to get Parent

~~~~ {.java  .numberLines}
User user = address.parent(User.class);
~~~~

Here, we have to pass a `User.class` to indicate which parent type we want because a model could have multiple parents.

## Deleting Parent

A simple way to delete a parent is:

~~~~ {.java  .numberLines}
User u = address.parent(User.class);
u.delete();
~~~~

If you have a referential integrity in your DB and table `ADDRESSES` has records associated with this user, then
you will get an exception from DB. If you do not have child records, this user will be deleted. If you have records in
the `ADDRESSES` table and no referential integrity constraint, the user will be deleted and you will have orphan
records in the `ADDRESSES` table. In order to delete a user and all it's child records, execute this method:

~~~~ {.java  .numberLines}
u.deleteCascade();
~~~~

This method will walk over all parent/child relationships and delete the user and all child records associated with it.
There is also a convenience methods that will do the same:

~~~~ {.java  .numberLines}
u.delete(true);//true for cascade.
~~~~

>
> Be extremely cautious with this method. See [Delete cascade](delete_cascade) for more information.
>

## Override Conventions

In cases where a surrogate foreign key is already present and has a name that does not follow the ActiveJDBC
conventions, you could easily override it like this:

~~~~ {.java  .numberLines}
@BelongsTo(parent = User.class, foreignKeyName = "usr_id")
public class Address extends Model {}
~~~~

The `@BelongsTo` annotation will ensure that API on both ends will work. ActiveJDBC does not have annotation
`@HasMany`, since it would not be [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself).

In cases a model belongs to many parents, you can use this annotation:

~~~~ {.java  .numberLines}
@BelongsToParents({ 
@BelongsTo(foreignKeyName="key_id",parent=Keyboard.class), 
@BelongsTo(foreignKeyName="mother_id",parent=Motherboard.class) 
}) 
~~~~

As usual though, you only need it if names of foreign keys do not conform to the conventions.

## Foreign Key

The Foreign Key in the `ADDRESSES` table does not have to be a real Foreign Key constraint. ActiveJDBC does not check
for it's presence. As long as there is a column named according to this convention, ActiveJDBC assumes that there
is a relationship. It does not hurt to have the actual constraint in the DB if you are using other means of accessing data.

