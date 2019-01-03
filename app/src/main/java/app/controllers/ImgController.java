package app.controllers;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.RESTful;
import org.javalite.common.Util;

import java.io.File;
import java.io.FileInputStream;

import static org.javalite.app_config.AppConfig.p;

/**
 * @author igor on 11/30/17.
 */
@RESTful
public class ImgController extends AppController {
    public void show(){
        try {
            streamOut(new FileInputStream(p("images_dir") + "/" + getId() + "." + format())).contentType("image/" + format());
        } catch (Exception e) {
            respond("").statusCode(404);
        }
    }
}
