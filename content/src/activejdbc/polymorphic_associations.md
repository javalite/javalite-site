<div class="page-header">
   <h1>Polymorphic associations</h1>
</div>



Polymorphic associations are used in cases when there are several one-to-many relationships that you could aggregate
because for all the parents, the children are similar.

In other words, a polymorphic association allows for a table to have multiple types of parents.


Lets say you have products and reviews in the system . Both have to be tagged.
A naive implementation would be to create two one to many relationships:

-   Product has many ProductTag(s)
-   Review has many ReviewTag(s)

This will work... kind of, but it will violate a DRY principle because the `PRODUCT_TAG` and `REVIEW_TAG`
tables will be identical (except for names!).

A better approach would be to use Polymorphic associations. In the Polymorphic associations , you would create one
table called 'TAGS', and add two columns to this table, besides the ones that you need:

-   `PARENT_ID`
-   `PARENT_TYPE`

After this, you will need to provide one last bit of information to the framework by specifying relationships:

~~~~ {.java  .numberLines}
public class Product extends Model{}

public class Review extends Model{}

@BelongsToPolymorphic(parents = {Product.class, Review.class})
public class Tag extends Model{}
~~~~

This annotation tells ActiveJDBC that Product has many Tags as well as Review has many tags too.
The annotation itself is easy to understand if you read it aloud.


>
> Operations are the same as with [One-to-many associations](one_to_many_associations)
>

## Adding and searching for polymorphic children

~~~~ {.java  .numberLines}
Product p =  Product.findById(100);
p.add(Tag.create("tag", "basket"));
p.add(Tag.create("tag", "toy"));
List<Tag> tags = p.getAll(Tag.class);
...iterate

Review customerReview =  Review.findById(2024);
customerReview.add(Tag.create("tag", "fun"));
customerReview.add(Tag.create("tag", "useful"));
List<Tag> tags = customerReview.getAll(Tag.class);
... iterate
~~~~

The table TAG content might look like this after operations above:

+----+---------+-----------+--------------------+
| id | tag     | parent_id | parent_type        |
+====+=========+===========+====================+
|  1 | toy     |  100      | com.acme.Product   |
+----+---------+-----------+--------------------+
|  2 | basket  |  100      | com.acme.Product   |
+----+---------+-----------+--------------------+
|  3 | fun     | 2024      | com.acme.Review    |
+----+---------+-----------+--------------------+
|  4 | useful  | 2024      | com.acme.Review    |
+----+---------+--------------------------------+


## Conditional search for polymorphic children

While the `getAll(type)` method returns all relations, the `get(type)` method allows for a selection criteria on the child table:

~~~~ {.java  .numberLines}
List<Tag> tags = product.get(Tag.class, "tag = ?", "toy");
~~~~

## Removing polymorphic children

Removing children is as easy as expected;

~~~~ {.java  .numberLines}
Product toyBasket =  Product.findById(100);
Tag t = Tag.findById(1);
toyBasket.remove(t);
~~~~

This will remove a child record from the `TAGS` table.

## Deleting polymorphic parents

When deleting a record that is a parent to polymorphic children, you have two options:

-   Only delete the parent itself. This will leave orphan children:

~~~~ {.java  .numberLines}
toyBasket.delete();
~~~~

-   Delete parent along with all the children:

~~~~ {.java  .numberLines}
toyBasket.deleteCascade(); // or toyBasket.delete(true);
~~~~

The latter will delete the parent along with all associated polymorphic children.
See [Delete cascade](delete_cascade) for more information.

## Finding polymorphic parent

Navigate from children to parents in relationships:

~~~~ {.java  .numberLines}
Tag t = Tag.findById(1);
Product p = t.parent(Product.class);
...
~~~~

## Override standard parent type values

In some cases, it is not possible to have a fully qualified class name in the "parent_type" column.
This is usually a case when the same table backs a different ORM which also supports polymorphic associations
(Ruby on Rails ActiveRecord for example).

When faced with this problem, you can use annotation to override default behavior:

~~~~ {.java  .numberLines}
@BelongsToPolymorphic(
parents     = { Vehicle.class, Mammal.class}, 
typeLabels  = {"Vehicle",     "Mammal"} )
public class Classification extends Model {}
~~~~

This defines polymorphic associations between models Classification, Mammal and Vehicle,
such that the `parent_type` column of `CLASSIFICATIONS` table will contain values
`Vehicle` and `Mammal` for corresponding parent records from `VEHICLE` and `MAMMAL` tables.
The order of parent classes and type labels is important, they must correspond to one another.

Here is an example of CLASSIFICATIONS table:

+----+---------------+-----------+---------------+
| id | name          | parent_id | parent_type   |
+====+===============+===========+===============+
|  1 | four wheeled  | 100       | Vehicle       |
+----+---------------+-----------+---------------+
|  2 | sedan         | 23        | Vehicle       |
+----+---------------+-----------+---------------+
|  3 | four legged   | 2024      | Mammal        |
+----+---------------+-----------+---------------+
|  4 | furry         | 2023      | Mammal        |
+----+---------------+-----------+---------------+
