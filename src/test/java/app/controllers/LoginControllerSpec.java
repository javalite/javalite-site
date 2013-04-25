/*
Copyright 2009-2010 Igor Polevoy 

Licensed under the Apache License, Version 2.0 (the "License"); 
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 

http://www.apache.org/licenses/LICENSE-2.0 

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License. 
*/

/**
 * @author Igor Polevoy: 4/25/13 1:24 PM
 */

package app.controllers;

import app.models.User;
import org.javalite.activeweb.DBControllerSpec;
import org.javalite.test.XPathHelper;
import org.junit.Test;


public class LoginControllerSpec extends DBControllerSpec {

    @Test
    public void shouldNotLoginIfUserAndPasswordNotProvided() {

        request().integrateViews().post("login");
        XPathHelper page = new XPathHelper(responseContent());
        a(page.count("//a[text()='try again:']")).shouldEqual(1);
    }

    @Test
    public void shouldLoginIfBadLogin() {
        request().params("user", "admin", "password", "password123").integrateViews().post("login");

        XPathHelper page = new XPathHelper(responseContent());
        a(page.count("//a[text()='try again:']")).shouldEqual(1);
    }

    @Test
    public void shouldLoginIfBadPassword() {
        User u = new User("admin", "password123");
        u.saveIt();

        request().params("user", "admin", "password", "blah").integrateViews().post("login");

        XPathHelper page = new XPathHelper(responseContent());
        a(page.count("//a[text()='try again:']")).shouldEqual(1);
    }

    @Test
    public void shouldLoginGoodUser() {

        User u = new User("admin", "password123");
        u.saveIt();

        request().params("user", "admin", "password", "password123").integrateViews().post("login");
        a(responseContent()).shouldContain("you are logged in");
        a(sessionHas("user")).shouldBeTrue();
    }
}
