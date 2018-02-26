package app.services;

import com.google.inject.AbstractModule;
import com.google.inject.Provider;

import java.nio.file.Path;
import java.nio.file.Paths;

import static org.javalite.app_config.AppConfig.p;

/**
 *
 * @author Max Artyukhov
 */
public class WebModule extends AbstractModule {
    
    @Override
    protected void configure() {
        bind(SearchService.class).toInstance(new SearchService(Paths.get(p("search_dir"))));
        bind(BlogService.class).toInstance(new BlogService(p("blog_path")));
    }
}