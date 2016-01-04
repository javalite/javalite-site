package app.controllers;

import org.javalite.activeweb.controllers.AbstractLesscController;

import java.io.File;

/**
 * @author Igor Polevoy on 1/4/16.
 */
public class BootstrapController extends AbstractLesscController {
    @Override
    protected File getLessFile() {
        return new File("src/main/webapp/less/bootstrap.less");
    }
}
