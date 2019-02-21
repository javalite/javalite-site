package app.services;

import org.junit.Test;

import java.util.List;

import static org.javalite.test.jspec.JSpec.the;

public class BlogServiceSpec {

    @Test
    public void shouldIndexPosts(){
        BlogService blogService = new BlogService("src/test/resources/blog");
        List<Post> posts = blogService.getLatest(0);
        the(posts.size()).shouldBeEqual(2);
        the(posts.get(0).getTitle()).shouldBeEqual("Ehcache Broke Backwards Compatibility");
        the(posts.get(1).getTitle()).shouldBeEqual("Time to re-start a blog!");
    }
}
