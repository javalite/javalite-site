package app.controllers;

import org.javalite.activeweb.AppController;

/**
 * @author Igor Polevoy: 5/7/12 3:01 AM
 */
public class LogoutController extends AppController {
    public void index(){
        session("user", null);

    }
}
