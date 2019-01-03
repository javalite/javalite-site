<div class="page-header">
   <h1>Inheritance</h1>
</div>


> Currently ActiveJDBC does not support a feature called [Single Table Inheritance](http://en.wikipedia.org/wiki/Single_Table_Inheritance).
> However it does support just inheritance.

## Inheritance diagram

Consider this diagram:

![Inheritance diagram](images/inheritance_umlet_class_diagram.png)


## Inheritance usage


While there are total of 7 classes, only those classes that have <span style="background-color:lightgreen">
&nbsp; green &nbsp; </span>
background are associated with tables. At the same time, common functionality can be inherited from one class to
another. Abstract classes are marked with (A).

In this diagram there are only three tables: MEALS, CAKES and SWORDS. This means that models that are not green are not backed
by a table and therefore cannot be used directly.

All functionality declared in models Dessert and Pastry can be used in a model Cake. Same goes for Weapon and Sword.
However, Cheese, although can exist in code, is a dud.
