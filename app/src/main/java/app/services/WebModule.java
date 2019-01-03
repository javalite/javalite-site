package app.services;

import com.google.inject.AbstractModule;
import org.javalite.index.SearchService;

import java.io.IOException;
import java.nio.file.Paths;

import static org.javalite.app_config.AppConfig.p;

/**
 *
 * @author Max Artyukhov
 */
public class WebModule extends AbstractModule {
    
    @Override
    protected void configure() {
        try {
            bind(SearchService.class).toInstance(new SearchService(Paths.get(p("search_dir")), "<strong>", "</strong>"));
        } catch (IOException e) {
            throw  new RuntimeException(e);
        }
        bind(BlogService.class).toInstance(new BlogService(p("blog_path")));
    }
}