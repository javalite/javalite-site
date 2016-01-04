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
        route("/{id}").to(PagesController.class).action("show").get();

        ignore("/bootstrap.css").exceptIn("development");
    }
}
