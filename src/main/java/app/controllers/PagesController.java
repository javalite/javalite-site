package app.controllers;

import app.models.Page;
import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.RESTful;

/**
 * @author Igor Polevoy: 5/6/12 6:16 PM
 */

@RESTful
public class PagesController extends AppController {

    public void index() {
        view("pages", Page.findAll().orderBy("seo_id asc"));
    }


    public void show() {
        Page p = (Page) Page.findFirst("seo_id = ?", param("id"));

        if (p == null) {
            render("/system/404");
        } else {
            view("page", p);
        }
    }

    public void create() {

        Page p = new Page();
        p.fromMap(params1st());
        if (p.save()) {
            redirect(PagesController.class);
        } else {
            view("page", p);
            view("errors", p.errors());
            render("new_form");
        }
    }

    public void newForm() {}


    public void editForm() {
        Page p = (Page) Page.findFirst("seo_id = ?", param("id"));
        if (p != null) {
            view("page", p);
        } else {
            render("/system/404");
        }
    }

    public void update() {
        Page p = (Page) Page.findFirst("seo_id = ?", param("id"));
        p.setTitle(param("title"));
        p.setContent(param("content"));

        if (p.save()) {
            redirect(PagesController.class, param("seo_id"));
        } else {
            view("page", p);
            view("errors", p.errors());
            render("edit_form");
        }
    }
}
