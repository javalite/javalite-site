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
 * @author Igor Polevoy: 4/25/13 12:33 PM
 */

package app.models;

import org.javalite.activeweb.DBSpec;
import org.junit.Test;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UserSpec extends DBSpec {

    @Test
    public void shouldValidateAttributes() {

        User user = new User();

        the(user).shouldNotBe("valid");

        user.set("user_id", "igor");
        user.set("hash", "blah");

        the(user).shouldBe("valid");
    }


    @Test
    public void shouldStorePasswordHash() {

        String password = "hello_pwd";
        String userId = "the_admin";

        User user = new User(userId, password);
        user.saveIt();
        user = User.byUserId(userId);

        a(user.getHash()).shouldEqual(User.hashString(password));
    }
}
