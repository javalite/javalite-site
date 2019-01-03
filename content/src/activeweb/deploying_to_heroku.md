<div class="page-header">
   <h1>Deploying to heroku</h1>
</div>

This guide uses the ClearDB mysql service, but it could easily be adapted to the Heroku Postgres service.

FYI: its completely possible that I forgot something in this guide and that it will need to be updated by the very first person that tries to use it. Post something on the GoogleGroup if you need help.

The basic idea is that Heroku puts a specific environment variables in your apps config that you need to be able to read at runtime to setup your db connections. Try this command in your Heroku toolbelt to see your current config vars. You might see something like this:

~~~~ {.prettyprint}
~> heroku config
=== your app Config Vars

CLEARDB_DATABASE_URL: mysql://zzzzzz@us-cdbr-east-03.cleardb.com/heroku_yyyyyy?reconnect=true
DATABASE_URL:         mysql://zzzzzz@us-cdbr-east-03.cleardb.com/heroku_yyyyyy?reconnect=true
SENDGRID_PASSWORD:    PPPPPPP
SENDGRID_USERNAME:    UUUUUU@heroku.com
~~~~

## Database URL

The recommended practice by Heroku is to have the full database url in an environment variable named DATABASE\_URL. By default ClearDB puts the URL in a different var (shown above) and you have to copy the value into a new var with this name. Try this to learn about setting up config vars

~~~~ {.prettyprint}
heroku help config
~~~~

## At runtime

Your next task is to be able to read this variable at runtime. Here's a class and its spec for the Utility that I use to do so

~~~~ {.java  .numberLines}
package app.utils;
import org.junit.Test;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import static org.javalite.test.jspec.JSpec.the;
/**
 * Created By
 * User: Evan Leonard
 * Date: 3/30/13
 */
public class HerokuDbUrlParserSpec {
    private static String clear_db_url = "mysql://THE_USERNAME:THE_PASSWORD@us-cdbr-east-03.cleardb.com/heroku_759ea2a30074fe9?reconnect=true";
    //private static String test_db_url = "mysql://aw:awawaw@localhost/ayah_test?reconnect=true";
    @Test
    public void shouldParseUrl() throws URISyntaxException {
        Map<String, String> mockEnv = mockEnv();
        HerokuDbUrlParser herokuDbUrlParser = new HerokuDbUrlParser(mockEnv);
        Properties jdbcProperties = herokuDbUrlParser.getJdbcProperties();
        the(jdbcProperties.getProperty("driver")).shouldEqual("com.mysql.jdbc.Driver");
        the(jdbcProperties.getProperty("url")).shouldEqual("jdbc:mysql://us-cdbr-east-03.cleardb.com/heroku_759ea2a30074fe9?reconnect=true");
        the(jdbcProperties.getProperty("user")).shouldEqual("THE_USERNAME");
        the(jdbcProperties.getProperty("password")).shouldEqual("THE_PASSWORD");
        the(herokuDbUrlParser.getDriver()).shouldEqual("com.mysql.jdbc.Driver");
        the(herokuDbUrlParser.getUrl()).shouldEqual("jdbc:mysql://us-cdbr-east-03.cleardb.com/heroku_759ea2a30074fe9?reconnect=true");
        the(herokuDbUrlParser.getUser()).shouldEqual("THE_USERNAME");
        the(herokuDbUrlParser.getPassword()).shouldEqual("THE_PASSWORD");
    }
    private Map<String, String> mockEnv() {
        Map<String, String> mockEnv = new HashMap<String, String>();
        mockEnv.put("DATABASE_URL", clear_db_url);
        return mockEnv;
    }
}
~~~~

And the implementation:

~~~~ {.java  .numberLines}
package app.utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Map;
import java.util.Properties;
/**
 * Created By
 * User: evan
 * Date: 3/27/13
 *
 * Heroku sets the production database url into an environment variable named DATABASE_URL.
 *
 * This class is parses that at runtime for ActiveWeb to use in DbConfig.java
 */
public class HerokuDbUrlParser {
    private static final Logger logger = LoggerFactory.getLogger(HerokuDbUrlParser.class);
    public static final String DATABASE_URL = "DATABASE_URL";
    private boolean databaseUrlFound = false;
    private String driver;
    private String user;
    private String password;
    private String url;

    public HerokuDbUrlParser(Map<String, String> environmentVariables) {
        String database_url = getHerokuDatabaseUrl(environmentVariables);
        if(database_url != null) {
            databaseUrlFound = true;
            if (logger.isInfoEnabled()) logger.info("Found DATABASE_URL: "+database_url);
            parseDatabaseUrl(database_url);
        }
        else {
            if (logger.isInfoEnabled()) logger.info("DID NOT FIND DATABASE_URL ENV VARIABLE!");
        }
    }

    private void parseDatabaseUrl(String database_url) {
        try {
            URI dbUri = new URI(database_url);
            driver = inferDriverClass(database_url);
            user = dbUri.getUserInfo().split(":")[0];
            password = dbUri.getUserInfo().split(":")[1];
            String authPart = user + ":" + password + "@";
            url = "jdbc:"+database_url.replace(authPart, "");
        } catch (URISyntaxException e) {
            logger.error("Failed to parse Heroku DB Url", e);
            driver = url = user = password = null;
            throw new RuntimeException("Failed to parse Heroku DB Url",e);
        }
    }

