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
import java.util.ServiceLoader;

import javax.persistence.EntityManagerFactory;

import org.jbpm.runtime.manager.impl.jpa.EntityManagerFactoryManager;
import org.jbpm.services.api.AdvanceRuntimeDataService;
import org.jbpm.services.api.DefinitionService;
import org.jbpm.services.api.DeploymentService;
import org.jbpm.services.api.ProcessService;
import org.jbpm.services.api.RuntimeDataService;
import org.jbpm.services.api.UserTaskService;
import org.jbpm.services.api.admin.ProcessInstanceAdminService;
import org.jbpm.services.api.model.DeploymentUnit;
import org.jbpm.services.api.query.QueryService;
import org.jbpm.services.api.service.ServiceRegistry;
import org.jbpm.services.api.utils.KieServiceConfigurator;
import org.jbpm.services.task.HumanTaskServiceFactory;
import org.jbpm.services.task.audit.service.TaskJPAAuditService;
import org.junit.After;
import org.junit.Before;
import org.kie.api.runtime.manager.audit.AuditService;
import org.kie.internal.runtime.conf.DeploymentDescriptor;
import org.kie.internal.runtime.conf.DeploymentDescriptorBuilder;
import org.kie.internal.runtime.conf.NamedObjectModel;
import org.kie.internal.runtime.conf.ObjectModel;
import org.kie.internal.runtime.manager.deploy.DeploymentDescriptorImpl;
import org.kie.internal.task.api.InternalTaskService;

public abstract class AbstractKieServicesTest extends AbstractServicesTest {

    protected EntityManagerFactory emf;    
    protected DefinitionService bpmn2Service;
    protected RuntimeDataService runtimeDataService;
    protected ProcessService processService;
    protected UserTaskService userTaskService;
    protected QueryService queryService;
    protected InternalTaskService internalTaskService;
    protected ProcessInstanceAdminService processAdminService;
    protected AdvanceRuntimeDataService advanceVariableDataService;
    protected AuditService auditService;

    protected TestIdentityProvider identityProvider = new TestIdentityProviderImpl();
    protected TestUserGroupCallback userGroupCallback = new TestUserGroupCallbackImpl();

    protected KieServiceConfigurator serviceConfigurator;
    
    protected DeploymentUnit deploymentUnit;
    protected String puName = "org.jbpm.domain";

    public AbstractKieServicesTest() {
        loadServiceConfigurator();
    }

    protected AbstractKieServicesTest(TestIdentityProvider identityProvider, TestUserGroupCallback userGroupCallback) {
        this();
        if (identityProvider != null) {
            this.identityProvider = identityProvider;
        }
        if (userGroupCallback != null) {
            this.userGroupCallback = userGroupCallback;
        }
    }

    protected void loadServiceConfigurator() {
        this.serviceConfigurator = ServiceLoader.load(KieServiceConfigurator.class).iterator().next();
    }
    
    @Before
    public void setUp() throws Exception {
        setSystemProperties();
        prepareDocumentStorage();
        configureServices();
        deploymentUnit = prepareDeploymentUnit();
    }

    @After
    public void tearDown() {
        clearDocumentStorageProperty();
        if (identityProvider != null) {
            identityProvider.reset();      
        }
        clearSystemProperties();
        cleanupSingletonSessionId();

        if (deploymentUnit != null) {
            deploymentService.undeploy(deploymentUnit);
            deploymentUnit = null;
        }

        close();
        ServiceRegistry.get().clear();
    }

    protected void close() {
        if (serviceConfigurator != null) {
            serviceConfigurator.close();
        }
        EntityManagerFactoryManager.get().clear();
        closeDataSource();
    }

    protected void configureServices() {
        buildDatasource();

        serviceConfigurator.configureServices(puName, identityProvider, userGroupCallback);

        // build definition service
        bpmn2Service = serviceConfigurator.getBpmn2Service();

        queryService = serviceConfigurator.getQueryService();

        // build deployment service
        deploymentService = serviceConfigurator.getDeploymentService();

        // build runtime data service
        runtimeDataService = serviceConfigurator.getRuntimeDataService();

        // build process service
        processService = serviceConfigurator.getProcessService();

        // build user task service
        userTaskService = serviceConfigurator.getUserTaskService();
        
        // build process instance admin service
        processAdminService = serviceConfigurator.getProcessAdminService();
        
        advanceVariableDataService = serviceConfigurator.getAdvanceVariableDataService();

        if (emf == null) {
            emf = EntityManagerFactoryManager.get().getOrCreate(puName);
        }

        internalTaskService = (InternalTaskService)  HumanTaskServiceFactory.newTaskServiceConfigurator()
                .entityManagerFactory(emf)
                .getTaskService();

        auditService = new TaskJPAAuditService(emf);
    }

    @Override
    protected DeploymentUnit createDeploymentUnit(String groupId, String artifactid, String version) throws Exception {
        return serviceConfigurator.createDeploymentUnit(groupId, artifactid, version);
    }
    
    @Override
    protected DeploymentDescriptor createDeploymentDescriptor() {
        if (createDescriptor()) {
            DeploymentDescriptor customDescriptor = new DeploymentDescriptorImpl(puName);
            DeploymentDescriptorBuilder ddBuilder = customDescriptor.getBuilder();

            for (ObjectModel listener : getProcessListeners()) {
                ddBuilder.addEventListener(listener);
            }
            for (ObjectModel listener : getTaskListeners()) {
                ddBuilder.addTaskEventListener(listener);
            }
            for (NamedObjectModel listener : getWorkItemHandlers()) {
                ddBuilder.addWorkItemHandler(listener);
            }
            for (NamedObjectModel environmentEntry : getEnvironmentEntries()) {
                ddBuilder.addEnvironmentEntry(environmentEntry);
            }
            return customDescriptor;
        }
        return null;
    }

    protected boolean createDescriptor() {
        return false;
    }

    public void setDeploymentService(DeploymentService deploymentService) {
        this.deploymentService = deploymentService;
    }

    public void setBpmn2Service(DefinitionService bpmn2Service) {
        this.bpmn2Service = bpmn2Service;
    }

    public void setRuntimeDataService(RuntimeDataService runtimeDataService) {
        this.runtimeDataService = runtimeDataService;
    }

    public void setProcessService(ProcessService processService) {
        this.processService = processService;
    }

    public void setUserTaskService(UserTaskService userTaskService) {
        this.userTaskService = userTaskService;
    }

    public void setQueryService(QueryService queryService) {
        this.queryService = queryService;
    }

    public void setIdentityProvider(TestIdentityProvider identityProvider) {
        this.identityProvider = identityProvider;
    }

    public void setUserGroupCallback(TestUserGroupCallbackImpl userGroupCallback) {
        this.userGroupCallback = userGroupCallback;
    }

    public InternalTaskService getInternalTaskService() {
        return internalTaskService;
    }

    public void setInternalTaskService(InternalTaskService internalTaskService) {
        this.internalTaskService = internalTaskService;
    }

    public void setAuditService(AuditService auditService) {
        this.auditService = auditService;
    }

    protected abstract List<String> getProcessDefinitionFiles();

    protected void setPuName(String puName) {
        if (puName != null && !puName.equals("")) {
            this.puName = puName;
        }
    }

    protected void setSystemProperties() {
        System.setProperty("org.jbpm.ht.callback", "custom");
        System.setProperty("org.jbpm.ht.custom.callback", userGroupCallback.getClass().getCanonicalName());
    }

    protected void clearSystemProperties() {
        System.clearProperty("org.jbpm.ht.callback");
        System.clearProperty("org.jbpm.ht.custom.callback");
    }
}
