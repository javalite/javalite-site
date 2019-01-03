<div class="page-header">
   <h1>Database configuration</h1>
</div>


ActiveWeb uses two application classes for configuration: 

* `app.config.DbConfig` - allows to configure connections for different environments.
* `app.config.AppControllerConfig` - allows configuration of `DBConnectionFilter` instances to various controllers. 
  See [Bind connections to controllers](#bind-connections-to-controllers)
  

In order to configure database connection, an application needs to provide a class called `app.config.DbConfig`.
It is used to configure database connections for various **environments and modes**.

## What is an environment?

An ActiveWeb environment is a computer where a project executes. In the process of software development there can be a
number of environments where a project gets executed, such as development, continuous integration, QA, staging,
production and more. The number of environments for ActiveWeb is custom for every project. However, it is typical to
have four: development, continuous integration, staging and production

## How to specify an environment

An environment is specified by either:

* Environment variable: `ACTIVE_ENV` 
* Java System property: `active_env` 

> If both, environment variable and a system property are specified, then system property overrides environment variable.

This value is used to determine which DB connections need to be initialized.

> Default environment: In case an environment variable `ACTIVE_ENV` is not provided, the framework defaults to "development".

## Execution modes

ActiveWeb defines two modes of operation: 

* "standard" - is also implicit and default. Used during regular execution of applications 
* "testing" - used during the build when tests are executed

ActiveWeb promotes a style of development where one database used for testing, but a different one used under normal 
execution. When tests are executed, a "test" database is used, and when a project is run in a normal mode, a 
"development" database is used. Having sa separate database for testing ensures safety of data in the development database.

## Configure connections

There are two basic ways to configure connections: property file and in code. You can also use a mixed approach, 
where connections are configured in a property file, and in code. Please, see section "Property file configuration" below.  

### Property file configuration

You can create a file called `database.properties` and place it on classpath or somewhere on the file system. 

The content of the file can be similar to: 

~~~~ {.numberLines}
development.driver=com.mysql.jdbc.Driver
development.username=root
development.password=pwd1
development.url=jdbc:mysql://localhost/simple_development

development.test.driver=com.mysql.jdbc.Driver
develppment.test.username=root
development.test.password=pwd2
development.test.url=jdbc:mysql://localhost/simple_test

jenkins.test.driver=com.mysql.jdbc.Driver
jenkins.test.username=root
jenkins.test.password=pwd2
jenkins.test.url=jdbc:mysql://jenkins.myhost.com/simple_test

production.driver=com.mysql.jdbc.Driver
production.username=root
production.password=pwd2
production.url=jdbc:mysql://localhost/simple_test
~~~~

The configure the class `app.config.DbConfig`: 


~~~~ {.java .numberLines}
public class DbConfig extends AbstractDBConfig {
    public void init(AppContext context) {
        configFile("/database.properties");
        environment("production", true).jndi("jdbc/simple_production");        
    }
}
~~~~

The property file configuration works well with [Database Migration](database_migrations) system, so that 
configuration of database connections is done only in one place. 

The last line in  `app.config.DbConfig` overrides "production" configuration from the file. The "production" configuration 
in the file can be used by [Database Migrator](database_migrations), while the app itself will be using a connection 
from a pool provided by container. 

> File-based configuration allows only one database connection configuration per environment. 
 
 Please, see a working example of file based configuration in the [ActiveWeb Simple](https://github.com/javalite/activeweb-simple/) project.

### Java code configuration

~~~~ {.java  .numberLines}
public class DbConfig extends AbstractDBConfig {
    public void init(AppContext context) {
         environment("development").jndi("jdbc/kitchensink_development");
         environment("development").testing().jdbc("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/kitchensink_development", "root", "****");
         environment("jenkins").testing().jdbc("com.mysql.jdbc.Driver", "jdbc:mysql://172.30.64.31/kitchensink_jenkins", "root", "****");
         environment("production").jndi("java:comp/env/jdbc/myproject_production);
    }
}
~~~~

The code above is borrowed from [Kitchensink](https://github.com/javalite/kitchensink) project.
Lets examine it line by line.

-   **Line 3**: here we provide configuration for a "standard" mode in "development" environment. This DB connection will
be used when the application is running under normal conditions in development environment.
-   **Line 4**: This is a configuration of DB connection for "development" environment, but for "testing" mode. This
connection will be used by unit and integration tests during the build.
-   **Line 5**: This is a configuration of DB connection for "jenkins" environment, but for "testing" mode.
The "jenkins" environment is a computer where this project is built by Jenkins - the continuous integration server.
Since Jenkins computer is fully automated, and this project is not running there in "standard" mode, there is no
standard configuration for jenkins environment, just one for testing.
-   **Line 6**: This is configuration similar to one on line 3, but for "production" environment.

> Configuration of database connections is just that - configuration. This code only configures a connection, but
does not open it. To open a connection, you need to use [DBConnectionFilter](https://github.com/javalite/activeweb/blob/master/activeweb/src/main/java/org/javalite/activeweb/controller_filters/DBConnectionFilter.java#DBConnectionFilter).
 For more, see [Controller filters](controller_filters).


### Multiple DB connections

In some cases you will need to connect to more than one database. The class `DbConfig` can be used to configure multiple 
connections in the same environment: 

Code configuration:

~~~~ {.java  .numberLines}
public class DbConfig extends AbstractDBConfig {
    public void init(AppContext context) {
         // default DB:
         environment("production", true).jndi("java:comp/env/jdbc/myproject_production1); 
         // named DB:
         environment("production", false).db("prod2").jndi("java:comp/env/jdbc/myproject_production2);
    }
}
~~~~

Two different databases are configured for environment 'production'. A corresponding binding of two instances 
in `DBConnectionFilter` will look like this:
  
~~~~ {.java .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
  @Override
  public void init(AppContext context) {
      add(new DBConnectionFilter("default", true), new DBConnectionFilter("prod2", true));
  }
}
~~~~

Binding of two instances of `DBConnectionFilter` class will ensure opening and closing connections to corresponding 
databases before/after  execution of controllers as specified in the `DbConfig` above.
  
Additionally, if you do not need the second connection on all controllers, then your configuration might like this: 

~~~~ {.java .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
  @Override
  public void init(AppContext context) {
      add(new DBConnectionFilter("default", true));
      add(new DBConnectionFilter("prod2", true)).to(MySpecialController.class);
  }
}
~~~~

This way, the connection to `prod2` will be opened only for execution of `MySpecialController`. 



### Different connections for controllers

If you need to use different connectios for different controllers, you  have to define 
your  named connections to databases in the DBConfig class: 


~~~~ {.java .numberLines}
public class DbConfig extends AbstractDBConfig {
    public void init(AppContext context) {
         environment("production", true).db("apples").jndi("java:comp/env/jdbc/apples_db; 
         environment("production", true).db("oranges").jndi("java:comp/env/jdbc/oranges_db);
    }
}
~~~~


Remember, that this is just configurations. The class `DbConfig` does not open any connections. 
Opening connections is a responsibility of `DBConnectionFilter` class: 


~~~~ {.java .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
  @Override
  public void init(AppContext context) {
      add(new DBConnectionFilter("default", true));
      add(new DBConnectionFilter("apples", true)).to(ApplesController.class);
      add(new DBConnectionFilter("oranges", true)).to(OrangesController.class);
  }
}

~~~~

**NOTE:** in this case, you will have different named databases on current thread. This means that the 
models executed in the `ApplesController` should be tagged with `apples` dababase name: 


~~~~ {.java .numberLines}
@DbName("apples")
public class Apple extends Model{}
~~~~

If not, you will get a "connection not found" exception. 


### Go crazy with connections

If you need a very complex logic opening different connections for different conditions, 
you may need to implement your own controller filter. Remember, that the `DBConnectionFilter` 
is just ... another ActiveWeb filter. Take a look at implementation: 
[DBConnectionFilter](https://github.com/javalite/activeweb/blob/master/activeweb/src/main/java/org/javalite/activeweb/controller_filters/DBConnectionFilter.java). 

All you need is to open  your connection with `Base.open()` od `DB.open()` in the `before()` method, close it in `after()` method 
and do what you have to in `onException(e)` method. 







## Bind Connections to controllers

Binding connections to controllers is done with `DBConnectionFilter` in `AppControllerConfig` class. 
Here is a typical example: 
  

~~~~ {.java .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
  @Override
  public void init(AppContext context) {
      add(new DBConnectionFilter("default", true));
  }
}
~~~~

Binding above will open a "default" database connection before execution of any controller. If this is too crude, you 
 can open connections for specific controllers: 
 
 
~~~~ {.java .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
    @Override
    public void init(AppContext context) {
       add(new DBConnectionFilter("default", true)).to(
       MyPrivateController1.class,MyPrivateController2.class,
       MyPrivateController3.class,MyPrivateController4.class
       );
    }
}
~~~~
 
 You can configure a fine-grain binding to a specific action: 
 
~~~~ {.java .numberLines}
public class AppControllerConfig extends AbstractControllerConfig {
    @Override
    public void init(AppContext context) {
        add(new DBConnectionFilter("default", true)).to(MyPrivateController1.class).forActions("index");
    }
}
~~~~

## Tying it all together
 
The [ActiveWeb Simple](https://github.com/javalite/activeweb-simple/) is one example of full configuration: 
 
* Property file: [database.properties](https://github.com/javalite/activeweb-simple/blob/master/src/main/resources/database.properties)
* [DBConfig](https://github.com/javalite/activeweb-simple/blob/master/src/main/java/app/config/DbConfig.java) - configure connections
* [AppControllerConfig](https://github.com/javalite/activeweb-simple/blob/master/src/main/java/app/config/AppControllerConfig.java) - bind connections to controllers
* DB-Migrator configuration: [pom.xml](https://github.com/javalite/activeweb-simple/blob/master/pom.xml#L35) - to configure [DB-Migrator](database_migrations). 

## Running without a database

If you need a simle  site that does not require a database or you are using a different type of a backend, you can simply delete the class `app.config.DbConfig` 
from  your project. When the framework starts, it will detect the absense of this class, will print a warning, but will operate without issues.

In adition to that, remove usage of `org.javalite.activeweb.controller_filters.DBConnectionFilter` or your custom filter from class `app.config.AppControllerConfig`. 


  
