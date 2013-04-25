package app.controllers;

import app.models.User;
import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.POST;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

/**
 * @author Igor Polevoy: 5/6/12 7:40 PM
 */
public class LoginController extends AppController {

    public void index() {
    }

    @POST
    public void login() {

        User u = User.byUserId(param("user"));

        if (!exists("user") || !exists("password")) {
            render("failed");
        } else if (u != null && u.getHash().equals(User.hashString(param("password")))) {
            session("user", param("user"));
        }else{
            render("failed");
        }
    }
}
