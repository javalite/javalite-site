package app.services;

import com.google.inject.AbstractModule;
import com.google.inject.Provider;

import static org.javalite.app_config.AppConfig.p;

/**
 *
 * @author Max Artyukhov
 */
public class WebModule extends AbstractModule {
    
    @Override
    protected void configure() {
        bind(BlogService.class).toProvider(new Provider<BlogService>() {
            @Override
            public BlogService get() {
                return new BlogService(p("blog_path"));
            }
        }).asEagerSingleton();
    }
}