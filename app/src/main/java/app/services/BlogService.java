package app.services;

import org.javalite.common.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.management.InstanceAlreadyExistsException;
import javax.management.ObjectName;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.*;

import static java.lang.Math.min;
import static java.util.Collections.emptyList;
import static java.util.stream.Collectors.toList;

/**
 * @author Igor Polevoy on 12/5/14.
 */
public class BlogService {

    private final File authorsRoot;
    private final Path postsRoot;

    private volatile Map<String, Author> authorsById = new HashMap<>();
    private volatile Map<String, Post> postBySlug = new HashMap<>();
    private volatile List<Post> posts = new ArrayList<>();
    private volatile NavigableSet<Post> postSet = new TreeSet<>();
    private volatile Map<String, List<Post>> postsByYear = new HashMap<>();
    private static final Logger LOGGER = LoggerFactory.getLogger(BlogService.class.getSimpleName());


    public BlogService(String rootPath) {
        authorsRoot = Paths.get(rootPath, "authors").toFile();
        postsRoot = Paths.get(rootPath, "posts");

        loadData();
    }

    public void loadData() {
        try {
            indexAuthors();
            indexPosts();
            LOGGER.info("Blog content reloaded");
        } catch (IOException e) {
            LOGGER.error("Could not load blog", e);
        }
    }

    private void indexAuthors() throws IOException {
        File[] authorsFiles = authorsRoot.listFiles(pathname -> pathname.getName().endsWith("md.html"));
        if (authorsFiles == null) {
            LOGGER.error("FAILED TO LOAD AUTHORS FOR BLOG!!!");
            return;
        }
        Map<String, Author> authorsById = new HashMap<>();
        for (File authorsFile : authorsFiles) {
            String authorId = authorsFile.getName().substring(0, authorsFile.getName().indexOf("."));
            Properties props = new Properties();
            String path = authorsFile.getCanonicalPath();
            String propFileName = path.substring(0, path.indexOf(".md.html")) + ".properties";
            try (FileInputStream is = new FileInputStream(propFileName)) {
                props.load(is);
            }
            Author author = new Author(props.getProperty("name"), props.getProperty("id"),
                    new String(Util.read(authorsFile)));
            authorsById.put(authorId, author);
        }
        this.authorsById = authorsById;
    }

    private void indexPosts() throws IOException {
        if (postsRoot.toFile().list() == null) {
            LOGGER.error("blog not found in " + postsRoot);
            return;
        }
        Map<String, Post> postBySlug = new HashMap<>();
        Files.walkFileTree(postsRoot, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path path, BasicFileAttributes attrs) {
                File file = path.toFile();
                String slug = file.getName().substring(0, file.getName().indexOf("."));
                Post post = postBySlug.computeIfAbsent(slug, k -> new Post());

                if (file.getName().endsWith("properties")) {
                    try {
                        post.setProperties(file);
                    } catch(Exception e ) {
                        throw new RuntimeException("failed  to process: " + file, e);
                    }
                } else if (file.getName().contains("excerpt")) {
                    post.setExcerpt(file);
                } else if (file.getName().endsWith("html")) {
                    post.setContent(file);
                } else {
                    throw new RuntimeException("found strange file: " + file.getAbsolutePath());
                }
                return FileVisitResult.CONTINUE;
            }
        });
        this.postBySlug = postBySlug;
        NavigableSet<Post> postSet = new TreeSet<>(postBySlug.values());
        List<Post> posts = new ArrayList<>();
        posts.addAll(postSet);
        this.postSet = postSet;
        this.posts = posts;
        Map<String, List<Post>> postsByYear = new HashMap<>();
        posts.forEach(post -> postsByYear.computeIfAbsent(post.getYear(), k -> new ArrayList<>()).add(post));
        this.postsByYear = postsByYear;
    }

    public Post getPost(String slug) {
        return postBySlug.get(slug);
    }

    public Author getAuthor(String authorId) {
        return authorsById.get(authorId);
    }

    public List<Post> getLatest(int page) {
        return getLatest(page, posts);
    }

    public List<Post> getYear(int page, String year) {
        return getLatest(page, postsByYear.get(year));
    }

    public List<Post> getYearMonth(int page, String year, String month) {
        List<Post> yearPosts = postsByYear.get(year);
        if (yearPosts == null)
            return emptyList();

        List<Post> res = yearPosts.stream().filter(p -> p.getMonth().equals(month)).collect(toList());
        return getLatest(page, res);
    }

    /**
     * Returns a list of 10 past posts from a list
     * @param page from 0
     */
    public List<Post> getLatest(int page, List<Post> posts) {
        int i = page * 10;
        return i >= posts.size() ? emptyList() : posts.subList(i, min(i + 10, posts.size()));
    }
    
    public Post getNext(Post post) {
        return this.postSet.higher(post);
    }
    
    public Post getPrevious(Post post) {
        return this.postSet.lower(post);
    }
}
