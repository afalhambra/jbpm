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

package org.jbpm.services.task;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.drools.core.impl.EnvironmentFactory;
import org.junit.After;
import org.junit.Before;
import org.kie.api.runtime.Environment;
import org.kie.api.runtime.EnvironmentName;
import org.kie.internal.task.api.InternalTaskService;
import org.kie.test.util.db.PoolingDataSourceWrapper;



public class LifeCycleLocalCommandBasedTest extends LifeCycleBaseTest {

	private PoolingDataSourceWrapper pds;
	private EntityManagerFactory emf;
	
    @Before
    public void setup() {
        this.testIdentityProvider = new TestIdentityProvider();
        pds = setupPoolingDataSource();
        emf = Persistence.createEntityManagerFactory("org.jbpm.services.task");

        Environment env = EnvironmentFactory.newEnvironment();
        env.set(EnvironmentName.IDENTITY_PROVIDER, this.testIdentityProvider);

        this.taskService = (InternalTaskService) HumanTaskServiceFactory.newTaskServiceConfigurator()
                                                                        .environment(env)
                                                                        .entityManagerFactory(emf)
                                                                        .getTaskService();

    }

	@After
	public void clean() {
    	super.tearDown();
		if (emf != null) {
			emf.close();
			emf = null;
		}
		if (pds != null) {
			pds.close();
			pds = null;
		}
	}
}
