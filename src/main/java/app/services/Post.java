package app.services;

import java.io.File;
import java.io.FileInputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Properties;

import static org.javalite.common.Util.join;
import static org.javalite.common.Util.readFile;

/**
 * Represents a single blog post
 *
 * @author Igor Polevoy on 12/5/14.
 */
public class Post implements Comparable {
    private String title, content, authorId, authorName, slug, excerpt;
    private Date published;

    public void setContent(File contentFile) {
        try {
            content = readFile(contentFile.getCanonicalPath());
            slug = contentFile.getName().substring(0, contentFile.getName().indexOf("."));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void setExcerpt(File excerptFile) {
        try {
            excerpt = readFile(excerptFile.getCanonicalPath());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void setProperties(File propertiesFile) {
        Properties props = new Properties();
        try (FileInputStream fin = new FileInputStream(propertiesFile)) {
            props.load(fin);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        title = props.getProperty("Title");
        if (title == null) {
            throw new RuntimeException("Failed to get title from " + propertiesFile);
        }
        String author = props.getProperty("Author");
        if (author == null) {
            throw new RuntimeException("Failed to get author from " + propertiesFile);
        }
        if (author.contains("/")) {
            authorName = author.split("/")[0].trim();
            authorId = author.split("/")[1].trim();
        } else {
            authorName = author.trim();
            authorId = join(author.toLowerCase().split(" "), " ").replace(" ", "_").trim();
        }

        String date = props.getProperty("Date");

        if (date == null) {
            throw new RuntimeException("Failed to get date from " + propertiesFile);
        }

        //try two formats:
        try {
            published = new SimpleDateFormat("yyyy-MM-dd", Locale.US).parse(date);
        } catch (ParseException e) {
            throw new RuntimeException("Failed to parse date from: " + date);
        }
    }

    public String getTitle() {
        return title;
    }

    public String getAuthorName() {
        return authorName;
    }

    public String getAuthorId() {
        return authorId;
    }

    public Date getPublished() {
        return published;
    }

    public String getContent() {
        return content;
    }

    public String getSlug() {
        return slug;
    }

    public String getTopContent() {
        throw new UnsupportedOperationException("not implemented yet");
    }

    @Override
    public int compareTo(Object o) {
        if (!(o instanceof Post)) {
            throw new IllegalArgumentException("Must be a Post");
        }
        Post other = (Post) o;
        return other.published.compareTo(this.published);//reverse order!
    }

    @Override
    public String toString() {
        return published + " : " + title;
    }

    /**
     * @return preview of this post: top portion of content.
     */
    public String getExcerpt() {
        return excerpt == null ? content.substring(0, content.indexOf("</p>", 500) + 4) : excerpt;
    }

    public String getYear() {
        return new SimpleDateFormat("yyyy", Locale.US).format(published);
    }

    public String getMonth() {
        return new SimpleDateFormat("MM", Locale.US).format(published);
    }

    public String getDay() {
        return new SimpleDateFormat("dd", Locale.US).format(published);
    }
}
