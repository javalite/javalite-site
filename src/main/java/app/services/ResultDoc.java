package app.services;

/**
 * @author igor on 2/17/18.
 */
public class ResultDoc {

    private String slug, fragment, title, type;

    public ResultDoc(String slug, String fragment, String title, String type) {

        this.slug = slug;
        this.fragment = fragment;
        this.title = title;
        this.type = type;
    }

    public String getSlug() {
        return slug;
    }

    public String getTitle() {
        return title;
    }

    public String getFragment() {
        return fragment;
    }

    public String getType() {
        return type;
    }

    @Override
    public String toString() {
        return "ResultDoc{" +
                "slug='" + slug + '\'' +
                ", fragment='" + fragment + '\'' +
                ", title='" + title + '\'' +
                ", type='" + type + '\'' +
                '}';
    }
}
