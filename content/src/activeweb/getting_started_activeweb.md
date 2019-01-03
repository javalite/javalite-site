<div class="page-header">
   <h1>Getting started</h1>
</div>


This simple ActiveWeb project available for download demonstrates main principles of the framework.
It is a CRUD application, which can list/add/view books. It also shows how to write model and controller specs (tests),
and how to perform dependency injection.

## Pre-requisites

* Java (any version will do)
* Maven 2/3
* MySQL (only required for this startup app, not a real dependency for ActiveWeb)


## Get example app

Clone the app: [ActiveWeb simple example](https://github.com/javalite/activeweb-simple/)

~~~~
git clone git@github.com:javalite/activeweb-simple.git
~~~~


## Adjust DB properties
 
Edit this file, and adjust connection properties, as well as database names for different environments
 

~~~~
src/main/resources/database.properties
~~~~


## Create DB  schemas (in MySQL):

Execute the following in the root of the app:

~~~~
mvn db-migrator:create
mvn db-migrator:migrate
~~~~

This will create appropriate databases in MySQL and run migrations located in 

~~~~
src/migrations
~~~~

## Start the app

Execute:

~~~~ {.prettyprint}
mvn jetty:run
~~~~

Navigate with browser: [http://localhost:8080/activeweb-simple/](http://localhost:8080/activeweb-simple/)
