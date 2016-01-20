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
        view("id", "");
    }

    public void show() throws IOException {
        try {
            view("page", new Page(getId()));

            view("id", getId());

        } catch (Exception e) {
            e.printStackTrace();
            render("/system/404");
        }
    }

}
