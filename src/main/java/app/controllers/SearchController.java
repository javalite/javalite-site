package app.controllers;

import app.services.SearchService;
import com.google.inject.Inject;
import org.apache.lucene.queryparser.classic.ParseException;
import org.javalite.activeweb.AppController;

import java.io.IOException;

/**
 * @author igor on 2/17/18.
 */
public class SearchController extends AppController{

    @Inject
    private SearchService searchService;

    public void index() throws IOException, ParseException {
        view("documents", searchService.search(param("query")));
    }
}
