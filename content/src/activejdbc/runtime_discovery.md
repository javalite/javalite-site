<div class="page-header">
   <h1>Runtime discovery</h1>
</div>


## Runtime discovery

Discovers tables and corresponding metadata from database at runtime.

ActiveJDBC performs a runtime discovery of tables that correspond to models. This happens once when any model is used for the first time. 

What gets discovered: 

1. Models and their corresponding tables
2. Table columns as model attributes
3. [One to many relationships](one_to_many_associations)
4. [Many to many relationships](many_to_many_associations)

Please, see [English inflections](english_inflections) to understand how table names are mapped to model names

> Model metadata and model relationships are discovered at runtime from database schema. 

## Automatic Entity Relationship Diagram

When a discovery process completes, the framework can print the DDL diagram to a log file. 
Please, see [Logging](logging) to find out how to turn loggin on. 

Here is an example of registration, discovery and DDL log output:

~~~~
Registered model: class org.javalite.activejdbc.test_models.Member
Registered model: class org.javalite.activejdbc.test_models.Sword
Registered model: class org.javalite.activejdbc.test_models.Plant
Registered model: class org.javalite.activejdbc.test_models.Meal
Registered model: class org.javalite.activejdbc.test_models.Course
Registered model: class org.javalite.activejdbc.test_models.Developer
Registered model: class org.javalite.activejdbc.test_models.Animal
Registered model: class org.javalite.activejdbc.test_models.Cheese
Registered model: class org.javalite.activejdbc.test_models.Comment
Registered model: class org.javalite.activejdbc.test_models.Motherboard
Registered model: class org.javalite.activejdbc.test_models.User
Registered model: class org.javalite.activejdbc.test_models.Post
Registered model: class org.javalite.activejdbc.test_models.Apple
Registered model: class org.javalite.activejdbc.test_models.Keyboard
Registered model: class org.javalite.activejdbc.test_models.Student
Registered model: class org.javalite.activejdbc.test_models.Patient
Registered model: class org.javalite.activejdbc.test_models.University
Registered model: class org.javalite.activejdbc.test_models.SubClassification
Registered model: class org.javalite.activejdbc.test_models.Programmer
Registered model: class org.javalite.activejdbc.test_models.Recipe
Registered model: class org.javalite.activejdbc.test_models.Alarm
Registered model: class org.javalite.activejdbc.test_models.Assignment
Registered model: class org.javalite.activejdbc.test_models.Address
Registered model: class org.javalite.activejdbc.test_models.Room
Registered model: class org.javalite.activejdbc.test_models.NoArg
Registered model: class org.javalite.activejdbc.test_models.School
Registered model: class org.javalite.activejdbc.test_models.Salary
Registered model: class org.javalite.activejdbc.test_models.Computer
Registered model: class org.javalite.activejdbc.test_models.Account
Registered model: class org.javalite.activejdbc.test_models.Article
Registered model: class org.javalite.activejdbc.test_models.Item
Registered model: class org.javalite.activejdbc.test_models.Doctor
Registered model: class org.javalite.activejdbc.test_models.ContentGroup
Registered model: class org.javalite.activejdbc.test_models.Mammal
Registered model: class org.javalite.activejdbc.test_models.Ingredient
Registered model: class org.javalite.activejdbc.test_models.Cake
Registered model: class org.javalite.activejdbc.test_models.Temperature
Registered model: class org.javalite.activejdbc.test_models.Prescription
Registered model: class org.javalite.activejdbc.test_models.DoctorsPatients
Registered model: class org.javalite.activejdbc.test_models.Library
Registered model: class org.javalite.activejdbc.test_models.Fruit
Registered model: class org.javalite.activejdbc.test_models.Vegetable
Registered model: class org.javalite.activejdbc.test_models.Person
Registered model: class org.javalite.activejdbc.test_models.Watermelon
Registered model: class org.javalite.activejdbc.test_models.Tag
Registered model: class org.javalite.activejdbc.test_models.Page
Registered model: class org.javalite.activejdbc.test_models.Reader
Registered model: class org.javalite.activejdbc.test_models.Image
Registered model: class org.javalite.activejdbc.test_models.Vehicle
Registered model: class org.javalite.activejdbc.test_models.Classification
Registered model: class org.javalite.activejdbc.test_models.Book
Registered model: class org.javalite.activejdbc.test_models.Project
Registered model: class org.javalite.activejdbc.test_models.Node
Fetched metadata for table: accounts
Fetched metadata for table: addresses
Fetched metadata for table: alarms
Fetched metadata for table: animals
Fetched metadata for table: apples
Fetched metadata for table: articles
Fetched metadata for table: books
Fetched metadata for table: cakes
[main] WARN org.javalite.activejdbc.Registry - Failed to retrieve metadata for table: 'cheeses'. Are you sure this table exists? For some databases table names are case sensitive.
Fetched metadata for table: classifications
Fetched metadata for table: comments
Fetched metadata for table: computers
Fetched metadata for table: content_groups
Fetched metadata for table: courses
Fetched metadata for table: developers
Fetched metadata for table: doctors
Fetched metadata for table: doctors_patients
Fetched metadata for table: fruits
Fetched metadata for table: images
Fetched metadata for table: ingredients
Fetched metadata for table: items
Fetched metadata for table: keyboards
Fetched metadata for table: legacy_universities
Fetched metadata for table: libraries
Fetched metadata for table: mammals
Fetched metadata for table: meals
Fetched metadata for table: Member
Fetched metadata for table: motherboards
[main] WARN org.javalite.activejdbc.Registry - Failed to retrieve metadata for table: 'no_args'. Are you sure this table exists? For some databases table names are case sensitive.
Fetched metadata for table: nodes
Fetched metadata for table: pages
Fetched metadata for table: patients
Fetched metadata for table: people
Fetched metadata for table: plants
Fetched metadata for table: posts
Fetched metadata for table: prescriptions
Fetched metadata for table: programmers
Fetched metadata for table: programmers_projects
Fetched metadata for table: projects
Fetched metadata for table: readers
Fetched metadata for table: recipes
Fetched metadata for table: rooms
Fetched metadata for table: salaries
Fetched metadata for table: schools
Fetched metadata for table: students
Fetched metadata for table: sub_classifications
Fetched metadata for table: swords
Fetched metadata for table: tags
Fetched metadata for table: temperatures
Fetched metadata for table: users
Fetched metadata for table: vegetables
Fetched metadata for table: vehicles
Fetched metadata for table: watermelons
Association found: comments  >----------  articles, type: belongs-to-polymorphic
Association found: articles  ----------<  comments, type: has-many-polymorphic
Association found: comments  >----------  posts, type: belongs-to-polymorphic
Association found: posts  ----------<  comments, type: has-many-polymorphic
Association found: comments  >----------  prescriptions, type: belongs-to-polymorphic
Association found: prescriptions  ----------<  comments, type: has-many-polymorphic
Association found: students  >---------<  courses, type: many-to-many, join: registrations
Association found: courses  >---------<  students, type: many-to-many, join: registrations
Association found: recipes  >---------<  ingredients, type: many-to-many, join: ingredients_recipes
Association found: ingredients  >---------<  recipes, type: many-to-many, join: ingredients_recipes
Association found: keyboards  ----------<  computers, type: has-many
Association found: computers  >----------  keyboards, type: belongs-to
Association found: motherboards  ----------<  computers, type: has-many
Association found: computers  >----------  motherboards, type: belongs-to
Association found: tags  >----------  articles, type: belongs-to-polymorphic
Association found: articles  ----------<  tags, type: has-many-polymorphic
Association found: tags  >----------  posts, type: belongs-to-polymorphic
Association found: posts  ----------<  tags, type: has-many-polymorphic
Association found: classifications  >----------  vehicles, type: belongs-to-polymorphic
Association found: vehicles  ----------<  classifications, type: has-many-polymorphic
Association found: classifications  >----------  mammals, type: belongs-to-polymorphic
Association found: mammals  ----------<  classifications, type: has-many-polymorphic
Association found: libraries  ----------<  books, type: has-many
Association found: books  >----------  libraries, type: belongs-to
Association found: nodes  ----------<  nodes, type: has-many
Association found: nodes  >----------  nodes, type: belongs-to
Association found: rooms  >----------  addresses, type: belongs-to
Association found: addresses  ----------<  rooms, type: has-many
Association found: readers  >----------  books, type: belongs-to
Association found: books  ----------<  readers, type: has-many
Association found: sub_classifications  >----------  classifications, type: belongs-to
Association found: classifications  ----------<  sub_classifications, type: has-many
Association found: doctors_patients  >----------  doctors, type: belongs-to
Association found: doctors  ----------<  doctors_patients, type: has-many
Association found: doctors  >---------<  patients, type: many-to-many, join: doctors_patients
Association found: doctors_patients  >----------  patients, type: belongs-to
Association found: patients  ----------<  doctors_patients, type: has-many
Association found: prescriptions  >----------  patients, type: belongs-to
Association found: patients  ----------<  prescriptions, type: has-many
Association found: patients  >---------<  doctors, type: many-to-many, join: doctors_patients
Association found: programmers_projects  >----------  programmers, type: belongs-to
Association found: programmers  ----------<  programmers_projects, type: has-many
Association found: programmers  >---------<  projects, type: many-to-many, join: programmers_projects
Association found: programmers_projects  >----------  projects, type: belongs-to
Association found: projects  ----------<  programmers_projects, type: has-many
Association found: projects  >---------<  programmers, type: many-to-many, join: programmers_projects
Association found: addresses  >----------  users, type: belongs-to
Association found: users  ----------<  addresses, type: has-many

