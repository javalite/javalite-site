package app.controllers;


import app.services.Author;
import app.services.BlogService;
import app.services.Post;
import com.google.inject.Inject;
import org.javalite.activeweb.AppController;

import java.util.regex.Pattern;


/**
 * @author Igor Polevoy on 12/5/14.
 */
public class BlogController extends AppController {

    @Inject
    private BlogService service;
    private final Pattern yearPattern = Pattern.compile("20\\d\\d");

    public void author(){
        Author author = service.getAuthor(param("author"));
        if(author != null){
            view("author", author);
        }else{
            render("/system/404").noLayout().status(404);
        }
    }

    //route("/blog").to(BlogController.class).action("index");
    public void index() {
        view("id", "blog");

        int page = 0;
        try {
            page = Integer.parseInt(param("page"));
        } catch (Exception ignore) {
        }

        if (page < 0)
            page = 0;

        Object o = service.getLatest(page);

        view("posts", o);

        if (service.getLatest(page + 1).size() > 0) {
            view("prev_page", page + 1);
        }

        if (page > 0 && service.getLatest(page - 1).size() > 0) {
            view("next_page", page - 1);
        }
        render("posts");
    }

    //route("/blog/{year_or_slug}").to(BlogController.class).action("year-or-slug");
    public void yearOrSlug() {
        String yearOrSlug = param("year_or_slug");
        if (yearPattern.matcher(yearOrSlug).matches()) {
            year(yearOrSlug);
        } else {
            slug(yearOrSlug);
        }
    }

    //route("/blog/{year}/{month}").to(BlogController.class).action("year-month");
    public void yearMonth() {
        int page = 0;
        try {
            page = Integer.parseInt(param("page"));
        } catch (Exception ignore) {
        }
        String month = param("month");
        if (!blank("month") && month.length() == 1) {
            month = "0" + month;
        }
        view("posts", service.getYearMonth(page, param("year"), month));
        render("posts");
    }

    //route("/blog/{year}/{month}/{slug}").to(BlogController.class).action("slug");
    public void slug() {
        slug(param("slug"));
    }

    private void year(String year) {
        view("posts", service.getYear(0, year));
        render("posts");
    }

    private void slug(String slug) {
        Post post = service.getPost(slug);
        if (post == null) {
            render("/system/404").noLayout().status(404);
        } else {
            view("post", post);
            view("next", service.getNext(post));
            view("prev", service.getPrevious(post));
            render("post");
        }
    }
}
