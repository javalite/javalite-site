package app.controllers;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.RESTful;
import org.javalite.common.Inflector;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.javalite.app_config.AppConfig.p;
import static org.javalite.common.Util.readFile;

/**
 * @author Igor Polevoy: 5/6/12 6:16 PM
 */

@RESTful
public class PagesController extends AppController {

    public void index() {
    }

    public void show() throws IOException {
        try {
            view("title", getTitle());
            view("page", readFile(p("content_dir") + "/" + getId() + ".md.html"));
        } catch (Exception e) {
            e.printStackTrace();
            render("/system/404");
        }
    }

    private String getTitle() {

        if (getId() != null) {
            try {
                Properties props = new Properties();
                props.load(new FileInputStream(p("content_dir") + "/" + getId() + ".properties"));
                return props.getProperty("title") != null ? props.getProperty("title") : "";

            } catch (Exception e) {

                Pattern pattern = Pattern.compile("_", Pattern.CASE_INSENSITIVE);
                Matcher matcher = pattern.matcher(getId());
                return matcher.find() ? Inflector.capitalize(matcher.replaceAll(" ")) : getId();
            }

        } else {
            return "";
        }
    }
}
