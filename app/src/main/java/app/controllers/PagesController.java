package app.controllers;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.RESTful;

/**
 * @author Igor Polevoy: 5/6/12 6:16 PM
 */

@RESTful
public class PagesController extends AppController {

    public void index() {
        view("id", "");
    }

    public void show() {
        try {
            view("page", new Page(getId()));
            view("title", getId().replaceAll("_", " "));
            view("id", getId());

        } catch (Exception e) {
            e.printStackTrace();
            render("/system/404");
        }
    }

}
