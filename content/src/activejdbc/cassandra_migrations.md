<div class="page-header">
   <h1>Cassandra migrations</h1>
</div>



The [DBMigrator](database_migrations) plugin also allows (since v 2.4.x) 
working with Cassandra databases.  

Since Cassandra is not really a relation database, it is not currently  supported by ActiveJDBC models. 
However, the DBMigrator does provide Cassandra support to create/drop keyspaces as well as make all necessary changes 
for tables, etc, as long as you provide CQL - compatible code in your migration files. 

> Migration file extensions are `sql`, not `cql`. 
  
## JDBC Driver 

The JavaLite DBMigrator plugin  uses its own JDBC driver developed strictly to  add Cassandra support to the plugin. 

> The JDBC driver is NOT a real JDBC driver. Its implementation strictly supports the DBMigrator plugin and nothing else. 
Using this driver outside the DBMigrator plugin to might cause bodily injury.    

## Example configuration   

~~~~{.xml .numberLines}
<plugin>
    <groupId>org.javalite</groupId>
    <artifactId>db-migrator-maven-plugin</artifactId>
    <version>2.4-j8</version>
    <configuration>
        <configFile>src/main/resources/database.properties</configFile>
        <environments>development</environments>
        <createSql>CREATE KEYSPACE %s WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1 };</createSql>
        <dropSql>DROP KEYSPACE IF EXISTS %s</dropSql>
    </configuration>
    <executions>
        <execution>
            <id>create_keyspace</id>
            <phase>validate</phase>
            <goals>
                <goal>create</goal>
            </goals>
        </execution>
        <execution>
            <id>migrate</id>
            <phase>validate</phase>
            <goals>
                <goal>migrate</goal>
            </goals>
        </execution>
    </executions>
    <dependencies>
        <dependency>
            <groupId>com.datastax.oss</groupId>
            <artifactId>java-driver-core-shaded</artifactId>
            <version>4.8.0</version>
        </dependency>
    </dependencies>
</plugin>
~~~~

* Line 6 points to a `database.properties` for `development` environment as is typical for JavaLite projects. 
* Lines 8 and 9 include "create" and "drop" statements to assist the plugin  

 

The `database.properties` file includes this content: 

```
development.driver=org.javalite.cassandra.jdbc.CassandraJDBCDriver
development.url=jdbc:cassandra:///javalite?config_file=src/application.conf
``` 

## The JDBC URL



The general format  of a URL is: 

```
jdbc:cassandra:///[keyspace]?config_file=[path/to/config/file]
```

As you can see, the "host" is not provided. If you do provide the host, it will result in an error.

Real example: 

```
jdbc:cassandra:///javalite?config_file=src/application.conf
```
The keyspace in an example above is `javalite`.  

The URL merely serves as a pointer to a Cassandra configuration  file, which might  include quite elaborate configuration 
for Cassandra, including  multiple  hosts.

Here is an example  of an `application.conf` file: 

```
datastax-java-driver {
  basic.contact-points = [ "127.0.0.1:9043" ]
}
```
 
For more information on the format of this file, refer to: 
[Cassandra Java Driver Configuration](https://docs.datastax.com/en/developer/java-driver/4.0/manual/core/configuration/).


## Multiple databases example 

Often you have Cassandra as well as another relational database 


First, define properties for driver and the URL: 

~~~~{.xml}
    <properties>
        <cassandra.driver>org.javalite.cassandra.jdbc.CassandraJDBCDriver</cassandra.driver>
        <cassandra.url>jdbc:cassandra:///javalite?config_file=${project.basedir}/src/application.conf</cassandra.url>
    </properties>
~~~~ 

The add this plugin to your POM file: 

~~~~{.xml}
<plugin>
    <groupId>org.javalite</groupId>
    <artifactId>db-migrator-maven-plugin</artifactId>
    <version>2.5-j8-SNAPSHOT</version>
    <configuration>
        <createSql>CREATE KEYSPACE %s WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};</createSql>
        <dropSql>DROP KEYSPACE IF EXISTS %s</dropSql>
    </configuration>
    <executions>
        <execution>
            <id>cassandra_create</id>
            <configuration>
                <driver>${cassandra.driver}</driver>
                <url>${cassandra.url}</url>
                <createSql>CREATE KEYSPACE %s WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1 };</createSql>
            </configuration>
            <phase>validate</phase>
            <goals>
                <goal>create</goal>
            </goals>
        </execution>
        <execution>
            <id>cassandra_migrate</id>
            <configuration>
                <driver>${cassandra.driver}</driver>
                <url>${cassandra.url}</url>
            </configuration>
            <phase>validate</phase>
            <goals>
                <goal>migrate</goal>
            </goals>
        </execution>
        <execution>
            <id>mysql_migrations</id>
            <configuration>
                <migrationsPath>src/migrations/mysql</migrationsPath>
                <driver>com.mysql.cj.jdbc.Driver</driver>
                <url>jdbc:mysql://localhost/test_project</url>
                <username>activejdbc</username>
                <password>****</password>
            </configuration>
            <phase>validate</phase>
            <goals>
                <goal>migrate</goal>
            </goals>
        </execution>
    </executions>
    <dependencies>
        <dependency>
            <groupId>com.datastax.oss</groupId>
            <artifactId>java-driver-core-shaded</artifactId>
            <version>4.8.0</version>
        </dependency>
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.16</version>
        </dependency>
    </dependencies>
</plugin>
~~~~

The configuration above will migrate both, Cassandra as well as MySQL database.

As you can see, Cassandra and MySQL have different `executions`. Use those execution names when you 
create new migrations or perform any other operations: 

For example, this command: 

```
mvn db-migrator:new@cassandra_create -Dname=create_table_students
```

Will result  in this output: 

```
[INFO] --- db-migrator-maven-plugin:2.4-j8:new (cassandra_create) @ db-migrator-maven-plugin-test2 ---
[INFO] Created new migration: ***/src/test/project/cassandra-mysql-test-project/src/migrations/20201006125327_create_table_students.sql
```

By default `migrationsPath`  points to `src/migrations`. 
  
> The actual migrations will be triggered by a Maven `validate` phase, which happens at the beginning of any Maven build. 

## Working examples

Check out complete working examples of [Cassandra Maven Projects](https://github.com/javalite/javalite/tree/master/db-migrator-integration-test/src/test/project). 


