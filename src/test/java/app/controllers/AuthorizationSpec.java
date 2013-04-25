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
 * @author Igor Polevoy: 4/25/13 3:24 PM
 */

package app.controllers;

import app.models.User;
import org.javalite.activeweb.AppIntegrationSpec;
import org.junit.Test;

public class AuthorizationSpec extends AppIntegrationSpec {

    @Test
    public void shouldNotAllowAccessToProtectedResourcesIfNotLoggedIn() {

        controller("pages").integrateViews().post("update");
        a(redirected()).shouldBeTrue();
        a(redirectValue()).shouldBeEqual("/unauthorized");
        controller("unauthorized").integrateViews().get("index");
        a(responseContent()).shouldContain("not authorized");
    }

    @Test
    public void shouldAllowAccessToLoggedInUser() {

        //first, test we cannot access protected resource
        controller("pages").integrateViews().get("edit-form");
        a(redirected()).shouldBeTrue();

        //create user
        User u = new User("admin", "password123");
        u.saveIt();
        //login
        controller("/login").params("user", "admin", "password", "password123").integrateViews().post("login");

        //call protected resource
        controller("pages").integrateViews().get("edit-form");
        a(redirected()).shouldBeFalse();

    }
}
