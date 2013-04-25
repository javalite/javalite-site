package app.controllers;

import app.models.Page;
import org.javalite.activeweb.DBControllerSpec;
import org.junit.Test;

import java.util.Map;

/**
 * @author Igor Polevoy: 5/6/12 6:23 PM
 */
public class PagesControllerSpec extends DBControllerSpec {

    @Test
    public void shouldNotAddIfParamsMissing(){

        session("user", "test_user");
        request().post("create");
        a(redirected()).shouldBeFalse();
        a(val("errors", Map.class).get("content")).shouldBeEqual("value is missing");
        a(val("errors", Map.class).get("title")).shouldBeEqual("value is missing");
        a(val("errors", Map.class).get("seo_id")).shouldBeEqual("value is missing");
    }

    @Test
    public void shouldAddNewPage(){
        session("user", "test_user");
        request().params("content", "this is page content", "title", "page title", "seo_id", "page_id").post("create");
        a(Page.count()).shouldBeEqual(1);
    }
}
