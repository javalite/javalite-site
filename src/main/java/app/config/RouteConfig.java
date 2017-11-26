package app.config;

import app.controllers.*;
import org.javalite.activeweb.AbstractRouteConfig;
import org.javalite.activeweb.AppContext;
import org.javalite.activeweb.Bootstrap;

/**
 * @author Igor Polevoy: 5/6/12 7:24 PM
 */
public class RouteConfig extends AbstractRouteConfig{
    public void init(AppContext appContext) {
        route("/bootstrap").to(BootstrapController.class);

        route("/blog").to(BlogController.class).action("index");
        route("/blog/author/{author}").to(BlogController.class).action("author");
        route("/blog/{year_or_slug}").to(BlogController.class).action("year-or-slug");
        route("/blog/{year}/{month}").to(BlogController.class).action("year-month");
        route("/blog/{year}/{month}/{slug}").to(BlogController.class).action("slug");
        route("/blog/{year}/{month}/{day}/{slug}").to(BlogController.class).action("slug");


        route("/{id}").to(PagesController.class).action("show").get();
        ignore("/bootstrap.css").exceptIn("development");
    }
}
