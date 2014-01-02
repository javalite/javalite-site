package app.config;

import app.controllers.*;
import org.javalite.activeweb.AbstractRouteConfig;
import org.javalite.activeweb.AppContext;

/**
 * @author Igor Polevoy: 5/6/12 7:24 PM
 */
public class RouteConfig extends AbstractRouteConfig{
    public void init(AppContext appContext) {

        route("/login").to(LoginController.class);
        route("/logout").to(LogoutController.class);
        route("/pages").to(PagesController.class);
        route("/unauthorized").to(UnauthorizedController.class);
        route("/hash").to(HashController.class);
        route("/highlighter").to(HighlighterController.class);
        route("/bootswatch").to(BootswatchController.class);
        route("/{id}").to(PagesController.class).action("show").get();
    }
}
