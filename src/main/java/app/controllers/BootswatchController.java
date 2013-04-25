package app.controllers;

import org.javalite.activeweb.AppController;

/**
 * @author Igor Polevoy: 4/16/12 5:49 PM
 */
public class BootswatchController extends AppController {

    public void index(){
        render().noLayout();
    }
}
