create sequence ATTACHMENT_ID_SEQ start with 1 increment by  1;
create sequence AUDIT_ID_SEQ start with 1 increment by  1;
create sequence BAM_TASK_ID_SEQ start with 1 increment by  50;
create sequence BOOLEANEXPR_ID_SEQ start with 1 increment by  1;
create sequence CASE_FILE_DATA_LOG_ID_SEQ start with 1 increment by  1;
create sequence CASE_ID_INFO_ID_SEQ start with 1 increment by  50;
create sequence CASE_ROLE_ASSIGN_LOG_ID_SEQ start with 1 increment by  1;
create sequence COMMENT_ID_SEQ start with 1 increment by  1;
create sequence CONTENT_ID_SEQ start with 1 increment by  1;
create sequence CONTEXT_MAPPING_INFO_ID_SEQ start with 1 increment by  50;
create sequence CORRELATION_KEY_ID_SEQ start with 1 increment by  50;
create sequence CORRELATION_PROP_ID_SEQ start with 1 increment by  50;
create sequence DEADLINE_ID_SEQ start with 1 increment by  1;
create sequence DEPLOY_STORE_ID_SEQ start with 1 increment by  1;
create sequence EMAILNOTIFHEAD_ID_SEQ start with 1 increment by  1;
create sequence ERROR_INFO_ID_SEQ start with 1 increment by  50;
create sequence ESCALATION_ID_SEQ start with 1 increment by  1;
create sequence EXEC_ERROR_INFO_ID_SEQ start with 1 increment by  1;
create sequence I18NTEXT_ID_SEQ start with 1 increment by  1;
create sequence NODE_INST_LOG_ID_SEQ start with 1 increment by  1;
create sequence NOTIFICATION_ID_SEQ start with 1 increment by  1;
create sequence PROC_INST_LOG_ID_SEQ start with 1 increment by  1;
create sequence PROCESS_INSTANCE_INFO_ID_SEQ start with 1 increment by  50;
create sequence QUERY_DEF_ID_SEQ start with 1 increment by  1;
create sequence REASSIGNMENT_ID_SEQ start with 1 increment by  1;
create sequence REQUEST_INFO_ID_SEQ start with 1 increment by  50;
create sequence SESSIONINFO_ID_SEQ start with 1 increment by  50;
create sequence TASK_DEF_ID_SEQ start with 1 increment by  50;
create sequence TASK_EVENT_ID_SEQ start with 1 increment by  50;
create sequence TASK_ID_SEQ start with 1 increment by  1;
create sequence TASK_VAR_ID_SEQ start with 1 increment by  1;
create sequence VAR_INST_LOG_ID_SEQ start with 1 increment by  1;
create sequence WORKITEMINFO_ID_SEQ start with 1 increment by  50;
create table Attachment (id number(19,0) not null, accessType number(10,0), attachedAt timestamp, attachmentContentId number(19,0) not null, contentType varchar2(255 char), name varchar2(255 char), attachment_size number(10,0), attachedBy_id varchar2(255 char), TaskData_Attachments_Id number(19,0), primary key (id));
create table AuditTaskImpl (id number(19,0) not null, activationTime timestamp, actualOwner varchar2(255 char), createdBy varchar2(255 char), createdOn timestamp, deploymentId varchar2(255 char), description varchar2(255 char), dueDate timestamp, lastModificationDate timestamp, name varchar2(255 char), parentId number(19,0) not null, priority number(10,0) not null, processId varchar2(255 char), processInstanceId number(19,0) not null, processSessionId number(19,0) not null, status varchar2(255 char), taskId number(19,0), workItemId number(19,0), end_date timestamp, primary key (id));
create table BAMTaskSummary (pk number(19,0) not null, createdDate timestamp, duration number(19,0), end_date timestamp, endDate timestamp, processInstanceId number(19,0) not null, startDate timestamp, status varchar2(255 char), taskId number(19,0) not null, taskName varchar2(255 char), userId varchar2(255 char), OPTLOCK number(10,0), primary key (pk));
create table BooleanExpression (id number(19,0) not null, expression clob, type varchar2(255 char), Escalation_Constraints_Id number(19,0), primary key (id));
create table CaseFileDataLog (id number(19,0) not null, caseDefId varchar2(255 char), caseId varchar2(255 char), itemName varchar2(255 char), itemType varchar2(255 char), itemValue varchar2(255 char), lastModified timestamp, lastModifiedBy varchar2(255 char), primary key (id));
create table CaseIdInfo (id number(19,0) not null, caseIdPrefix varchar2(255 char), currentValue number(19,0), primary key (id));
create table CaseRoleAssignmentLog (id number(19,0) not null, caseId varchar2(255 char), entityId varchar2(255 char), processInstanceId number(19,0) not null, roleName varchar2(255 char), type number(10,0) not null, primary key (id));
create table Content (id number(19,0) not null, content blob, primary key (id));
create table ContextMappingInfo (mappingId number(19,0) not null, CONTEXT_ID varchar2(255 char) not null, KSESSION_ID number(19,0) not null, OWNER_ID varchar2(255 char), OPTLOCK number(10,0), primary key (mappingId));
create table CorrelationKeyInfo (keyId number(19,0) not null, name varchar2(255 char), processInstanceId number(19,0) not null, OPTLOCK number(10,0), primary key (keyId));
create table CorrelationPropertyInfo (propertyId number(19,0) not null, name varchar2(255 char), value varchar2(255 char), OPTLOCK number(10,0), correlationKey_keyId number(19,0), primary key (propertyId));
create table Deadline (id number(19,0) not null, deadline_date timestamp, escalated number(5,0), Deadlines_StartDeadLine_Id number(19,0), Deadlines_EndDeadLine_Id number(19,0), primary key (id));
create table Delegation_delegates (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table DeploymentStore (id number(19,0) not null, attributes varchar2(255 char), DEPLOYMENT_ID varchar2(255 char), deploymentUnit clob, state number(10,0), updateDate timestamp, primary key (id));
create table email_header (id number(19,0) not null, body clob, fromAddress varchar2(255 char), language varchar2(255 char), replyToAddress varchar2(255 char), subject varchar2(255 char), primary key (id));
create table ErrorInfo (id number(19,0) not null, message varchar2(255 char), stacktrace long, timestamp timestamp, REQUEST_ID number(19,0) not null, primary key (id));
create table Escalation (id number(19,0) not null, name varchar2(255 char), Deadline_Escalation_Id number(19,0), primary key (id));
create table EventTypes (InstanceId number(19,0) not null, element varchar2(255 char));
create table ExecutionErrorInfo (id number(19,0) not null, ERROR_ACK number(5,0), ERROR_ACK_AT timestamp, ERROR_ACK_BY varchar2(255 char), ACTIVITY_ID number(19,0), ACTIVITY_NAME varchar2(255 char), DEPLOYMENT_ID varchar2(255 char), ERROR_INFO clob, ERROR_DATE timestamp, ERROR_ID varchar2(255 char), ERROR_MSG varchar2(255 char), INIT_ACTIVITY_ID number(19,0), JOB_ID number(19,0), PROCESS_ID varchar2(255 char), PROCESS_INST_ID number(19,0), ERROR_TYPE varchar2(255 char), primary key (id));
create table I18NText (id number(19,0) not null, language varchar2(255 char), shortText varchar2(255 char), text clob, Task_Subjects_Id number(19,0), Task_Names_Id number(19,0), Task_Descriptions_Id number(19,0), Reassignment_Documentation_Id number(19,0), Notification_Subjects_Id number(19,0), Notification_Names_Id number(19,0), Notification_Documentation_Id number(19,0), Notification_Descriptions_Id number(19,0), Deadline_Documentation_Id number(19,0), primary key (id));
create table NodeInstanceLog (id number(19,0) not null, connection varchar2(255 char), log_date timestamp, end_date timestamp, externalId varchar2(255 char), nodeContainerId varchar2(255 char), nodeId varchar2(255 char), nodeInstanceId varchar2(255 char), nodeName varchar2(255 char), nodeType varchar2(255 char), processId varchar2(255 char), processInstanceId number(19,0) not null, referenceId number(19,0), slaCompliance number(10,0), sla_due_date timestamp, type number(10,0) not null, workItemId number(19,0), primary key (id));
create table Notification (DTYPE varchar2(31 char) not null, id number(19,0) not null, priority number(10,0) not null, Escalation_Notifications_Id number(19,0), primary key (id));
create table Notification_BAs (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table Notification_email_header (Notification_id number(19,0) not null, emailHeaders_id number(19,0) not null, mapkey varchar2(255 char) not null, primary key (Notification_id, mapkey));
create table Notification_Recipients (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table OrganizationalEntity (DTYPE varchar2(31 char) not null, id varchar2(255 char) not null, primary key (id));
create table PeopleAssignments_BAs (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table PeopleAssignments_ExclOwners (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table PeopleAssignments_PotOwners (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table PeopleAssignments_Recipients (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table PeopleAssignments_Stakeholders (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table ProcessInstanceInfo (InstanceId number(19,0) not null, lastModificationDate timestamp, lastReadDate timestamp, processId varchar2(255 char), processInstanceByteArray blob, startDate timestamp, state number(10,0) not null, OPTLOCK number(10,0), primary key (InstanceId));
create table ProcessInstanceLog (id number(19,0) not null, correlationKey varchar2(255 char), duration number(19,0), end_date timestamp, externalId varchar2(255 char), user_identity varchar2(255 char), outcome varchar2(255 char), parentProcessInstanceId number(19,0), processId varchar2(255 char), processInstanceDescription varchar2(255 char), processInstanceId number(19,0) not null, processName varchar2(255 char), processType number(10,0), processVersion varchar2(255 char), slaCompliance number(10,0), sla_due_date timestamp, start_date timestamp, status number(10,0), primary key (id));
create table QueryDefinitionStore (id number(19,0) not null, qExpression clob, qName varchar2(255 char), qSource varchar2(255 char), qTarget varchar2(255 char), primary key (id));
create table Reassignment (id number(19,0) not null, Escalation_Reassignments_Id number(19,0), primary key (id));
create table Reassignment_potentialOwners (task_id number(19,0) not null, entity_id varchar2(255 char) not null);
create table RequestInfo (id number(19,0) not null, commandName varchar2(255 char), deploymentId varchar2(255 char), executions number(10,0) not null, businessKey varchar2(255 char), message varchar2(255 char), owner varchar2(255 char), priority number(10,0) not null, processInstanceId number(19,0), requestData blob, responseData blob, retries number(10,0) not null, status varchar2(255 char), timestamp timestamp, primary key (id));
create table SessionInfo (id number(19,0) not null, lastModificationDate timestamp, rulesByteArray blob, startDate timestamp, OPTLOCK number(10,0), primary key (id));
create table Task (id number(19,0) not null, archived number(5,0), allowedToDelegate varchar2(255 char), description varchar2(255 char), formName varchar2(255 char), name varchar2(255 char), priority number(10,0) not null, subTaskStrategy varchar2(255 char), subject varchar2(255 char), activationTime timestamp, createdOn timestamp, deploymentId varchar2(255 char), documentAccessType number(10,0), documentContentId number(19,0) not null, documentType varchar2(255 char), expirationTime timestamp, faultAccessType number(10,0), faultContentId number(19,0) not null, faultName varchar2(255 char), faultType varchar2(255 char), outputAccessType number(10,0), outputContentId number(19,0) not null, outputType varchar2(255 char), parentId number(19,0) not null, previousStatus number(10,0), processId varchar2(255 char), processInstanceId number(19,0) not null, processSessionId number(19,0) not null, skipable number(1,0) not null, status varchar2(255 char), workItemId number(19,0) not null, taskType varchar2(255 char), OPTLOCK number(10,0), taskInitiator_id varchar2(255 char), actualOwner_id varchar2(255 char), createdBy_id varchar2(255 char), primary key (id));
create table task_comment (id number(19,0) not null, addedAt timestamp, text clob, addedBy_id varchar2(255 char), TaskData_Comments_Id number(19,0), primary key (id));
create table TaskDef (id number(19,0) not null, name varchar2(255 char), priority number(10,0) not null, primary key (id));
create table TaskEvent (id number(19,0) not null, correlationKey varchar2(255 char), end_date timestamp, logTime timestamp, message varchar2(255 char), processInstanceId number(19,0), processType number(10,0), taskId number(19,0), type varchar2(255 char), userId varchar2(255 char), OPTLOCK number(10,0), workItemId number(19,0), primary key (id));
create table TaskVariableImpl (id number(19,0) not null, modificationDate timestamp, name varchar2(255 char), processId varchar2(255 char), processInstanceId number(19,0), taskId number(19,0), type number(10,0), value varchar2(4000 char), primary key (id));
create table VariableInstanceLog (id number(19,0) not null, log_date timestamp, end_date timestamp, externalId varchar2(255 char), oldValue varchar2(255 char), processId varchar2(255 char), processInstanceId number(19,0) not null, value varchar2(255 char), variableId varchar2(255 char), variableInstanceId varchar2(255 char), primary key (id));
create table WorkItemInfo (workItemId number(19,0) not null, creationDate timestamp, name varchar2(255 char), processInstanceId number(19,0) not null, state number(19,0) not null, OPTLOCK number(10,0), workItemByteArray blob, primary key (workItemId));
create index IDX_Attachment_Id on Attachment (attachedBy_id);
create index IDX_Attachment_DataId on Attachment (TaskData_Attachments_Id);
create index IDX_AuditTaskImpl_taskId on AuditTaskImpl (taskId);
create index IDX_AuditTaskImpl_pInstId on AuditTaskImpl (processInstanceId);
create index IDX_AuditTaskImpl_workItemId on AuditTaskImpl (workItemId);
create index IDX_AuditTaskImpl_name on AuditTaskImpl (name);
create index IDX_AuditTaskImpl_processId on AuditTaskImpl (processId);
create index IDX_AuditTaskImpl_status on AuditTaskImpl (status);
create index IDX_BAMTaskSumm_createdDate on BAMTaskSummary (createdDate);
create index IDX_BAMTaskSumm_duration on BAMTaskSummary (duration);
create index IDX_BAMTaskSumm_endDate on BAMTaskSummary (endDate);
create index IDX_BAMTaskSumm_pInstId on BAMTaskSummary (processInstanceId);
create index IDX_BAMTaskSumm_startDate on BAMTaskSummary (startDate);
create index IDX_BAMTaskSumm_status on BAMTaskSummary (status);
create index IDX_BAMTaskSumm_taskId on BAMTaskSummary (taskId);
create index IDX_BAMTaskSumm_taskName on BAMTaskSummary (taskName);
create index IDX_BAMTaskSumm_userId on BAMTaskSummary (userId);
create index IDX_BoolExpr_Id on BooleanExpression (Escalation_Constraints_Id);
alter table CaseIdInfo add constraint UKftvt225gyxpjnl3d06alqkqyj unique (caseIdPrefix);
create index IDX_CMI_Context on ContextMappingInfo (CONTEXT_ID);
create index IDX_CMI_KSession on ContextMappingInfo (KSESSION_ID);
create index IDX_CMI_Owner on ContextMappingInfo (OWNER_ID);
alter table CorrelationKeyInfo add constraint IDX_CorrelationKeyInfo_name unique (name);
create index IDX_CorrPropInfo_Id on CorrelationPropertyInfo (correlationKey_keyId);
create index IDX_Deadline_StartId on Deadline (Deadlines_StartDeadLine_Id);
create index IDX_Deadline_EndId on Deadline (Deadlines_EndDeadLine_Id);
create index IDX_Delegation_EntityId on Delegation_delegates (entity_id);
create index IDX_Delegation_TaskId on Delegation_delegates (task_id);
alter table DeploymentStore add constraint UK85rgskt09thd8mkkfl3tb0y81 unique (DEPLOYMENT_ID);
create index IDX_ErrorInfo_Id on ErrorInfo (REQUEST_ID);
create index IDX_Escalation_Id on Escalation (Deadline_Escalation_Id);
create index IDX_EventTypes_Id on EventTypes (InstanceId);
create index IDX_EventTypes_element on EventTypes (element);
create index IDX_ErrorInfo_pInstId on ExecutionErrorInfo (PROCESS_INST_ID);
create index IDX_ErrorInfo_errorAck on ExecutionErrorInfo (ERROR_ACK);
create index IDX_I18NText_SubjId on I18NText (Task_Subjects_Id);
create index IDX_I18NText_NameId on I18NText (Task_Names_Id);
create index IDX_I18NText_DescrId on I18NText (Task_Descriptions_Id);
create index IDX_I18NText_ReassignId on I18NText (Reassignment_Documentation_Id);
create index IDX_I18NText_NotSubjId on I18NText (Notification_Subjects_Id);
create index IDX_I18NText_NotNamId on I18NText (Notification_Names_Id);
create index IDX_I18NText_NotDocId on I18NText (Notification_Documentation_Id);
create index IDX_I18NText_NotDescrId on I18NText (Notification_Descriptions_Id);
create index IDX_I18NText_DeadDocId on I18NText (Deadline_Documentation_Id);
create index IDX_NInstLog_pInstId on NodeInstanceLog (processInstanceId);
create index IDX_NInstLog_nodeType on NodeInstanceLog (nodeType);
create index IDX_NInstLog_pId on NodeInstanceLog (processId);
create index IDX_NInstLog_workItemId on NodeInstanceLog (workItemId);
create index IDX_Not_EscId on Notification (Escalation_Notifications_Id);
create index IDX_NotBAs_Entity on Notification_BAs (entity_id);
create index IDX_NotBAs_Task on Notification_BAs (task_id);
alter table Notification_email_header add constraint UK_ptaka5kost68h7l3wflv7w6y8 unique (emailHeaders_id);
create index IDX_NotRec_Entity on Notification_Recipients (entity_id);
create index IDX_NotRec_Task on Notification_Recipients (task_id);
create index IDX_PAsBAs_Entity on PeopleAssignments_BAs (entity_id);
create index IDX_PAsBAs_Task on PeopleAssignments_BAs (task_id);
create index IDX_PAsExcl_Entity on PeopleAssignments_ExclOwners (entity_id);
create index IDX_PAsExcl_Task on PeopleAssignments_ExclOwners (task_id);
create index IDX_PAsPot_TaskEntity on PeopleAssignments_PotOwners (task_id, entity_id);
create index IDX_PAsRecip_Entity on PeopleAssignments_Recipients (entity_id);
create index IDX_PAsRecip_Task on PeopleAssignments_Recipients (task_id);
create index IDX_PAsStake_Entity on PeopleAssignments_Stakeholders (entity_id);
create index IDX_PAsStake_Task on PeopleAssignments_Stakeholders (task_id);
create index IDX_PInstLog_duration on ProcessInstanceLog (duration);
create index IDX_PInstLog_end_date on ProcessInstanceLog (end_date);
create index IDX_PInstLog_extId on ProcessInstanceLog (externalId);
create index IDX_PInstLog_user_identity on ProcessInstanceLog (user_identity);
create index IDX_PInstLog_outcome on ProcessInstanceLog (outcome);
create index IDX_PInstLog_parentPInstId on ProcessInstanceLog (parentProcessInstanceId);
create index IDX_PInstLog_pId on ProcessInstanceLog (processId);
create index IDX_PInstLog_pInsteDescr on ProcessInstanceLog (processInstanceDescription);
create index IDX_PInstLog_pInstId on ProcessInstanceLog (processInstanceId);
create index IDX_PInstLog_pName on ProcessInstanceLog (processName);
create index IDX_PInstLog_pVersion on ProcessInstanceLog (processVersion);
create index IDX_PInstLog_start_date on ProcessInstanceLog (start_date);
create index IDX_PInstLog_status on ProcessInstanceLog (status);
create index IDX_PInstLog_correlation on ProcessInstanceLog (correlationKey);
alter table QueryDefinitionStore add constraint UK1dmy087nhbykucpgjipcnyluv unique (qName);
create index IDX_Reassign_Esc on Reassignment (Escalation_Reassignments_Id);
create index IDX_ReassignPO_Entity on Reassignment_potentialOwners (entity_id);
create index IDX_ReassignPO_Task on Reassignment_potentialOwners (task_id);
create index IDX_RequestInfo_status on RequestInfo (status);
create index IDX_RequestInfo_owner on RequestInfo (owner);
create index IDX_Task_Initiator on Task (taskInitiator_id);
create index IDX_Task_ActualOwner on Task (actualOwner_id);
create index IDX_Task_CreatedBy on Task (createdBy_id);
create index IDX_Task_processInstanceId on Task (processInstanceId);
create index IDX_Task_processId on Task (processId);
create index IDX_Task_status on Task (status);
create index IDX_Task_archived on Task (archived);
create index IDX_Task_workItemId on Task (workItemId);
create index IDX_TaskComments_CreatedBy on task_comment (addedBy_id);
create index IDX_TaskComments_Id on task_comment (TaskData_Comments_Id);
create index IDX_TaskEvent_taskId on TaskEvent (taskId);
create index IDX_TaskVariableImpl_taskId on TaskVariableImpl (taskId);
create index IDX_TaskVariableImpl_pInstId on TaskVariableImpl (processInstanceId);
create index IDX_TaskVariableImpl_processId on TaskVariableImpl (processId);
create index IDX_VInstLog_pInstId on VariableInstanceLog (processInstanceId);
create index IDX_VInstLog_varId on VariableInstanceLog (variableId);
create index IDX_VInstLog_pId on VariableInstanceLog (processId);
alter table Attachment add constraint FKd5xpm81gxg8n40167lbu5rbfb foreign key (attachedBy_id) references OrganizationalEntity;
alter table Attachment add constraint FKjj9psk52ifamilliyo16epwpc foreign key (TaskData_Attachments_Id) references Task;
alter table BooleanExpression add constraint FKqth56a8k6d8pv6ngsu2vjp4kj foreign key (Escalation_Constraints_Id) references Escalation;
alter table CorrelationPropertyInfo add constraint FKbchyl7kb8i6ghvi3dbr86bgo0 foreign key (correlationKey_keyId) references CorrelationKeyInfo;
alter table Deadline add constraint FK361ggw230po88svgfasg36i2w foreign key (Deadlines_StartDeadLine_Id) references Task;
alter table Deadline add constraint FKpeiadnoy228t35213t63c3imm foreign key (Deadlines_EndDeadLine_Id) references Task;
alter table Delegation_delegates add constraint FKewkdyi0wrgy9byp6abyglpcxq foreign key (entity_id) references OrganizationalEntity;
alter table Delegation_delegates add constraint FK85x3trafk3wfbrv719cafr591 foreign key (task_id) references Task;
alter table ErrorInfo add constraint FKdarp6ushq06q39jmij3fdpdbs foreign key (REQUEST_ID) references RequestInfo;
alter table Escalation add constraint FK37v8ova8ti6jiblda7n6j298e foreign key (Deadline_Escalation_Id) references Deadline;
alter table EventTypes add constraint FKj0o3uve2nqo5yrjwrkc9jfttq foreign key (InstanceId) references ProcessInstanceInfo;
alter table I18NText add constraint FKcd6eb4q62d9ab8p0di8pb99ch foreign key (Task_Subjects_Id) references Task;
alter table I18NText add constraint FKiogka67sji8fk4cp7a369895i foreign key (Task_Names_Id) references Task;
alter table I18NText add constraint FKrisdlmalotmk64mdeqpo4s5m0 foreign key (Task_Descriptions_Id) references Task;
alter table I18NText add constraint FKqxgws3fnukyqlaet11tivqg5u foreign key (Reassignment_Documentation_Id) references Reassignment;
alter table I18NText add constraint FKthf8ix3t3opf9hya1s04hwsx8 foreign key (Notification_Subjects_Id) references Notification;
alter table I18NText add constraint FKg2jsybeuc8pbj8ek8xwxutuyo foreign key (Notification_Names_Id) references Notification;
alter table I18NText add constraint FKp0m7uhipskrljktvfeubdgfid foreign key (Notification_Documentation_Id) references Notification;
alter table I18NText add constraint FK6k8hmfvhko069970eghiy2ifp foreign key (Notification_Descriptions_Id) references Notification;
alter table I18NText add constraint FK8wn7sw34q6bifsi1pvl2b1yyb foreign key (Deadline_Documentation_Id) references Deadline;
alter table Notification add constraint FKoxq5uqfg4ylwyijsg2ubyflna foreign key (Escalation_Notifications_Id) references Escalation;
alter table Notification_BAs add constraint FK378pb1cvjv54w4ljqpw99s3wr foreign key (entity_id) references OrganizationalEntity;
alter table Notification_BAs add constraint FKb123fgeomc741s9yc014421yy foreign key (task_id) references Notification;
alter table Notification_email_header add constraint FKd74pdu41avy2f7a8qyp7wn2n foreign key (emailHeaders_id) references email_header;
alter table Notification_email_header add constraint FKfdnoyp8rl0kxu29l4pyaa5566 foreign key (Notification_id) references Notification;
alter table Notification_Recipients add constraint FKot769nimyq1jvw0m61pgsq5g3 foreign key (entity_id) references OrganizationalEntity;
alter table Notification_Recipients add constraint FKn7v944d0hw37bh0auv4gr3hsf foreign key (task_id) references Notification;
alter table PeopleAssignments_BAs add constraint FKa90cdfgc4km384n1ataqigq67 foreign key (entity_id) references OrganizationalEntity;
alter table PeopleAssignments_BAs add constraint FKt4xs0glwhbsa0xwg69r6xduv9 foreign key (task_id) references Task;
alter table PeopleAssignments_ExclOwners add constraint FK5ituvd6t8uvp63hsx6282xo6h foreign key (entity_id) references OrganizationalEntity;
alter table PeopleAssignments_ExclOwners add constraint FKqxbjm1b3dl7w8w2f2y6sk0fv8 foreign key (task_id) references Task;
alter table PeopleAssignments_PotOwners add constraint FKsa3rrrjsm1qw98ajbbu2s7cjr foreign key (entity_id) references OrganizationalEntity;
alter table PeopleAssignments_PotOwners add constraint FKh8oqmk4iuh2pmpgby6g8r3jd1 foreign key (task_id) references Task;
alter table PeopleAssignments_Recipients add constraint FKrd0h9ud1bhs9waf2mdmiv6j2r foreign key (entity_id) references OrganizationalEntity;
alter table PeopleAssignments_Recipients add constraint FK9gnbv6bplxkxoedj35vg8n7ir foreign key (task_id) references Task;
alter table PeopleAssignments_Stakeholders add constraint FK9uy76cu650rg1nnkrtjwj1e9t foreign key (entity_id) references OrganizationalEntity;
alter table PeopleAssignments_Stakeholders add constraint FKaeyk4nwslvx0jywjomjq7083i foreign key (task_id) references Task;
alter table Reassignment add constraint FKessy30safh44b30f1cfoujv2k foreign key (Escalation_Reassignments_Id) references Escalation;
alter table Reassignment_potentialOwners add constraint FKsqrmpvehlc4qe9i0km22nmkjl foreign key (entity_id) references OrganizationalEntity;
alter table Reassignment_potentialOwners add constraint FKftegfexshix752bh2jfxf6bnh foreign key (task_id) references Reassignment;
alter table Task add constraint FK48d1bfgwf0jqow1yk8ku4xcpi foreign key (taskInitiator_id) references OrganizationalEntity;
alter table Task add constraint FKpmkxvqq63aed2y2boruu53a0s foreign key (actualOwner_id) references OrganizationalEntity;
alter table Task add constraint FKexuboqnbla7jfyyesyo61ucmb foreign key (createdBy_id) references OrganizationalEntity;
alter table task_comment add constraint FKqb4mkarf209y9546w7n75lb7a foreign key (addedBy_id) references OrganizationalEntity;
alter table task_comment add constraint FKm2mwc1ukcpdsiqwgkoroy6ise foreign key (TaskData_Comments_Id) references Task;