    private static String getHerokuDatabaseUrl(Map<String, String> environmentVariables) {
        String database_url = environmentVariables.get(DATABASE_URL);
        if(database_url != null) {
            logger.error("FOUND DB URL IN ENVIRONMENT VARIABLES");
        }
        else {
            database_url = System.getProperty(DATABASE_URL);
            if(database_url != null){
                logger.error("FOUND DB URL IN SYSTEM PROPERTIES");
            }
        }
        return database_url;
    }

    private static String inferDriverClass(String database_url) {
        String driver;
        if(database_url.contains("mysql")) {
            driver = "com.mysql.jdbc.Driver";
        }
        else {
            throw new NotImplementedException();
        }
        return driver;
    }

    public String getDriver() {
        return driver;
    }

    public String getUrl() {
        return url;
    }

    public String getUser() {
        return user;
    }

    public String getPassword() {
        return password;
    }

    /**
     * @return Property set that contains: 'driver', 'url', 'user', and 'password' with no prefix
     */
    public Properties getJdbcProperties() {
        if(!databaseUrlFound) {
            return null;
        }

        String driver = getDriver();
        String url = getUrl();
        String user = getUser();
        String password = getPassword();

        Properties properties = new Properties();
        properties.setProperty("driver", driver);
        properties.setProperty("url", url);
        properties.setProperty("user", user);
        properties.setProperty("password", password);

        return properties;
    }
}
~~~~

With that in place you call this use this method in your DbConfig with "production" and the jdbcProperties returned by the parser above to setup your ActiveJdbc connection

~~~~ {.java  .numberLines}
private void createConnection(String env, Properties jdbcProperties) {
    String driver = jdbcProperties.getProperty("driver");
    String url = jdbcProperties.getProperty("url");
    environment(env).jdbc(driver, url, jdbcProperties);
    environment(env).testing().jdbc(driver, url, jdbcProperties);
}
~~~~

## Building on Heroku

Heroku of course will try to build your app as soon as you push its git repo. It does a good job of detecting that its
a Java app and running maven. Where I ran into trouble was that I had configured my POM to do different things based on
the value of the ACTIVE\_ENV environment variable. Even thought I could set a config var of that name,
**config vars are not available at build time**

The approach I found was to fork the heroku java build pack and hardcode -DACTIVE\_ENV=production into the java
properties used to run maven. Here is the location of my forked buildpack:

~~~~ {.prettyprint}
https://github.com/evanleonard/heroku-buildpack-java
~~~~

To have your app use it to if you want, you just set a config var like this:

~~~~ {.prettyprint}
BUILDPACK_URL:        https://github.com/evanleonard/heroku-buildpack-java
~~~~

> Note: after my first successful build I noticed that these config vars appeared. It may be possible to modify
them to eliminate the need for this custom build pack. But I haven't tried to do this yet.

~~~~ {.prettyprint}
JAVA_OPTS:            -Xmx384m -Xss512k -XX:+UseCompressedOops
MAVEN_OPTS:           -Xmx384m -Xss512k -XX:+UseCompressedOops
~~~~

## Disabling Tests

Also had to disable running of Selenium tests in my POM.

TODO

## Heroku SSL support

There's two things you need to do after you've enabled your SSL endpoint add-on in heroku. The first is to force traffic
from regular http to https. This is easily done in a filter with methods like these

~~~~ {.java  .numberLines}
/**
 * http://stackoverflow.com/questions/7185074/heroku-nodejs-http-to-https-ssl-forced-redirect
 */
private boolean isHttpsRequest() {
    String header = header("x-forwarded-proto");
    return header != null && header.equals("https");
}
private void redirectToHttps() {
    flash(Constants.PJAX_FORCE_RELOAD, true);
    StringBuilder newUrl = getHttpsUrl();
    redirect(newUrl.toString());
}
~~~~

The next is to rewrite incoming requests so they appear as though they came straight from the client, eventhough they've
been routed through the SSL endpoint. The best way I found to do this was with the XForwardedFilter from Xebia.
To enable put this in your pom:

~~~~ {.xml  .numberLines}
<dependency>
    <groupId>fr.xebia.web</groupId>
    <artifactId>xebia-servlet-extras</artifactId>
    <version>1.0.8</version>
</dependency>
~~~~

and then add this to your web.xml above the dispatcher's filter-mapping:

~~~~ {.xml  .numberLines}
<filter>
    <filter-name>XForwardedFilter</filter-name>
    <filter-class>fr.xebia.servlet.filter.XForwardedFilter</filter-class>
    <init-param>
        <param-name>protocolHeader</param-name>
        <param-value>x-forwarded-proto</param-value>
    </init-param>
</filter>

<!-- This must be before the dispatcher so that it is executed first in the filter chain -->
<filter-mapping>
    <filter-name>XForwardedFilter</filter-name>
    <url-pattern>/*</url-pattern>
    <dispatcher>REQUEST</dispatcher>
</filter-mapping>
~~~~

## Summary


That should be it, go ahead and push to your git repo, let Heroku do its thing and see if you get a new build live on
the web. Then enjoy continuous deployment!

Oh, and please post something on the GoogleGroup if (when?) you run into a problem. As I said at the start,
its very likely I missed something here.

Best Evan
