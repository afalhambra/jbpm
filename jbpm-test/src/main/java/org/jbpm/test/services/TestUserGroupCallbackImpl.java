/*
 * Copyright 2017 Red Hat, Inc. and/or its affiliates.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.jbpm.test.services;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import static java.util.Arrays.asList;
import static java.util.Collections.emptyList;
import static java.util.Collections.singletonList;

public class TestUserGroupCallbackImpl implements TestUserGroupCallback {

    private final Map<String, List<String>> userGroupMap;

    public TestUserGroupCallbackImpl() {
        userGroupMap = new HashMap<>();
        userGroupMap.put("maciej", singletonList("admins"));
        userGroupMap.put("tihomir", singletonList("supplier"));
        userGroupMap.put("kris", asList("admins", "managers"));
        userGroupMap.put("Administrator", singletonList("Administrators"));
        userGroupMap.put("salaboy", asList("managers","HR","IT","Accounting"));
        userGroupMap.put("katy", asList("HR","IT","Accounting", "admins"));
        userGroupMap.put("john", asList("HR","Accounting"));
        userGroupMap.put("mary", asList("HR", "Accounting"));
        userGroupMap.put("wbadmin", singletonList("Administrators"));
        userGroupMap.put("kieserver", singletonList("Administrators"));
    }

    @Override
    public void setUserGroups(String user, List<String> groups){
        userGroupMap.put(user, groups);
    }

    @Override
    public boolean existsUser(String user) {
        return userGroupMap.containsKey(user);
    }

    @Override
    public boolean existsGroup(String group) {
        for (String key : userGroupMap.keySet()) {
            if(userGroupMap.get(key).contains(group)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public List<String> getGroupsForUser(String user) {
        return userGroupMap.getOrDefault(user, emptyList());
    }
}