~~~~

This output was taken from running [ModelTest.java](https://github.com/javalite/activejdbc/blob/master/activejdbc/src/test/java/org/javalite/activejdbc/ModelTest.java).
There are three sections: registration, mapping, and Associations. 

The Entity Relationship diagram is represented by a [Crow's foot notation](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model#Crow.27s_foot_notation). 

### One to many example

~~~~
Association found: libraries  ----------<  books, type: has-many
~~~~
Means that a library has many books


### Many to one example

~~~~
Association found: books  >----------  libraries, type: belongs-to
~~~~

Books belong to library 


### Many to many example

~~~~
Association found: doctors  >---------<  patients, type: many-to-many, join: doctors_patients
~~~~

A doctor sees many patients and a patient visits many doctors. 

### Many-to-many representation

Many to many relationship is in effect represented by other one-to-many relationships: 

~~~~
Association found: doctors_patients  >----------  doctors, type: belongs-to
Association found: doctors  ----------<  doctors_patients, type: has-many
Association found: doctors  >---------<  patients, type: many-to-many, join: doctors_patients
Association found: doctors_patients  >----------  patients, type: belongs-to
Association found: patients  ----------<  doctors_patients, type: has-many
~~~~

### Polimorphic Associations

Polymorphic Association information is not sourced from the schem, but rather configured in code using annotations. 

Please, see: [Polimorphic Associations](polymorphic_associations).


