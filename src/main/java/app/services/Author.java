package app.services;

/**
 * @author Igor Polevoy on 12/5/14.
 */
public class Author {
    private String name, id, description;

    public Author(String name, String id, String description) {
        this.name = name;
        this.id = id;
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public String getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }
}
