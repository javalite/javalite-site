## Release notes v2.3

### Supported Java

Oracle JDK v 8.x


### ActiveJDBC Repo Changelog

2019-06-10 15:45:51 -0500 ipolevoy #862 Specify execution directory for RuntimeUtils
2019-06-01 12:03:42 -0400 creatorfromhell Make the properties file configurable.
2019-03-24 10:21:12 +0100 Michael Sell Allow calling 'scope' on an existing ScopeBuilder object.
2019-01-16 18:03:02 -0600 ipolevoy #833 Improve Util.createTree() method
2019-01-15 21:23:20 +0100 Fadi Shawki Only create schema version table if non-existent
2019-01-09 21:28:52 +0300 andrey@expresspigeon.com #479 Add ability to use model classes without connecting to the DB
2019-01-08 16:25:27 -0600 ipolevoy #821 JdbcPropertiesOverride: alternative properties processing error
2019-01-03 13:16:56 -0600 Igor Polevoy Merge pull request #823 from benhc123/patch-1
2018-12-29 23:53:50 +0000 snyk-bot fix: pom.xml to reduce vulnerabilities
2018-12-13 22:29:09 -0600 ipolevoy #813 Implement ability to create and delete directories recursively
2018-12-13 14:54:12 +0100 cschabli #819: Make inefficient log filtering efficient
2018-11-27 22:56:15 -0600 ipolevoy #815 Error on accessing Model in Android + SQLite JDBC
2018-11-07 14:00:30 -0800 David Siegal And updated the call from one to the other...
2018-11-07 13:56:28 -0800 David Siegal Rename closeBatch() to closePreparedStatement
2018-11-06 16:06:12 -0800 David Siegal Quietly close prepared statements.
2018-11-06 08:58:46 -0600 ipolevoy #808 - INSERT_INTO_PATTERN in QueryExecutionEvent is prone to StackOverflowError
2018-11-05 13:09:21 -0600 ipolevoy #807 - Collection of statistics on large queries causes large memory issues
2018-11-05 11:41:30 -0600 ipolevoy #796 Regression of #795: activejdbc_models.properties in Jar of War not found anymore - restoring ability to search for multiple activejdbc_models/properties file
2018-10-22 13:20:31 +0200 cschabli #800: Fixed missing double-checked locking in EHCacheManager
2018-10-18 01:57:17 -0500 ipolevoy #797 - Fix FasterXML vulnerability
2018-10-15 10:29:26 -0500 ipolevoy #795 - ActiveJDBC is unable to find activejdbc_models.properties in all cases
2018-10-02 00:32:26 -0500 ipolevoy #701 Setting an attribute to the same value should not set model as dirty - fixed tests, remove data conversion
2018-09-23 23:04:36 -0500 ipolevoy #742 - Allow RuntimeUtil.execute return more than 2048 chars
2018-09-15 01:06:37 +0100 João Francisco Almeida #788 - Upgrade to the latest PostgreSQL driver + fix build
2018-09-13 08:58:38 -0500 ipolevoy #787 Case sensitivity in Postgres - upgrading the driver to latest recommended
2018-09-10 00:11:49 +0100 João Francisco Almeida #785 - db-migrator-integration-test not passing on Travis due to security
2018-09-05 11:54:58 -0500 ipolevoy #784 - Implement support for JUnit 5
2018-09-02 09:45:48 +0200 rivella50 #701 Setting an attribute to the same value should not set model as dirty - finishing first version of better handling dirty attribute names
2018-08-28 23:34:42 -0500 ipolevoy #774 - NPE in Paginator.pageCount

The above is a partial list of commits that represent features and bugs that made it onto this release. The following are the important new features included into this releas:
 
2018-09-05 11:54:58 -0500 ipolevoy #784 - Implement support for JUnit 5
2019-01-09 21:28:52 +0300 andrey@expresspigeon.com #479 Add ability to use model classes without connecting to the DB

### ActiveWeb Repo Changelog

* 2019-06-04 17:14:13 -0500 ipolevoy [#431 SessionPool is emitting too much log at INFO level](https://github.com/javalite/activeweb/commit/8947105)
* 2019-06-04 17:12:38 -0500 ipolevoy [#433 NullPointerException in RequestDispatcher](https://github.com/javalite/activeweb/commit/adcfc2c)
* 2019-03-21 20:52:56 +0300 yanchevsky [#426 CSRFFilter not supported multipart/form-data](https://github.com/javalite/activeweb/commit/d29f26c)
* 2019-03-06 16:33:17 +0300 yanchevsky [#316 CSRF filter](https://github.com/javalite/activeweb/commit/df19bbe)
* 2019-02-27 21:05:59 -0600 ipolevoy [#421 Implement simulation of remote IP, host and port in controller specs](https://github.com/javalite/activeweb/commit/f07e830)
* 2019-02-27 20:50:42 -0600 ipolevoy [#417 Revisit and upgrade all dependencies](https://github.com/javalite/activeweb/commit/4772bb9)
* 2019-02-21 14:36:04 -0600 ipolevoy [#306 Implement OPTIONS method for RESTful controllers](https://github.com/javalite/activeweb/commit/ba9d3c5)
* 2019-02-21 14:03:00 -0600 ipolevoy [#419 Implement OPTIONS method for custom  routes](https://github.com/javalite/activeweb/commit/36fc804)
* 2019-02-11 17:59:54 -0600 ipolevoy [#415 AbstractLesscController needs to allow additional arguments for Lessc compiler](https://github.com/javalite/activeweb/commit/8780d10)
* 2019-02-03 11:11:25 -0600 ipolevoy [#414 Route bug when a controller package is a substring of another controller name](https://github.com/javalite/activeweb/commit/9a51780)
* 2019-01-28 15:22:38 -0600 ipolevoy [#413 Implement support for Junit 5](https://github.com/javalite/activeweb/commit/f54f751)
* 2019-01-14 12:06:08 -0300 mppfiles [Adding reference to underlying response object for low-level operations.](https://github.com/javalite/activeweb/commit/cda3608)
* 2019-01-12 22:56:13 -0600 ipolevoy [#409 Upgrade to latest version of commons-upload](https://github.com/javalite/activeweb/commit/56a0385)
* 2019-01-12 22:55:30 -0600 ipolevoy [#176 upgrade dependency on org.springframework:spring-test](https://github.com/javalite/activeweb/commit/615f29b)
* 2019-01-11 19:38:37 -0600 ipolevoy [#407 Implement ability to add/modify request context values from controller filters](https://github.com/javalite/activeweb/commit/4bec62f)
* 2018-09-26 23:46:18 -0500 ipolevoy [#400 Routing error in case controller and package has the same names](https://github.com/javalite/activeweb/commit/b317869)
* 2018-09-24 23:49:58 -0500 ipolevoy [#399 Error in routing](https://github.com/javalite/activeweb/commit/a736942)
* 2018-09-19 11:45:01 -0500 ipolevoy [#398 ContentForTag causes NPE if body is not provided](https://github.com/javalite/activeweb/commit/f207173)
* 2018-09-17 15:54:25 -0500 ipolevoy [#397 Custom route not recognized when controller in sub-package](https://github.com/javalite/activeweb/commit/8e1be8f)



* 2019-01-28 15:22:38 -0600 ipolevoy [#413 Implement support for Junit 5](https://github.com/javalite/activeweb/commit/f54f751)
* 2019-03-06 16:33:17 +0300 yanchevsky [#316 CSRF filter](https://github.com/javalite/activeweb/commit/df19bbe)