package app.controllers;

import org.javalite.common.Inflector;
import org.javalite.common.RuntimeUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.javalite.app_config.AppConfig.p;
import static org.javalite.common.Util.readFile;

/**
 * @author Igor Polevoy on 1/11/16.
 */
public class Page {

    private String title, content;
    private List<BreadCrumb> breadCrumbs;

    public Page(String id) throws UnknownHostException, FileNotFoundException {
        if (id != null) {
            try {
                Properties props = new Properties();
                props.load(new FileInputStream(p("pages_dir") + "/" + id + ".properties"));
                breadCrumbs = readBreadrumbs(props);
                title = props.getProperty("title") != null ? props.getProperty("title") : inferTitle(id);
            } catch (Exception e) {
                title = inferTitle(id);
                breadCrumbs = new ArrayList<>();
            }

        } else {
            title = inferTitle(id);
        }


        if(InetAddress.getLocalHost().toString().contains("igordell")){
            File ajFile = new File("/home/igor/projects/javalite/javalite-site/content/src/activejdbc/" + id + ".md");

            File awFile = new File("/home/igor/projects/javalite/javalite-site/content/src/activeweb/" + id + ".md");

            File file;
            if(ajFile.exists()){
                file = ajFile;
            }else if(awFile.exists()){
                file = awFile;
            }else {
                throw new FileNotFoundException("id");
            }
            content = RuntimeUtil.execute(80096, "pandoc", "-f", "markdown", "-t", "html", file.toString()).out;
            return;
        }
        content = readFile(p("pages_dir") + "/" + id + ".md.html");
    }

    private String inferTitle(String id){
        Pattern pattern = Pattern.compile("(_|-)", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(id);
        return matcher.find() ? Inflector.capitalize(matcher.replaceAll(" ")) : id;
    }

    private List<BreadCrumb> readBreadrumbs(Properties props) {
        List<BreadCrumb> breadCrumbs = new ArrayList<>();
        if (props.containsKey("breadcrumbs")) {
            //breadcrubms=JavaLite -> / , ActiveJDBC -> /activejdbc
            String[] parts = org.javalite.common.Util.split(props.getProperty("breadcrumbs"), ",");
            for (String part : parts) {
                String[] bc = org.javalite.common.Util.split(part, "->");
                breadCrumbs.add(new BreadCrumb(bc[0].trim(), bc[1].trim()));
            }
        }
        return breadCrumbs;
    }

    public String getTitle() {
        return title;
    }

    public List<BreadCrumb> getBreadCrumbs() {
        return breadCrumbs;
    }

    public String getContent() {
        return content;
    }
}
