package app.models;

import org.javalite.activeweb.DBSpec;
import org.junit.Test;

/**
 * @author Igor Polevoy: 5/6/12 6:16 PM
 */
public class PageSpec extends DBSpec {

    @Test
    public void shouldValidatePresenceOfAttributes(){
        Page page = new Page();
        the(page).shouldNotBe("valid");
        page.setContent("blah content").setSeoId("some_page").setTitle("this is a simple page");
        the(page).shouldBe("valid");
    }
}
