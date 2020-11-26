/*
 * Copyright 2021 Red Hat, Inc. and/or its affiliates.
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

package org.jbpm.process.audit.support;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.jbpm.persistence.api.JbpmEntityContributor;
import org.jbpm.persistence.api.PersistenceEnvironmentName;
import org.jbpm.process.audit.NodeInstanceLog;
import org.jbpm.process.audit.ProcessInstanceLog;
import org.jbpm.process.audit.VariableInstanceLog;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AuditJbpmEntityContributor implements JbpmEntityContributor {

    private static final Logger log = LoggerFactory.getLogger(AuditJbpmEntityContributor.class);

    @Override
    public List<String> disableInsertChecks() {
        if(!PersistenceEnvironmentName.DISABLE_ENTITY_CHECKS) {
            return Collections.emptyList();
        }
        List<String> entities = Arrays.asList(
                ProcessInstanceLog.class.getCanonicalName(),
                NodeInstanceLog.class.getCanonicalName(),
                VariableInstanceLog.class.getCanonicalName());
        log.info("disabling row count check for entities {}", entities);
        return entities;
    }

}
