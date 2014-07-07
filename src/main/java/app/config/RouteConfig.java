package app.config;

import app.controllers.*;
import org.javalite.activeweb.AbstractRouteConfig;
import org.javalite.activeweb.AppContext;

/**
 * @author Igor Polevoy: 5/6/12 7:24 PM
 */
public class RouteConfig extends AbstractRouteConfig{
    public void init(AppContext appContext) {
        route("/bootswatch").to(BootswatchController.class);
        route("/{id}").to(PagesController.class).action("show").get();
    }
}
