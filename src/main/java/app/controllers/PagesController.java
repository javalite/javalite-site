package app.controllers;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.RESTful;
import org.javalite.common.Util;
import org.javalite.test.XPathHelper;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.StringReader;

import static org.javalite.common.Util.readFile;

/**
 * @author Igor Polevoy: 5/6/12 6:16 PM
 */

@RESTful
public class PagesController extends AppController {

    public void index() {
        view("page", readFile("/home/igor/projects/javalite/website/output/index.html"));
    }

    public void show() throws IOException {
        String file = readFile("/home/igor/projects/javalite/website/output/" +getId() + ".md.html");

        BufferedReader br = new BufferedReader(new StringReader(file));
        String firstLine = br.readLine();

        String[] parts = firstLine.split("\\|");
        String title = "";
        String[] breadcrubms = new String[0];

        if(parts.length == 2){
            title = parts[0].substring(3);
            breadcrubms = parts[1].substring(1, parts[1].length() - 4).split(",");
        }

        if(!title.equals("")){
            view("title", title);
            view("breadcrumbs", breadcrubms);
            view("page", file.substring(firstLine.length()));

        }else{
            view("page", file);
        }
    }
}
