package app.controllers;

import com.google.inject.Inject;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.javalite.activeweb.AppController;
import org.javalite.index.SearchService;

import java.io.IOException;

/**
 * @author igor on 2/17/18.
 */
public class SearchController extends AppController{

    @Inject
    private SearchService searchService;

    public void index() throws IOException, ParseException, InvalidTokenOffsetsException {
        view("documents", searchService.search(param("query")));
    }
}
