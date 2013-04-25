package app.models;

import org.javalite.activejdbc.Model;
import org.javalite.activejdbc.annotations.Cached;

/**
 *
 * <pre>
 *      +------------+--------------+------+-----+---------+----------------+
        | Field      | Type         | Null | Key | Default | Extra          |
        +------------+--------------+------+-----+---------+----------------+
        | id         | int(11)      | NO   | PRI | NULL    | auto_increment |
        | title      | varchar(128) | NO   |     | NULL    |                |
        | content    | text         | NO   |     | NULL    |                |
        | created_at | datetime     | YES  |     | NULL    |                |
        | updated_at | datetime     | YES  |     | NULL    |                |
        | seo_id     | varchar(128) | NO   |     | NULL    |                |
        +------------+--------------+------+-----+---------+----------------+
 * </pre>
 * @author Igor Polevoy: 5/6/12 6:13 PM
 */
@Cached
public class Page extends Model {
    static {
        validatePresenceOf("title", "content", "seo_id");
    }

    @Override
    protected void beforeSave() {
        if(getSeoId() != null)
            setSeoId(getSeoId().replace(" ", "_"));

    }

    public Page setContent(String content){
        return (Page) set("content", content);
    }

    public String getContent(){
        return getString("content");
    }


    public Page setTitle(String title){
        return (Page) set("title", title);
    }

    public String getTitle(){
        return getString("title");
    }


    public Page setSeoId(String seoId){
        return (Page) set("seo_id", seoId);
    }

    public String getSeoId(){
        return getString("seo_id");
    }
}
