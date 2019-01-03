package app.controllers;

/**
 * @author Igor Polevoy on 1/11/16.
 */
public class BreadCrumb {
    private String text, href;

    public BreadCrumb(String text, String href) {
        this.text = text;
        this.href = href;
    }

    public String getText() {
        return text;
    }

    public String getHref() {
        return href;
    }
}
