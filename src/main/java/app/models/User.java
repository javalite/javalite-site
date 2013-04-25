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
 * @author Igor Polevoy: 4/25/13 12:21 PM
 */

package app.models;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import org.javalite.activejdbc.Model;

import java.security.MessageDigest;

public class User extends Model {

    static {
        validatePresenceOf("user_id", "hash");
    }

    public User() {}

    public User(String userId, String password) {
        set("hash", hashString(password));
        setUserId(userId);
    }

    /**
     * this is a user id, not the model id. Example: ipolevoy
     */
    public void setUserId(String userId) {
        set("user_id", userId);
    }

    public String getHash() {
        return getString("hash");
    }

    public static User byUserId(String userId) {
        return findFirst("user_id = ?", userId);
    }

    //Generates MD5 from string value.
    public static String hashString(String value) {
        try{
            return Base64.encode(MessageDigest.getInstance("MD5").digest(value.getBytes("UTF-8")));
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
