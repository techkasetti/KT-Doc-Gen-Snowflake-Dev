-- Consolidated and formatted CREATE OR REPLACE TABLE statements
-- Style: readable Snowflake style (one column per line, indented)


CREATE OR REPLACE TABLE ADMIN.ACCOUNTS (
    ACCOUNT_ID STRING PRIMARY KEY,
    account_name STRING,
    admin_contact_email STRING,
    integration_key_hash VARIANT,
    integration_status STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AIFEATUREHUB.activation_audit (
    audit_id STRING PRIMARY KEY,
    admin_user STRING,
    feature_key STRING,
    action STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.agent_plans (
    plan_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    agent_name STRING,
    plan_steps VARIANT,
    conclusion VARIANT,
    confidence FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.ai_processing_log (
    process_id STRING PRIMARY KEY,
    org_id STRING,
    instance_ref STRING,
    feature_key STRING,
    task_name STRING,
    latency_ms FLOAT,
    status STRING,
    details VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.alerts (
    alert_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    instance_ref STRING,
    alert_type STRING,
    severity STRING,
    status STRING DEFAULT 'OPEN',
    -- OPEN,
    ACKED,
    RESOLVED payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    acknowledged_by STRING,
    acknowledged_at TIMESTAMP_LTZ,
    resolved_by STRING,
    resolved_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.ALERT_CONFIG (
    config_id STRING PRIMARY KEY,
    org_id STRING,
    alert_key STRING,
    query_text STRING,
    severity STRING,
    enabled BOOLEAN DEFAULT TRUE,
    evaluation_interval_seconds INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.alert_history (
    history_id STRING PRIMARY KEY,
    alert_id STRING,
    fired_at TIMESTAMP_LTZ,
    cleared_at TIMESTAMP_LTZ,
    details VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.annotated_clauses (
    clause_id STRING PRIMARY KEY,
    org_id STRING,
    title STRING,
    body STRING,
    risk_level STRING,
    jurisdictions ARRAY,
    tags ARRAY,
    version INT,
    provenance VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.ann_autoscale_actions (
    action_id STRING PRIMARY KEY,
    container_name STRING,
    recommended_action STRING,
    recommended_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    approved BOOLEAN DEFAULT FALSE,
    approved_by STRING,
    approved_at TIMESTAMP_LTZ,
    notes VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.ann_build_jobs (
    job_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    job_type STRING,
    status STRING DEFAULT 'QUEUED',
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.ann_build_logs (
    build_log_id STRING PRIMARY KEY,
    job_id STRING,
    index_id STRING,
    org_id STRING,
    shards_processed INT,
    duration_sec FLOAT,
    error_message STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.ann_healthcheck_history (
    hc_id STRING PRIMARY KEY,
    index_snapshot_id STRING,
    qps FLOAT,
    p50_latency_ms FLOAT,
    p95_latency_ms FLOAT,
    correctness_sample_score FLOAT,
    checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    notes VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.ann_index_metadata (
    index_id STRING PRIMARY KEY,
    org_id STRING,
    engine STRING,
    metric STRING,
    dims INT,
    shard_count INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , properties VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.ann_index_shards (
    shard_id STRING PRIMARY KEY,
    index_id STRING,
    shard_path STRING,
    host_hint STRING,
    size_bytes NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , shard_metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.ann_rate_limits (
    org_id STRING PRIMARY KEY,
    max_qps FLOAT,
    max_concurrency INT,
    burst_capacity INT,
    last_updated TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    notes VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.API_AUDIT (
    audit_id STRING PRIMARY KEY,
    org_id STRING,
    api_name STRING,
    endpoint STRING,
    caller_id STRING,
    request_payload VARIANT,
    response_payload VARIANT,
    status_code INT,
    latency_ms FLOAT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.api_keys (
    key_id STRING PRIMARY KEY,
    org_id STRING,
    key_hash STRING,
    scopes ARRAY,
    description STRING,
    status STRING DEFAULT 'ACTIVE',
    -- ACTIVE,
    REVOKED created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    revoked_at TIMESTAMP_LTZ,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.archival_policy_rules (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    retention_days INT,
    archive_frequency STRING,
    -- e.g.,
    'DAILY',
    'WEEKLY' apply_to VARIANT,
    -- predicate or scope created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    notes STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.ARCHIVE_JOBS (
    job_id STRING PRIMARY KEY,
    policy_id STRING,
    org_id STRING,
    status STRING DEFAULT 'QUEUED',
    scheduled_at TIMESTAMP_LTZ,
    executed_at TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.audit_log (
    log_id STRING PRIMARY KEY,
    object_name STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.BILLING_AUDIT (
    AUDIT_ID STRING PRIMARY KEY,
    BILLING_RUN_ID STRING,
    ACTION STRING,
    ACTOR STRING,
    DETAILS VARIANT,
    OCCURRED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.billing_line_item (
    line_item_id STRING PRIMARY KEY,
    billing_run_id STRING,
    invoice_id STRING,
    org_id STRING,
    description STRING,
    amount_due NUMBER,
    units NUMBER,
    unit_price NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.billing_reconciliation_runs (
    run_id STRING PRIMARY KEY,
    invoice_id STRING,
    reconciled BOOLEAN DEFAULT FALSE,
    discrepancy VARIANT,
    run_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.billing_run (
    billing_run_id STRING PRIMARY KEY,
    run_type STRING,
    -- PREVIEW / FINAL initiated_by STRING,
    initiated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    completed_at TIMESTAMP_LTZ,
    status STRING,
    run_meta VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.clause_blocks (
    block_id STRING PRIMARY KEY,
    document_id STRING,
    org_id STRING,
    block_text STRING,
    block_order INT,
    length_tokens INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.clause_citation_links (
    link_id STRING PRIMARY KEY,
    clause_id STRING,
    source_doc_id STRING,
    source_section_id STRING,
    confidence FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.compliance_packet_schema (
    schema_id STRING PRIMARY KEY,
    org_id STRING,
    packet_type STRING,
    schema_definition VARIANT,
    version STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.CONSOLIDATED_BUNDLE_HASH (
    bundle_id STRING PRIMARY KEY,
    org_id STRING,
    bundle_hash STRING,
    source_ref STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.cost_budgets (
    budget_id STRING PRIMARY KEY,
    org_id STRING,
    budget_name STRING,
    period_start DATE,
    period_end DATE,
    budget_amount NUMBER,
    notifications ARRAY,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.data_quality_log (
    dq_check_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    check_name STRING,
    check_result STRING,
    -- PASS / FAIL / WARN details VARIANT,
    run_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    run_by STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.deployment_prereq_checks (
    check_id STRING PRIMARY KEY,
    check_name STRING,
    passed BOOLEAN,
    details VARIANT,
    checked_by STRING,
    checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4201featureinstanceservicetokens (
    tokenid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    tokenref STRING,
    issuedto STRING,
    scopes ARRAY,
    expiresat TIMESTAMPLTZ,
    issuedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4205featureinstancescheduledhealthchecks ( scheduleid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, checkid STRING, nextrunat TIMESTAMPLTZ, cadenceseconds INT, enabled BOOLEAN DEFAULT TRUE, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4207featureinstancehealthcheckbackofflogs ( backoffid STRING PRIMARY KEY, checkid STRING, instanceref STRING, featurekey STRING, orgid STRING, consecutivefailures INT, backoffuntil TIMESTAMPLTZ, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4209featureinstancealertsuppressionrules ( ruleid STRING PRIMARY KEY, featurekey STRING, instanceref STRING, orgid STRING, alerttypes ARRAY, suppressedfrom TIMESTAMPLTZ, suppressedto TIMESTAMPLTZ, reason VARIANT, createdby STRING, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4213featureinstancecostreallocationrequests ( requestid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, requestedby STRING, fromcostcenter STRING, tocostcenter STRING, amount NUMBER, reason VARIANT, status STRING DEFAULT 'PENDING', requestedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(), processedat TIMESTAMPLTZ ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4215featureinstancecostreallocationaudit ( auditid STRING PRIMARY KEY, requestid STRING, instanceref STRING, featurekey STRING, orgid STRING, processedby STRING, action STRING, notes VARIANT, actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4219featureinstancecustomerattachmentretention ( policyid STRING PRIMARY KEY, featurekey STRING, instanceref STRING, orgid STRING, retentiondays INT, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4221featureinstancecustomerattachmentpurgejobs ( jobid STRING PRIMARY KEY, policyid STRING, instanceref STRING, featurekey STRING, orgid STRING, scheduledat TIMESTAMPLTZ, status STRING DEFAULT 'QUEUED', executedat TIMESTAMPLTZ, result VARIANT ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4227featureinstancecustomercommsdispatchqueue ( dispatchid STRING PRIMARY KEY, templateid STRING, instanceref STRING, featurekey STRING, orgid STRING, recipients ARRAY, scheduledat TIMESTAMPLTZ, status STRING DEFAULT 'QUEUED', attempts INT DEFAULT 0, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4229featureinstancecustomercommsdeliverylog ( deliveryid STRING PRIMARY KEY, dispatchid STRING, instanceref STRING, featurekey STRING, orgid STRING, recipient STRING, status STRING, attemptedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(), details VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_APPROVAL_AUDIT ( AUDIT_ID STRING PRIMARY KEY, STAGING_ID STRING, ACTION STRING, ACTOR STRING, ACTION_TS TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), DETAILS VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.API_AUDIT ( AUDIT_ID STRING PRIMARY KEY, API_NAME STRING, REQUEST_PAYLOAD VARIANT, RESPONSE_PAYLOAD VARIANT, STATUS STRING, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.INFERENCE_PROVENANCE ( PROV_ID STRING PRIMARY KEY, REQUEST_ID STRING, MODEL_ID STRING, INPUT VARIANT, OUTPUT VARIANT, TOKENS NUMBER, CONFIDENCE NUMBER, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_AUDIT ( AUDIT_ID STRING PRIMARY KEY, INVOICE_ID STRING, EVENT_TYPE STRING, DETAILS VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.ACTIVATION_AUDIT ( ACT_ID STRING PRIMARY KEY, ADMIN_USER STRING, ACCOUNT_ID STRING, FEATURE_KEY STRING, ACTION STRING, EFFECTIVE_FROM TIMESTAMP_LTZ, DETAILS VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.ALERT_CONFIG ( ALERT_ID STRING PRIMARY KEY, NAME STRING, QUERY TEXT, SEVERITY STRING, ENABLED BOOLEAN DEFAULT TRUE, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.ALERTS ( ALERT_ID STRING PRIMARY KEY, NAME STRING, DETAILS VARIANT, LEVEL STRING, ACKED BOOLEAN DEFAULT FALSE, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), ACKED_AT TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_RAW ( USAGE_JSON VARIANT, INGESTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.AI_PROCESSING_LOG ( LOG_ID STRING PRIMARY KEY, MODEL_ID STRING, REQUEST_ID STRING, PROCESSING_TIME_MS NUMBER, STATUS STRING, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.RETENTION_POLICIES ( POLICY_ID STRING PRIMARY KEY, NAME STRING, DESCRIPTION STRING, APPLY_TO STRING, RETENTION_DAYS NUMBER, IS_ACTIVE BOOLEAN DEFAULT TRUE, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.ARCHIVE_JOBS ( JOB_ID STRING PRIMARY KEY, OBJECT_TYPE STRING, QUERY STRING, ARCHIVE_STAGE STRING, STATUS STRING DEFAULT 'PENDING', RUN_AT TIMESTAMP_LTZ, COMPLETED_AT TIMESTAMP_LTZ, DETAILS VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.INVOICE_ARCHIVE ( INVOICE_ID STRING PRIMARY KEY, ACCOUNT_ID STRING, SUBTOTAL NUMBER, MARKUP NUMBER, TAX NUMBER, TOTAL NUMBER, CURRENCY STRING, ARCHIVED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4901featureinstanceincidentrecoverypostmortems ( postmortemid STRING PRIMARY KEY, incidentid STRING, instanceref STRING, featurekey STRING, orgid STRING, summary VARIANT, authors ARRAY, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4903featureinstancepostmortemactionfollowups ( followupid STRING PRIMARY KEY, postmortemid STRING, instanceref STRING, featurekey STRING, orgid STRING, description STRING, assignedto STRING, status STRING DEFAULT 'OPEN', dueat TIMESTAMPLTZ, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4905featureinstancepostmortemfollowupupdates ( updateid STRING PRIMARY KEY, followupid STRING, postmortemid STRING, instanceref STRING, featurekey STRING, orgid STRING, comment STRING, updatedby STRING, updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4907featureinstanceincidentrecoveryplaybooks ( playbookid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, playbook VARIANT, version INT, updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4909featureinstancerecoveryrunlogs ( runid STRING PRIMARY KEY, playbookid STRING, incidentid STRING, instanceref STRING, featurekey STRING, orgid STRING, initiatedby STRING, steps VARIANT, outcome VARIANT, executedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4911featureinstanceservicedependencymaps ( mapid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, dependencyblob VARIANT, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4913featureinstancedependencyvalidationresults ( validationid STRING PRIMARY KEY, mapid STRING, instanceref STRING, featurekey STRING, orgid STRING, passed BOOLEAN, details VARIANT, validatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) Artifact: AI_FEATURE_HUB.docgen_4201_feature_instance_service_tokensConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4201_feature_instance_service_tokens ( token_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, token_ref STRING, issued_to STRING, scopes ARRAY, expires_at TIMESTAMP_LTZ, issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4203_feature_instance_service_token_auditConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4203_feature_instance_service_token_audit ( audit_id STRING PRIMARY KEY, token_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, action STRING, actor STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4205_feature_instance_scheduled_health_checksConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4205_feature_instance_scheduled_health_checks ( schedule_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, check_id STRING, next_run_at TIMESTAMP_LTZ, cadence_seconds INT, enabled BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4207_feature_instance_health_check_backoff_logsConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4207_feature_instance_health_check_backoff_logs ( backoff_id STRING PRIMARY KEY, check_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, consecutive_failures INT, backoff_until TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4209_feature_instance_alert_suppression_rulesConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4209_feature_instance_alert_suppression_rules ( rule_id STRING PRIMARY KEY, feature_key STRING, instance_ref STRING, org_id STRING, alert_types ARRAY, suppressed_from TIMESTAMP_LTZ, suppressed_to TIMESTAMP_LTZ, reason VARIANT, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4211_feature_instance_alert_suppression_logConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4211_feature_instance_alert_suppression_log ( log_id STRING PRIMARY KEY, rule_id STRING, alert_id STRING, feature_key STRING, instance_ref STRING, org_id STRING, evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), suppressed BOOLEAN, reason VARIANT) Artifact: AI_FEATURE_HUB.docgen_4213_feature_instance_cost_reallocation_requestsConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4213_feature_instance_cost_reallocation_requests ( request_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, requested_by STRING, from_cost_center STRING, to_cost_center STRING, amount NUMBER, reason VARIANT, status STRING DEFAULT 'PENDING', requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), processed_at TIMESTAMP_LTZ) Artifact: AI_FEATURE_HUB.docgen_4215_feature_instance_cost_reallocation_auditConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4215_feature_instance_cost_reallocation_audit ( audit_id STRING PRIMARY KEY, request_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, processed_by STRING, action STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4217_feature_instance_alert_annotationConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4217_feature_instance_alert_annotation ( annotation_id STRING PRIMARY KEY, alert_id STRING, feature_key STRING, instance_ref STRING, org_id STRING, author STRING, note VARIANT, annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4219_feature_instance_customer_attachment_retentionConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4219_feature_instance_customer_attachment_retention ( policy_id STRING PRIMARY KEY, feature_key STRING, instance_ref STRING, org_id STRING, retention_days INT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4221_feature_instance_customer_attachment_purge_jobsConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4221_feature_instance_customer_attachment_purge_jobs ( job_id STRING PRIMARY KEY, policy_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, scheduled_at TIMESTAMP_LTZ, status STRING DEFAULT 'QUEUED', executed_at TIMESTAMP_LTZ, result VARIANT) Artifact: AI_FEATURE_HUB.docgen_4223_feature_instance_customer_attachment_purge_historyConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4223_feature_instance_customer_attachment_purge_history ( history_id STRING PRIMARY KEY, job_id STRING, policy_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, executed_at TIMESTAMP_LTZ, status STRING, details VARIANT) Artifact: AI_FEATURE_HUB.docgen_4225_feature_instance_customer_comms_templatesConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4225_feature_instance_customer_comms_templates ( template_id STRING PRIMARY KEY, feature_key STRING, instance_ref STRING, org_id STRING, name STRING, subject STRING, body TEXT, placeholders ARRAY, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4227_feature_instance_customer_comms_dispatch_queueConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4227_feature_instance_customer_comms_dispatch_queue ( dispatch_id STRING PRIMARY KEY, template_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, recipients ARRAY, scheduled_at TIMESTAMP_LTZ, status STRING DEFAULT 'QUEUED', attempts INT DEFAULT 0, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4229_feature_instance_customer_comms_delivery_logConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4229_feature_instance_customer_comms_delivery_log ( delivery_id STRING PRIMARY KEY, dispatch_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, recipient STRING, status STRING, attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), details VARIANT) Artifact: AI_FEATURE_HUB.docgen_4231_feature_instance_api_usage_quotasConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4231_feature_instance_api_usage_quotas ( quota_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, limit_per_minute INT, limit_per_hour INT, limit_per_day INT, enforced BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_4233_feature_instance_api_quota_violationsConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4233_feature_instance_api_quota_violations ( violation_id STRING PRIMARY KEY, quota_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, observed_count INT, period_start TIMESTAMP_LTZ, period_end TIMESTAMP_LTZ, recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), details VARIANT) Artifact: AI_FEATURE_HUB.docgen_4235_feature_instance_feature_flagsConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4235_feature_instance_feature_flags ( flag_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, flag_key STRING, enabled BOOLEAN DEFAULT FALSE, rollout_percent INT, config VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), updated_at TIMESTAMP_LTZ) Artifact: AI_FEATURE_HUB.DOCUMENT_EMBEDDINGSConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.DOCUMENT_EMBEDDINGS ( document_id STRING, section_id STRING, org_id STRING, model_id STRING, embedding VARIANT, metadata VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.PARSED_CONTENTConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.PARSED_CONTENT ( parsed_id STRING PRIMARY KEY, document_id STRING, section_id STRING, org_id STRING, content TEXT, content_hash STRING, metadata VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.CLAUSE_BLOCKSConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.CLAUSE_BLOCKS ( clause_id STRING PRIMARY KEY, document_id STRING, section_id STRING, org_id STRING, clause_text TEXT, clause_type STRING, metadata VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.SIMILARITY_RESULTSConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.SIMILARITY_RESULTS ( query_id STRING, result_rank INT, document_id STRING, section_id STRING, score NUMBER, model_id STRING, metadata VARIANT, computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.INFERENCE_PROVENANCEConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.INFERENCE_PROVENANCE ( provenance_id STRING PRIMARY KEY, request_id STRING, model_id STRING, prompt VARIANT, response VARIANT, retrieval_context VARIANT, user_id STRING, org_id STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.USAGE_EVENTSConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_EVENTS ( usage_id STRING PRIMARY KEY, account_id STRING, instance_ref STRING, feature_key STRING, event_type STRING, units NUMBER, event_time TIMESTAMP_LTZ, metadata VARIANT, ingested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.BILLING_AUDITConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_AUDIT ( audit_id STRING PRIMARY KEY, billing_run_id STRING, invoice_id STRING, action STRING, performed_by STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.ALERT_CONFIGConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.ALERT_CONFIG ( config_id STRING PRIMARY KEY, org_id STRING, feature_key STRING, slo_definition VARIANT, alert_thresholds VARIANT, enabled BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), updated_at TIMESTAMP_LTZ) Artifact: AI_FEATURE_HUB.RATE_CARD_TIERSConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_CARD_TIERS ( tier_id STRING PRIMARY KEY, rate_card_id STRING, name STRING, lower_bound NUMBER, upper_bound NUMBER, unit_price NUMBER, currency STRING, metadata VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.USAGE_ANOMALIESConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_ANOMALIES ( anomaly_id STRING PRIMARY KEY, account_id STRING, feature_key STRING, detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), score NUMBER, window VARIANT, details VARIANT) Artifact: AI_FEATURE_HUB.API_KEYSConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.API_KEYS ( api_key_id STRING PRIMARY KEY, account_id STRING, key_value STRING, description STRING, scopes ARRAY, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), revoked BOOLEAN DEFAULT FALSE, revoked_at TIMESTAMP_LTZ) Artifact: AI_FEATURE_HUB.COST_ALLOCATION_TAGSConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.COST_ALLOCATION_TAGS ( tag_id STRING PRIMARY KEY, org_id STRING, tag_key STRING, tag_value STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.DATA_LINEAGEConsolidated DDL:CREATE OR REPLACE TABLE AI_FEATURE_HUB.DATA_LINEAGE ( lineage_id STRING PRIMARY KEY, source_object STRING, target_object STRING, transformation VARIANT, triggered_by STRING, executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), metadata VARIANT
) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runbook_checklists ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, payload VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4203featureinstanceservicetokenaudit (
    auditid STRING PRIMARY KEY,
    tokenid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4205featureinstancescheduledhealthchecks (
    scheduleid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    checkid STRING,
    nextrunat TIMESTAMPLTZ,
    cadenceseconds INT,
    enabled BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4207featureinstancehealthcheckbackofflogs (
    backoffid STRING PRIMARY KEY,
    checkid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    consecutivefailures INT,
    backoffuntil TIMESTAMPLTZ,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4209featureinstancealertsuppressionrules (
    ruleid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    alerttypes ARRAY,
    suppressedfrom TIMESTAMPLTZ,
    suppressedto TIMESTAMPLTZ,
    reason VARIANT,
    createdby STRING,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4211featureinstancealertsuppressionlog (
    logid STRING PRIMARY KEY,
    ruleid STRING,
    alertid STRING,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    evaluatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,suppressed BOOLEAN,reason VARIANT);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4213featureinstancecostreallocationrequests (
    requestid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requestedby STRING,
    fromcostcenter STRING,
    tocostcenter STRING,
    amount NUMBER,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requestedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,processedat TIMESTAMPLTZ);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4215featureinstancecostreallocationaudit (
    auditid STRING PRIMARY KEY,
    requestid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    processedby STRING,
    action STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4217featureinstancealertannotation (
    annotationid STRING PRIMARY KEY,
    alertid STRING,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    author STRING,
    note VARIANT,
    annotatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4217featureinstanceratecardtiers (
    tierid STRING PRIMARY KEY,
    featurekey STRING NOT NULL,
    orgid STRING,
    tier_name STRING,
    min_units NUMBER,
    max_units NUMBER,
    price_per_unit NUMBER(18,6),
    currency STRING DEFAULT 'USD',
    effective_from TIMESTAMPLTZ,
    effective_to TIMESTAMPLTZ,
    metadata VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4219featureinstancecustomerattachmentretention (
    policyid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    retentiondays INT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4219featureinstanceratecardrules (
    ruleid STRING PRIMARY KEY,
    tierid STRING,
    featurekey STRING,
    orgid STRING,
    predicate VARIANT,
    -- expression or JSON predicate for applicability transform VARIANT,
    -- pricing transform details priority INT DEFAULT 100,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4221featureinstancebillingruns (
    billrunid STRING PRIMARY KEY,
    orgid STRING,
    featurekey STRING,
    instanceref STRING,
    period_start TIMESTAMPLTZ,
    period_end TIMESTAMPLTZ,
    status STRING DEFAULT 'CREATED',
    -- CREATED / RUNNING / COMPLETED / FAILED total_amount NUMBER(18,6),
    currency STRING DEFAULT 'USD',
    details VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    completed_at TIMESTAMPLTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4221featureinstancecustomerattachmentpurgejobs (
    jobid STRING PRIMARY KEY,
    policyid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    scheduledat TIMESTAMPLTZ,
    status STRING DEFAULT 'QUEUED',
    executedat TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4223featureinstancebillinglineitems (
    lineitemid STRING PRIMARY KEY,
    billrunid STRING,
    orgid STRING,
    featurekey STRING,
    instanceref STRING,
    usage_start TIMESTAMPLTZ,
    usage_end TIMESTAMPLTZ,
    units NUMBER(18,6),
    unit_price NUMBER(18,6),
    amount NUMBER(18,6),
    currency STRING DEFAULT 'USD',
    details VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4223featureinstancecustomerattachmentpurgehistory (
    historyid STRING PRIMARY KEY,
    jobid STRING,
    policyid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    executedat TIMESTAMPLTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4225featureinstancebillingreconciliation (
    reconid STRING PRIMARY KEY,
    billrunid STRING,
    external_invoice_id STRING,
    orgid STRING,
    reconciled BOOLEAN DEFAULT FALSE,
    discrepancy_amount NUMBER(18,6),
    notes VARIANT,
    reconciled_at TIMESTAMPLTZ,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4225featureinstancecustomercommstemplates (
    templateid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    name STRING,
    template VARIANT,
    updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4227featureinstancecustomercommsdispatchqueue (
    queueid STRING PRIMARY KEY,
    templateid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    scheduledfor TIMESTAMPLTZ,
    status STRING DEFAULT 'PENDING',
    attempt_count INT DEFAULT 0,
    last_attempt TIMESTAMPLTZ,
    payload VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4227featureinstancepreflightchecks (
    preflightid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    check_name STRING,
    description STRING,
    expected_result VARIANT,
    created_by STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4229featureinstancecustomercommsdeliverylog (
    deliveryid STRING PRIMARY KEY,
    dispatchid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    recipient STRING,
    status STRING,
    attemptedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    result VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen4831featureinstanceservicedeprecationnoticesCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4831featureinstanceservicedeprecationnotices ( noticeid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, message VARIANT, effective_date TIMESTAMPLTZ, created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen4833featureinstancecustomermigrationplansCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4833featureinstancecustomermigrationplans ( planid STRING PRIMARY KEY, from_instanceref STRING, to_instanceref STRING, orgid STRING, scheduled_at TIMESTAMPLTZ, status STRING, details VARIANT, created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen4835featureinstancecustomersupportescalationpoliciesCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4835featureinstancecustomersupportescalationpolicies ( policyid STRING PRIMARY KEY, instanceref STRING, orgid STRING, active BOOLEAN DEFAULT TRUE, escalation_steps VARIANT, created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen4837featureinstancecustomerfeedbacksummariesCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4837featureinstancecustomerfeedbacksummaries ( summaryid STRING PRIMARY KEY, instanceref STRING, orgid STRING, period_start TIMESTAMPLTZ, period_end TIMESTAMPLTZ, summary VARIANT, generated_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen5003featureinstancecapacityalertrulesCREATE OR REPLACE TABLE AIFEATUREHUB.docgen5003featureinstancecapacityalertrules ( ruleid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, schedule_id STRING, threshold VARIANT, enabled BOOLEAN DEFAULT TRUE, created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen4801featureinstancepolicychangerequestsCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4801featureinstancepolicychangerequests ( requestid STRING PRIMARY KEY, policyid STRING, instanceref STRING, featurekey STRING, orgid STRING, requestedby STRING, requestedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(), status STRING, details VARIANT) Artifact: docgen4803featureinstancepolicychangeauditCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4803featureinstancepolicychangeaudit ( auditid STRING PRIMARY KEY, requestid STRING, policyid STRING, instanceref STRING, featurekey STRING, orgid STRING, processedby STRING, action STRING, notes VARIANT, actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen4805featureinstanceeventschemaregistryCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4805featureinstanceeventschemaregistry ( schemaid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, version INT, schema_definition VARIANT, registered_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen4807featureinstanceeventschemavalidationresultsCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4807featureinstanceeventschemavalidationresults ( validationid STRING PRIMARY KEY, schemaid STRING, instanceref STRING, featurekey STRING, orgid STRING, passed BOOLEAN, report VARIANT, evaluated_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: docgen4809featureinstancetelemetrymetricsindexCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4809featureinstancetelemetrymetricsindex ( indexid STRING PRIMARY KEY, metricid STRING, instanceref STRING, orgid STRING, mapping_blob VARIANT, created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: TENANT_FEATURE_USAGECREATE OR REPLACE TABLE AI_FEATURE_HUB.TENANT_FEATURE_USAGE ( USAGE_ID STRING PRIMARY KEY, ACCOUNT_ID STRING, ORG_ID STRING, FEATURE_KEY STRING, UNITS NUMBER, UNIT_PRICE NUMBER, USAGE_TIMESTAMP TIMESTAMPLTZ, EVENT_ID STRING, MODEL_ID STRING, TRACE_ID STRING, PAYLOAD VARIANT, METADATA VARIANT, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: TENANT_FEATURE_PRICINGCREATE OR REPLACE TABLE AI_FEATURE_HUB.TENANT_FEATURE_PRICING ( PRICING_ID STRING PRIMARY KEY, ORG_ID STRING, FEATURE_CODE STRING, UNIT_PRICE NUMBER, CURRENCY STRING, MARKUP_JSON VARIANT, EFFECTIVE_FROM TIMESTAMPLTZ, EFFECTIVE_TO TIMESTAMPLTZ, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: SUBSCRIPTION_INVOICESCREATE OR REPLACE TABLE AI_FEATURE_HUB.SUBSCRIPTION_INVOICES ( INVOICE_ID STRING PRIMARY KEY, ORG_ID STRING, ACCOUNT_ID STRING, PERIOD_START TIMESTAMPLTZ, PERIOD_END TIMESTAMPLTZ, SUBTOTAL NUMBER, MARKUP_TOTAL NUMBER, TAXES NUMBER, TOTAL NUMBER, INVOICE_HASH STRING, LINE_ITEMS VARIANT, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: BILLING_LINE_ITEMCREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_LINE_ITEM ( LINE_ID STRING PRIMARY KEY, BILLING_RUN_ID STRING, ORG_ID STRING, ACCOUNT_ID STRING, FEATURE_KEY STRING, UNITS NUMBER, UNIT_PRICE NUMBER, BASE_COST NUMBER, MARKUP_AMOUNT NUMBER, LINE_TOTAL NUMBER, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: BILLING_RUNCREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_RUN ( BILLING_RUN_ID STRING PRIMARY KEY, ORG_ID STRING, RUN_START TIMESTAMPLTZ, RUN_END TIMESTAMPLTZ, PERIOD_START TIMESTAMPLTZ, PERIOD_END TIMESTAMPLTZ, PREVIEW_FLAG BOOLEAN DEFAULT FALSE, INVOICE_HASH STRING, TOTAL_AMOUNT NUMBER, STATUS STRING, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: DOCUMENT_EMBEDDINGSCREATE OR REPLACE TABLE AI_FEATURE_HUB.DOCUMENT_EMBEDDINGS ( EMBEDDING_ID STRING PRIMARY KEY, DOCUMENT_ID STRING, SECTION_ID STRING, ORG_ID STRING, MODEL_ID STRING, EMBEDDING VARIANT, METADATA VARIANT, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: INDEX_SNAPSHOT_MANIFESTCREATE OR REPLACE TABLE AI_FEATURE_HUB.INDEX_SNAPSHOT_MANIFEST ( SNAPSHOT_ID STRING PRIMARY KEY, ORG_ID STRING, S3_PREFIX STRING, SHARD_COUNT INT, DIMENSIONS INT, MANIFEST VARIANT, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: PROVENANCECREATE OR REPLACE TABLE AI_FEATURE_HUB.PROVENANCE ( PROV_ID STRING PRIMARY KEY, ORG_ID STRING, ASSEMBLY_RUN_ID STRING, PROMPT VARIANT, RESPONSE VARIANT, RETRIEVAL_LIST VARIANT, MODEL_META VARIANT, CONFIDENCE NUMBER, EVIDENCE_URI STRING, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: ADMIN_AUDITCREATE OR REPLACE TABLE AI_FEATURE_HUB.ADMIN_AUDIT ( AUDIT_ID STRING PRIMARY KEY, ACTION STRING, DETAILS VARIANT, PERFORMED_BY STRING, TARGET_RESOURCE STRING, CREATED_AT TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: RATE_RULE_TEMPLATESCREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULE_TEMPLATES ( TEMPLATE_ID STRING PRIMARY KEY, NAME STRING, DESCRIPTION STRING, CONFIG_SAMPLE VARIANT, CREATED_AT TIMESTAMP_LTZ) Artifact: RATE_RULESCREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES ( RULE_ID STRING PRIMARY KEY, FEATURE_KEY STRING NOT NULL, RULE_TYPE STRING NOT NULL, -- ’TIER’,’CAP’,’MINIMUM’,’DISCOUNT’,’TAX’,’FLAT’ CONFIG VARIANT NOT NULL, -- JSON of the rule config PRIORITY NUMBER DEFAULT 100, EFFECTIVE_FROM TIMESTAMP_LTZ, EFFECTIVE_TO TIMESTAMP_LTZ, ACTIVE BOOLEAN, CREATED_AT TIMESTAMP_LTZ) Artifact: RATE_RULES_STAGINGCREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_STAGING ( STAGING_ID STRING PRIMARY KEY, FEATURE_KEY STRING NOT NULL, RULE_TYPE STRING NOT NULL, CONFIG VARIANT NOT NULL, PRIORITY NUMBER DEFAULT 100, SUBMITTED_BY STRING, SUBMITTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), APPROVED BOOLEAN DEFAULT FALSE, APPROVED_BY STRING, APPROVED_AT TIMESTAMP_LTZ, REJECTED BOOLEAN DEFAULT FALSE, REJECT_REASON STRING, ARCHIVED BOOLEAN DEFAULT FALSE) Artifact: RATE_RULES_APPROVAL_AUDITCREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_APPROVAL_AUDIT ( AUDIT_ID STRING PRIMARY KEY, STAGING_ID STRING, ACTION STRING, -- ’SUBMIT’,’APPROVE’,’REJECT’,’ARCHIVE’ ACTOR STRING, ACTION_TS TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), DETAILS VARIANT) Artifact: RECONCILIATION_AUDITCREATE OR REPLACE TABLE AI_FEATURE_HUB.RECONCILIATION_AUDIT ( AUDIT_ID STRING PRIMARY KEY, ACCOUNT_ID STRING, FEATURE_KEY STRING, USAGE_SUM NUMBER, BILL_SUM NUMBER, MISMATCH NUMBER, RUN_AT TIMESTAMP_LTZ) Artifact: MODEL_TELEMETRYCREATE OR REPLACE TABLE AI_FEATURE_HUB.MODEL_TELEMETRY ( TELEMETRY_ID STRING PRIMARY KEY, PROV_ID STRING, MODEL_ID STRING, REQUEST_TIMESTAMP TIMESTAMP_LTZ, RESPONSE_TIMESTAMP TIMESTAMP_LTZ, TOKENS_PROMPT NUMBER, TOKENS_COMPLETION NUMBER, COST NUMBER, USER_FEEDBACK NUMBER, METADATA VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: INFERENCE_PROVENANCECREATE OR REPLACE TABLE AI_FEATURE_HUB.INFERENCE_PROVENANCE ( PROV_ID STRING PRIMARY KEY, REQUEST_ID STRING, MODEL_ID STRING, INPUT VARIANT, OUTPUT VARIANT, TOKENS NUMBER, CONFIDENCE NUMBER, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: API_AUDITCREATE OR REPLACE TABLE AI_FEATURE_HUB.API_AUDIT ( AUDIT_ID STRING PRIMARY KEY, API_NAME STRING, REQUEST_PAYLOAD VARIANT, RESPONSE_PAYLOAD VARIANT, STATUS STRING, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: ACTIVATION_AUDITCREATE OR REPLACE TABLE AI_FEATURE_HUB.ACTIVATION_AUDIT ( ACT_ID STRING PRIMARY KEY, ADMIN_USER STRING, ACCOUNT_ID STRING, FEATURE_KEY STRING, ACTION STRING, EFFECTIVE_FROM TIMESTAMP_LTZ, DETAILS VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: TENANT_FEATURE_USAGECREATE OR REPLACE TABLE AI_FEATURE_HUB.TENANT_FEATURE_USAGE ( USAGE_ID STRING PRIMARY KEY, ACCOUNT_ID STRING, ORG_ID STRING, FEATURE_KEY STRING, UNITS NUMBER, UNIT_PRICE NUMBER, USAGE_TIMESTAMP TIMESTAMP_LTZ, METADATA VARIANT) Artifact: USAGE_RAWCREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_RAW ( USAGE_JSON VARIANT, INGESTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: ALERT_CONFIGCREATE OR REPLACE TABLE AI_FEATURE_HUB.ALERT_CONFIG ( ALERT_ID STRING PRIMARY KEY, NAME STRING, QUERY TEXT, SEVERITY STRING, ENABLED BOOLEAN DEFAULT TRUE, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: ALERTSCREATE OR REPLACE TABLE AI_FEATURE_HUB.ALERTS ( ALERT_ID STRING PRIMARY KEY, NAME STRING, DETAILS VARIANT, LEVEL STRING, ACKED BOOLEAN DEFAULT FALSE, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), ACKED_AT TIMESTAMP_LTZ) Artifact: RATE_CARDCREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_CARD ( RATE_ID STRING PRIMARY KEY, FEATURE_KEY STRING, BASE_UNIT_PRICE NUMBER, UNIT STRING, MIN_FEE NUMBER DEFAULT 0, CAP_FEE NUMBER NULL, EFFECTIVE_FROM TIMESTAMP_LTZ, EFFECTIVE_TO TIMESTAMP_LTZ, UPDATED_BY STRING, UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: ann_autoscale_actionsCREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_autoscale_actions ( action_id STRING PRIMARY KEY, container_name STRING, recommended_action STRING, recommended_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), approved BOOLEAN DEFAULT FALSE, approved_by STRING, approved_at TIMESTAMP_LTZ) Artifact: similarity_query_logsCREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_query_logs ( query_id STRING PRIMARY KEY, org_id STRING, index_id STRING, query_vector VARIANT, top_k NUMBER, returned_count NUMBER, latency_ms FLOAT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: ann_rate_limitsCREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_rate_limits ( org_id STRING PRIMARY KEY, max_qps FLOAT, max_concurrency INT, last_updated TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: similarity_retry_policyCREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_retry_policy ( policy_id STRING PRIMARY KEY, org_id STRING, max_retries INT, base_backoff_seconds INT, max_backoff_seconds INT, jitter BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: semantic_index_maintenance_logsCREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_maintenance_logs ( maintenance_id STRING PRIMARY KEY, index_id STRING, action STRING, actor STRING, details VARIANT, performed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: index_retirement_queueCREATE OR REPLACE TABLE AI_FEATURE_HUB.index_retirement_queue ( retirement_id STRING PRIMARY KEY, index_snapshot_id STRING, org_id STRING, reason STRING, queued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), processed BOOLEAN DEFAULT FALSE
) Artifact: embedding_quality_checksCREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_quality_checks (check_id STRING PRIMARY KEY,org_id STRING,document_id STRING,block_id STRING,check_type STRING,result STRING,details VARIANT,checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4229featureinstancepreflightcheckresults (
    resultid STRING PRIMARY KEY,
    preflightid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    result_status STRING,
    -- PASS / WARN / FAIL details VARIANT,
    run_by STRING,
    run_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4231featureinstanceapiousagequotas (
    quota_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    limit_per_minute INT,
    limit_per_hour INT,
    limit_per_day INT,
    enforced BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4231featureinstanceapiusagequotas (
    quotaid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    limitperminute INT,
    limitperhour INT,
    limitperday INT,
    enforced BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4231featureinstancedeploymentmetricthresholds (
  thresholdid STRING PRIMARY KEY,
  instanceref STRING,
  featurekey STRING,
  orgid STRING,
  metric_name STRING,
  comparator STRING,       -- '&gt;


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4233featureinstanceapiquotaviolations (
    violationid STRING PRIMARY KEY,
    quotaid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    observedcount INT,
    periodstart TIMESTAMPLTZ,
    periodend TIMESTAMPLTZ,
    recordedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,    details VARIANT);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4233featureinstancedeploymentmetricviolations (
    violationid STRING PRIMARY KEY,
    thresholdid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    metric_name STRING,
    observed_value NUMBER,
    observed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    resolved BOOLEAN DEFAULT FALSE,
    resolution_notes VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4235featureinstancedeploymentrollbackrequests (
    rollbackid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requested_by STRING,
    requested_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    reason STRING,
    target_version STRING,
    -- version to rollback to status STRING DEFAULT 'REQUESTED',
    -- REQUESTED/APPROVED/REJECTED/COMPLETED processed_by STRING,
    processed_at TIMESTAMPLTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4235featureinstancefeatureflags (
    flagid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    flagkey STRING,
    enabled BOOLEAN,
    criteria VARIANT,
    updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,    updated_by STRING);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4237featureinstancedeploymentrollbackaudit (
    auditid STRING PRIMARY KEY,
    rollbackid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    -- 'SUBMITTED',
    'APPROVED',
    'REJECTED',
    'EXECUTED' actor STRING,
    notes VARIANT,
    acted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4237featureinstanceflagevaluationlogs (
    evalid STRING PRIMARY KEY,
    flagid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    evaluated_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,    result VARIANT);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4239featureinstancedeploymentapprovals (
    approvalid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    change_request_id STRING,
    approver STRING,
    decision STRING,
    -- 'APPROVE' / 'REJECT' comment STRING,
    decided_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4239featureinstanceruntimemetadata (
    metaid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    metadata VARIANT,
    recordedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4241featureinstancedeploymentapprovalaudit (
    auditid STRING PRIMARY KEY,
    approvalid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    -- e.g.,
    'CREATED',
    'UPDATED',
    'DECIDED' actor STRING,
    previous_state VARIANT,
    new_state VARIANT,
    acted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4241featureinstancemaintenancechecklist (
    checklistid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    name STRING,
    items VARIANT,
    -- array/object of checklist steps {id,
    desc,
    expected_freq,
    owner} last_executed_at TIMESTAMPLTZ,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updatedat TIMESTAMPLTZ);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4243featureinstancemaintenanceschedules (
    scheduleid STRING PRIMARY KEY,
    checklistid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    cadence STRING,
    -- cron or descriptive cadence next_run_at TIMESTAMPLTZ,
    enabled BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4245featureinstancedeploymentrecords (
    deploymentid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    version STRING,
    deployed_by STRING,
    deployed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,  artifacts VARIANT, -- manifest of deployed artifacts  notes STRING);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4247featureinstanceconfigsnapshots (
    snapshotid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    config VARIANT,
    -- full config blob effective_from TIMESTAMPLTZ,
    effective_to TIMESTAMPLTZ,
    captured_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,  captured_by STRING);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4249featureinstanceexperiments (
    experimentid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    name STRING,
    hypothesis STRING,
    config VARIANT,
    status STRING,
    -- DRAFT/ACTIVE/PAUSED/COMPLETED started_at TIMESTAMPLTZ,
    ended_at TIMESTAMPLTZ,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4251featureinstanceexperimentresults (
    resultid STRING PRIMARY KEY,
    experimentid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    arm STRING,
    -- control/treatment metrics VARIANT,
    -- metrics and statistics sample_size INT,
    recorded_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4253featureinstancealerts (
    alertid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    alert_type STRING,
    severity STRING,
    payload VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,  status STRING -- OPEN/ACKED/RESOLVED);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4255featureinstancealertsmetadata (
    metaid STRING PRIMARY KEY,
    alertid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    context VARIANT,
    enrichments VARIANT,
    recorded_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4257featureinstancealertactions (
    actionid STRING PRIMARY KEY,
    alertid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action_type STRING,
    -- NOTIFY/ESCALATE/AUTO_REMEDIATE parameters VARIANT,
    executed_by STRING,
    executed_at TIMESTAMPLTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4259featureinstancedriftdetections (
    driftid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    drift_type STRING,
    score FLOAT,
    evidence VARIANT,
    detected_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,  severity STRING);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4261featureinstancechangelogs (
    changelogid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    change_type STRING,
    diff VARIANT,
    changed_by STRING,
    changed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4261_feature_instance_certification_records (
    certid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    certificationbody STRING,
    certblob VARIANT,
    validfrom TIMESTAMPLTZ,
    validto TIMESTAMPLTZ,
    issuedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4263featureinstanceintegrations (
    integrationid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    provider STRING,
    config VARIANT,
    status STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4263_feature_instance_certification_audit (
    auditid STRING PRIMARY KEY,
    certid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4265featureinstanceaccessreviews (
    reviewid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    reviewer STRING,
    target_principals ARRAY,
    outcome VARIANT,
    reviewed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,  status STRING);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4265_feature_instance_third_party_service_mappings (
    mappingid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    servicename STRING,
    config VARIANT,
    lastvalidatedat TIMESTAMPLTZ,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4267featureinstancevulnerabilityscans (
    scanid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    scanner STRING,
    findings VARIANT,
    scan_time TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,  remediation_status STRING);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4267_feature_instance_third_party_service_health (
    healthid STRING PRIMARY KEY,
    mappingid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    status STRING,
    metrics VARIANT,
    checkedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4269featureinstanceincident_ratecards (
    ratecardid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    billing_metric STRING,
    unit_price NUMBER,
    currency STRING,
    effective_from TIMESTAMPLTZ,
    effective_to TIMESTAMPLTZ,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4269_feature_instance_third_party_service_alerts (
    alertid STRING PRIMARY KEY,
    healthid STRING,
    mappingid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    message VARIANT,
    triggeredat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , acknowledged BOOLEAN DEFAULT FALSE );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4271featureinstancebillingmeters (
    meterid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    meter_type STRING,
    -- COUNTER/GUAGE/HISTOGRAM meter_key STRING,
    metadata VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4271_feature_instance_business_impact_models (
    modelid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    modelblob VARIANT,
    lastupdatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4283featureinstancereleasecadencedefinitions (
    cadenceid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    cadenceblob VARIANT,
    updatedat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4285featureinstancereleasecadenceevents (
    eventid STRING PRIMARY KEY,
    cadenceid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    eventtype STRING,
    payload VARIANT,
    emittedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4287featureinstancesynthetictransactions (
    txid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    txspec VARIANT,
    lastrunat TIMESTAMPLTZ,
    lastresult VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4289featureinstancesynthetictransactionruns (
    runid STRING PRIMARY KEY,
    txid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    status STRING,
    result VARIANT,
    executedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4291featureinstanceobservationaccesspolicies (
    policyid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    principals ARRAY,
    permissions ARRAY,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4293featureinstanceobservationaccessaudit (
    auditid STRING PRIMARY KEY,
    policyid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    actor STRING,
    action STRING,
    allowed BOOLEAN,
    details VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4295featureinstanceeventcorrelationrules (
    ruleid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    ruleblob VARIANT,
    active BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4297featureinstanceeventcorrelationresults (
    correlationid STRING PRIMARY KEY,
    ruleid STRING,
    eventrefs ARRAY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    correlatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,  candidateincident_id STRING,  score FLOAT,  details VARIANT);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4299featureinstanceeventcorrelationaudit (
    auditid STRING PRIMARY KEY,
    correlationid STRING,
    ruleid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4317featureinstancedynamicriskscores (
    scoreid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    riskscore FLOAT,
    drivers VARIANT,
    computedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4319featureinstanceriskalerts (
    alertid STRING PRIMARY KEY,
    scoreid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    riskscore FLOAT,
    threshold FLOAT,
    message VARIANT,
    triggeredat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,acknowledged BOOLEAN DEFAULT FALSE);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4321featureinstanceconfigurationchangerequests (
    requestid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requestedby STRING,
    configpayload VARIANT,
    status STRING DEFAULT 'PENDING',
    requestedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,processedat TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4323featureinstanceconfigurationchangeaudit (
    auditid STRING PRIMARY KEY,
    requestid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    processedby STRING,
    action STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4325featureinstanceexperimentalfeaturesregistry (
    regid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    experimentalfeaturekey STRING,
    enabled BOOLEAN DEFAULT FALSE,
    enabledby STRING,
    enabledat TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4327featureinstanceexperimentfeedback (
    feedbackid STRING PRIMARY KEY,
    regid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    userid STRING,
    feedback VARIANT,
    submittedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4329featureinstanceexperimentsummaryreports (
    reportid STRING PRIMARY KEY,
    regid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    summaryblob VARIANT,
    generatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4331featureinstancefeatureusagemeters (
    meterid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    meterspec VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4333featureinstancefeatureusagemeasurements (
    measurementid STRING PRIMARY KEY,
    meterid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    measuredat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,value NUMBER,dimensions VARIANT);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4335featureinstancebillinginvoices (
    invoiceid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    customerorgid STRING,
    amount NUMBER,
    currency STRING,
    periodstart TIMESTAMPLTZ,
    periodend TIMESTAMPLTZ,
    issuedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,status STRING);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4337featureinstancebillingdisputes (
    disputeid STRING PRIMARY KEY,
    invoiceid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    customerorgid STRING,
    raisedby STRING,
    reason VARIANT,
    status STRING DEFAULT 'OPEN',
    raisedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) ,resolvedat TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4339featureinstancebillingdisputeresolutions (
    resolutionid STRING PRIMARY KEY,
    disputeid STRING,
    invoiceid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    resolvedby STRING,
    resolution VARIANT,
    resolvedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4341featureinstancesubscriptionmappings (
    mappingid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    customerorgid STRING,
    subscriptionplan STRING,
    effectivefrom TIMESTAMPLTZ,
    effectiveto TIMESTAMPLTZ,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4371featureinstanceincidentseverityguidelines (
    guidelineid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    guidelineblob VARIANT,
    updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4373featureinstanceincidenttriagelogs (
    triageid STRING PRIMARY KEY,
    incidentid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    triagelevel STRING,
    rationale VARIANT,
    triagedby STRING,
    triagedat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4375featureinstanceshortlivedcreds (
    credid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    credref STRING,
    issuedto STRING,
    expiresat TIMESTAMPLTZ,
    issuedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4377featureinstancecredrevocationaudit (
    auditid STRING PRIMARY KEY,
    credid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    revokedby STRING,
    reason VARIANT,
    revokedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4379featureinstancemetricalertfeedback (
    feedbackid STRING PRIMARY KEY,
    alertid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    submittedby STRING,
    feedback VARIANT,
    submittedat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4381featureinstancealertfeedbackactions (
    actionid STRING PRIMARY KEY,
    feedbackid STRING,
    alertid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action VARIANT,
    assignedto STRING,
    status STRING DEFAULT 'OPEN',
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4383featureinstanceautomationrules (
    ruleid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    triggerspec VARIANT,
    actionspec VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4385featureinstanceautomationexecutions (
    execid STRING PRIMARY KEY,
    ruleid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    triggeredby STRING,
    actiontaken VARIANT,
    result VARIANT,
    executedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4387featureinstanceoperationalknowledgebase (
    articleid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    title STRING,
    body VARIANT,
    author STRING,
    publishedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4389featureinstancekbfeedback (
    feedbackid STRING PRIMARY KEY,
    articleid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    userid STRING,
    rating INT,
    comments VARIANT,
    submittedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4391featureinstanceoperationalkbupdates (
    updateid STRING PRIMARY KEY,
    articleid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    updater STRING,
    change VARIANT,
    updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4803featureinstancepolicychangeaudit (
    auditid STRING PRIMARY KEY,
    requestid STRING,
    policyid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4805featureinstanceeventschemaregistry (
    schemaid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    schemablob VARIANT,
    version INT,
    registeredat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4807featureinstanceeventschemavalidationresults (
    validationid STRING PRIMARY KEY,
    schemaid STRING,
    eventref STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    passed BOOLEAN,
    resultblob VARIANT,
    validatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4809featureinstancetelemetrymetricsindex (
    indexid STRING PRIMARY KEY,
    telemetryref STRING,
    metricid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    mappingblob VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4811featureinstancemetricbackfillrequests (
    requestid STRING PRIMARY KEY,
    metricid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    windowstart TIMESTAMPLTZ,
    windowend TIMESTAMPLTZ,
    requestedby STRING,
    status STRING DEFAULT 'PENDING',
    requestedat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP(
) , processedat TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4813featureinstancemetricbackfillaudit (
    auditid STRING PRIMARY KEY,
    requestid STRING,
    metricid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4815featureinstanceincidentsuppressionrules (
    ruleid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    conditions VARIANT,
    suppressedfrom TIMESTAMPLTZ,
    suppressedto TIMESTAMPLTZ,
    reason VARIANT,
    createdby STRING,
    createdat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4817featureinstanceincidentsuppressionevaluations (
    evalid STRING PRIMARY KEY,
    ruleid STRING,
    incidentid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    evaluatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , suppressed BOOLEAN, reason VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4819featureinstanceoperationalcadencedefinitions (
    cadenceid STRING PRIMARY KEY,
    orgid STRING,
    featurekey STRING,
    instanceref STRING,
    cadenceblob VARIANT,
    updatedat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4821featureinstanceoperationalcadenceevents (
    eventid STRING PRIMARY KEY,
    cadenceid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    eventtype STRING,
    payload VARIANT,
    emittedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4823featureinstancegroupingaliases (
    alias_id STRING PRIMARY KEY,
    group_name STRING,
    instanceref ARRAY,
    featurekey STRING,
    orgid STRING,
    metadata VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4825featureinstancegroupingaliaschanges (
    change_id STRING PRIMARY KEY,
    alias_id STRING,
    changed_by STRING,
    change_payload VARIANT,
    change_reason STRING,
    changed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4827featureinstanceapicontractmigrations (
    migration_id STRING PRIMARY KEY,
    api_contract_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    migration_plan VARIANT,
    status STRING DEFAULT 'PENDING',
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , completed_at TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4829featureinstanceapicontractmigrationhistory (
    history_id STRING PRIMARY KEY,
    migration_id STRING,
    api_contract_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    acted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4831featureinstanceservicedeprecationnotices (
    notice_id STRING PRIMARY KEY,
    service_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    deprecation_date TIMESTAMPLTZ,
    notice_body VARIANT,
    created_by STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4833featureinstancecustomermigrationplans (
    plan_id STRING PRIMARY KEY,
    customer_id STRING,
    from_instance STRING,
    to_instance STRING,
    featurekey STRING,
    orgid STRING,
    plan_payload VARIANT,
    status STRING DEFAULT 'DRAFT',
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , executed_at TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4835featureinstancecustomermigrationhistory (
    history_id STRING PRIMARY KEY,
    plan_id STRING,
    customer_id STRING,
    from_instance STRING,
    to_instance STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    acted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4837featureinstancecustomerfeedbacksummaries (
    summary_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    aggregated_score FLOAT,
    summary_blob VARIANT,
    computed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4839featureinstancecustomerhealthscores (
    healthscore_id STRING PRIMARY KEY,
    customer_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    health_score FLOAT,
    metrics VARIANT,
    scored_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5131featureinstancedeployments (
    deploymentid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    versiontag STRING,
    initiatedby STRING,
    deployedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    status STRING,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5133featureinstancedeploymenthealthchecks (
    checkid STRING PRIMARY KEY,
    deploymentid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    checkname STRING,
    passed BOOLEAN,
    resultblob VARIANT,
    checkedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5135featureinstancedeploymentrollbackplans (
    planid STRING PRIMARY KEY,
    deploymentid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    rollbackspec VARIANT,
    createdby STRING,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    executedat TIMESTAMPLTZ,
    status STRING DEFAULT 'PENDING'
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5137featureinstancedeploymentrollbackhistory (
    historyid STRING PRIMARY KEY,
    planid STRING,
    deploymentid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    executedby STRING,
    executedat TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5139featureinstancefeaturetoggleconfigs (
    configid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    togglekey STRING,
    togglevalue STRING,
    effectivefrom TIMESTAMPLTZ,
    effectiveto TIMESTAMPLTZ,
    createdby STRING,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5141featureinstancetogglechangeaudit (
    auditid STRING PRIMARY KEY,
    configid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    previousvalue STRING,
    newvalue STRING,
    changedby STRING,
    reason VARIANT,
    changedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5143featureinstanceconfigdiffsnapshots (
    snapshotid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    configbefore VARIANT,
    configafter VARIANT,
    diffblob VARIANT,
    takenat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    taken_by STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5145featureinstanceruntimeerrors (
    errorid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    errorcode STRING,
    errormessage STRING,
    stacktrace VARIANT,
    observedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5147featureinstanceerrormitigationactions (
    actionid STRING PRIMARY KEY,
    errorid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    mitigationspec VARIANT,
    assignedto STRING,
    status STRING DEFAULT 'OPEN',
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    completedat TIMESTAMPLTZ,
    outcome VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5149featureinstanceerrormitigationhistory (
    historyid STRING PRIMARY KEY,
    actionid STRING,
    errorid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    executedby STRING,
    executedat TIMESTAMP_LTZ,
    status STRING,
    result VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5151featureinstancealertcorrelationrules (
    ruleid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    rulespec VARIANT,
    active BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5153featureinstancealertcorrelationresults (
    correlationid STRING PRIMARY KEY,
    ruleid STRING,
    correlatedalerts ARRAY,
    rootcauseref STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    correlated_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5231featureinstanceexplainabilityrecords (
    explainid STRING PRIMARY KEY,
    modelcallid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    explainblob VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5233featureinstancemodelcallprovenance (
    modelcallid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    modelid STRING,
    prompt VARIANT,
    response VARIANT,
    tokensused NUMBER,
    costestimate NUMBER,
    calledat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5235featureinstanceprivacyrequests (
    requestid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    subjectref STRING,
    requesttype STRING,
    details VARIANT,
    requestedby STRING,
    requestedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    processedat TIMESTAMP_LTZ,
    status STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5237featureinstanceprivacyrequestactions (
    actionid STRING PRIMARY KEY,
    requestid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    actiontype STRING,
    performedby STRING,
    performedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    result VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5239featureinstancepolicyexceptions (
    exceptionid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    policykey STRING,
    grantedto STRING,
    reason STRING,
    expiresat TIMESTAMP_LTZ,
    grantedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5241featureinstanceexceptionaudit (
    auditid STRING PRIMARY KEY,
    exceptionid STRING,
    instance_ref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    actedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5243featureinstancemodelapprovalrequests (
    approvalrequestid STRING PRIMARY KEY,
    instance_ref STRING,
    featurekey STRING,
    orgid STRING,
    modelid STRING,
    requestedby STRING,
    requestedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    status STRING DEFAULT 'PENDING',
    rationale VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5245featureinstancemodelapprovaldecisions (
    decisionid STRING PRIMARY KEY,
    approvalrequestid STRING,
    instance_ref STRING,
    featurekey STRING,
    orgid STRING,
    decidedby STRING,
    decidedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    approved BOOLEAN,
    notes VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5247featureinstancemodelapprovalaudit (
    auditid STRING PRIMARY KEY,
    decisionid STRING,
    approvalrequestid STRING,
    instance_ref STRING,
    featurekey STRING,
    orgid STRING,
    changesummary VARIANT,
    auditedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5249featureinstancepolicycompliancecertificates (
    certid STRING PRIMARY KEY,
    instance_ref STRING,
    featurekey STRING,
    orgid STRING,
    policykey STRING,
    certificate VARIANT,
    issuedby STRING,
    issuedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    expiresat TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen5251featureinstanceincidentpostmortemtemplates (
    templateid STRING PRIMARY KEY,
    incident_type STRING,
    instance_ref STRING,
    featurekey STRING,
    orgid STRING,
    template_body VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    last_updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4201_feature_instance_service_tokens (
    token_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    token_ref STRING,
    issued_to STRING,
    scopes ARRAY,
    expires_at TIMESTAMP_LTZ,
    issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4203_feature_instance_service_token_audit (
    audit_id STRING PRIMARY KEY,
    token_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4205_feature_instance_scheduled_health_checks (
    schedule_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    check_id STRING,
    next_run_at TIMESTAMP_LTZ,
    cadence_seconds INT,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4207_feature_instance_health_check_backoff_logs (
    backoff_id STRING PRIMARY KEY,
    check_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    consecutive_failures INT,
    backoff_until TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4209_feature_instance_alert_suppression_rules (
    rule_id STRING PRIMARY KEY,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    alert_types ARRAY,
    suppressed_from TIMESTAMP_LTZ,
    suppressed_to TIMESTAMP_LTZ,
    reason VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4211_feature_instance_alert_suppression_log (
    log_id STRING PRIMARY KEY,
    rule_id STRING,
    alert_id STRING,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    suppressed BOOLEAN,
    reason VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4213_feature_instance_cost_reallocation_requests (
    request_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    from_cost_center STRING,
    to_cost_center STRING,
    amount NUMBER,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4215_feature_instance_cost_reallocation_audit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    processed_by STRING,
    action STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4217_feature_instance_alert_annotation (
    annotation_id STRING PRIMARY KEY,
    alert_id STRING,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    author STRING,
    note VARIANT,
    annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4219_feature_instance_customer_attachment_retention (
    policy_id STRING PRIMARY KEY,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    retention_days INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4221_feature_instance_customer_attachment_purge_jobs (
    job_id STRING PRIMARY KEY,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    executed_at TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4223_feature_instance_customer_attachment_purge_history (
    history_id STRING PRIMARY KEY,
    job_id STRING,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    executed_at TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4225_feature_instance_customer_comms_templates (
    template_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4227_feature_instance_customer_comms_dispatch_queue (
    dispatch_id STRING PRIMARY KEY,
    template_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipients ARRAY,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4617_feature_instance_alert_runbooks (
    runbook_id STRING PRIMARY KEY,
    alert_id STRING,
    runbook_ref STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4619_feature_instance_scheduled_maintenance (
    maintenance_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_from TIMESTAMP_LTZ,
    scheduled_to TIMESTAMP_LTZ,
    description VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    status STRING DEFAULT 'SCHEDULED'
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4621_feature_instance_scheduled_maintenance_history (
    history_id STRING PRIMARY KEY,
    maintenance_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action_taken STRING,
    details VARIANT,
    acted_by STRING,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4623_feature_instance_change_requests (
    request_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    change_spec VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4625_feature_instance_change_request_audit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    notes VARIANT,
    acted_by STRING,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4627_feature_instance_config_locks (
    lock_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    locked_by STRING,
    lock_reason VARIANT,
    locked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    expires_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4629_feature_instance_config_lock_audit (
    audit_id STRING PRIMARY KEY,
    lock_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    previous_state VARIANT,
    new_state VARIANT,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4631_feature_instance_usage_heartbeat (
    heartbeat_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    last_seen_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4633_feature_instance_usage_snapshot (
    snapshot_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    usage_window_start TIMESTAMP_LTZ,
    usage_window_end TIMESTAMP_LTZ,
    usage_summary VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4635_feature_instance_snapshot_archive (
    archive_id STRING PRIMARY KEY,
    snapshot_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    storage_uri STRING,
    archived_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4637_feature_instance_access_logs (
    access_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    principal STRING,
    action STRING,
    target_ref STRING,
    details VARIANT,
    accessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4639_feature_instance_permission_requests (
    request_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    requested_permissions ARRAY,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4641_feature_instance_permission_audit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    previous_permissions VARIANT,
    new_permissions VARIANT,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4643_feature_instance_data_access_policies (
    policy_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    policy_definition VARIANT,
    effective_from TIMESTAMP_LTZ,
    effective_to TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4645_feature_instance_data_policy_violations (
    violation_id STRING PRIMARY KEY,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    violation_details VARIANT,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    resolved BOOLEAN DEFAULT FALSE,
    resolution_details VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4647_feature_instance_api_keys (
    api_key_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    key_ref STRING,
    owner STRING,
    scopes ARRAY,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    expires_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4649_feature_instance_api_key_audit (
    audit_id STRING PRIMARY KEY,
    api_key_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4651_feature_instance_secret_rotation_jobs (
    job_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    secret_ref STRING,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempted_at TIMESTAMP_LTZ,
    result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4653_feature_instance_secret_rotation_history (
    history_id STRING PRIMARY KEY,
    job_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    rotated_by STRING,
    rotated_at TIMESTAMP_LTZ,
    previous_ref STRING,
    new_ref STRING,
    notes VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_4655_feature_instance_service_account_mappings (
    mapping_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    service_account STRING,
    role_assigned STRING,
    mapped_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_archive_manifest (
    archive_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    compliance_packet_id STRING,
    stage_path STRING,
    file_size_bytes NUMBER,
    file_count INT,
    retention_tag STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_alert_correlation (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_architecture_diagrams (
    diagram_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    diagram_metadata VARIANT,
    storage_locator STRING,
    uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_bookmark_shares (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_communication_log (
    comm_id STRING PRIMARY KEY,
    incident_id STRING,
    channel STRING,
    participants ARRAY,
    message VARIANT,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_compliance_escrows (
    id STRING PRIMARY KEY,
    escrow_ref STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    bucket_uri STRING,
    retention_policy VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    last_verified_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_engineering_notes (
    note_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    body VARIANT,
    author STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_escalation_logs (
    log_id STRING PRIMARY KEY,
    escalation_id STRING,
    incident_id STRING,
    triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , triggered_by STRING, details VARIANT, outcome VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_escalation_notifications (
    id STRING PRIMARY KEY,
    incident_id STRING,
    escalation_level INT,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipients ARRAY,
    payload VARIANT,
    status STRING DEFAULT 'PENDING',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    sent_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_escalation_policies (
    escalation_id STRING PRIMARY KEY,
    name STRING,
    rules VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , active BOOLEAN DEFAULT TRUE );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_escrow_access_logs (
    id STRING PRIMARY KEY,
    escrow_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    accessed_by STRING,
    action STRING,
    access_details VARIANT,
    accessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_followup_task_updates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_alert_mappings (
    id STRING PRIMARY KEY,
    incident_id STRING,
    alert_id STRING,
    mapping_type STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    details VARIANT,
    mapped_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_bookmarks (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_comments (
    comment_id STRING PRIMARY KEY,
    incident_id STRING,
    parent_comment_id STRING,
    author STRING,
    body STRING,
    attachments VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , edited_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_comment_threads (
    thread_id STRING PRIMARY KEY,
    incident_id STRING,
    root_comment_id STRING,
    participant_list ARRAY,
    last_activity_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_contributors (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_cost_estimates (
    cost_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    estimated_cost NUMBER,
    currency STRING,
    estimate_breakdown VARIANT,
    estimated_by STRING,
    estimated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_escalation_state (
    id STRING PRIMARY KEY,
    incident_id STRING,
    current_level INT,
    last_escalated_at TIMESTAMP_LTZ,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    state_details VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_event_annotations (
    id STRING PRIMARY KEY,
    incident_id STRING,
    event_id STRING,
    annotation STRING,
    annotator STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    metadata VARIANT,
    annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_followups (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_followups_history (
    history_id STRING PRIMARY KEY,
    followup_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    action_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , snapshot VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_followup_reminders (
    id STRING PRIMARY KEY,
    incident_id STRING,
    followup_type STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_for TIMESTAMP_LTZ,
    payload VARIANT,
    status STRING DEFAULT 'SCHEDULED',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    fired_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_followup_tasks (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_metrics_definitions (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_metrics_snapshots (
    snapshot_id STRING PRIMARY KEY,
    incident_id STRING,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    metrics VARIANT,
    captured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instance_ref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_metric_samples (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_notes (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_note_edits (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_notifications (
    notification_id STRING PRIMARY KEY,
    incident_id STRING,
    notification_type STRING,
    recipient STRING,
    channel STRING,
    payload VARIANT,
    sent_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_notifications_config (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_notification_rate_limits (
    id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    window_seconds INT,
    max_notifications INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_notification_templates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_oncall_notifications (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    channel STRING,
    recipients ARRAY,
    status STRING DEFAULT 'PENDING',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    sent_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_ownership_history (
    history_id STRING PRIMARY KEY,
    incident_id STRING,
    previous_owner STRING,
    new_owner STRING,
    changed_by STRING,
    reason VARIANT,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instance_ref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_readiness_checks (
    id STRING PRIMARY KEY,
    incident_id STRING,
    check_name STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    check_spec VARIANT,
    result VARIANT,
    status STRING,
    executed_by STRING,
    executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_related_services (
    relsrv_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    service_name STRING,
    dependency_type STRING,
    notes VARIANT,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_reopen_audit (
    id STRING PRIMARY KEY,
    reopen_request_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_reopen_requests (
    id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ,
    processed_by STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_resolution_runs (
    id STRING PRIMARY KEY,
    resolution_template_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    run_parameters VARIANT,
    status STRING,
    result VARIANT,
    started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    finished_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_resolution_templates (
    id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    template VARIANT,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_root_cause_analysis (
    rca_id STRING PRIMARY KEY,
    incident_id STRING,
    hypothesis VARIANT,
    evidence VARIANT,
    concluded_by STRING,
    concluded_at TIMESTAMP_LTZ,
    rca_document VARIANT,
    org_id STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_root_cause_templates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_service_level_histories (
    id STRING PRIMARY KEY,
    incident_id STRING,
    service_level STRING,
    measured_value VARIANT,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_sla_breaches (
    breach_id STRING PRIMARY KEY,
    incident_id STRING,
    policy_id STRING,
    breached_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT, remedial_action VARIANT, resolved BOOLEAN DEFAULT FALSE, resolved_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_sla_policies (
    policy_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    target_seconds INT,
    escalation_policy_id STRING,
    active BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , config VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_summary_reports (
    report_id STRING PRIMARY KEY,
    incident_id STRING,
    title STRING,
    summary VARIANT,
    author STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , version INT DEFAULT 1, metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_summary_templates (
    id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    template VARIANT,
    language STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_summary_template_usages (
    id STRING PRIMARY KEY,
    template_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    used_by STRING,
    usage_context VARIANT,
    used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_tag_suggestions (
    id STRING PRIMARY KEY,
    incident_id STRING,
    suggested_tags ARRAY,
    score FLOAT,
    suggested_by STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_tasks (
    task_id STRING PRIMARY KEY,
    incident_id STRING,
    created_by STRING,
    assigned_to STRING,
    status STRING DEFAULT 'PENDING',
    task_type STRING,
    payload VARIANT,
    due_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_incident_task_comments (
    comment_id STRING PRIMARY KEY,
    task_id STRING,
    author STRING,
    body STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_maintenance_feedback (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_major_incident_communications (
    comm_id STRING PRIMARY KEY,
    incident_id STRING,
    declaration_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    channel STRING,
    audience STRING,
    message VARIANT,
    sent_by STRING,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_major_incident_declarations (
    declaration_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    declared_by STRING,
    declared_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , severity STRING, notes VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_manual_interventions (
    id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    intervention_type STRING,
    actor STRING,
    notes VARIANT,
    status STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    resolved_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_notification_preferences (
    pref_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    user_id STRING,
    channels ARRAY,
    -- e.g.,
    ['email',
    'slack'] preferences VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_operational_metrics (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_operational_runbooks (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_actions (
    action_id STRING PRIMARY KEY,
    postmortem_id STRING,
    description STRING,
    owner STRING,
    status STRING DEFAULT 'PENDING',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , completed_at TIMESTAMP_LTZ, evidence VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_action_priorities (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_dashboards (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_dashboard_views (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_followups (
    followup_id STRING PRIMARY KEY,
    action_id STRING,
    description STRING,
    owner STRING,
    status STRING DEFAULT 'OPEN',
    due_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , resolved_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_links (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_metrics (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_participants (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_readings (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_templates (
    template_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    template VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , last_used_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_template_usages (
    usage_id STRING PRIMARY KEY,
    template_id STRING,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    used_by STRING,
    used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_postmortem_timeline_events (
    event_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    event_time TIMESTAMP_LTZ,
    title STRING,
    details VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_rca_followups (
    followup_id STRING PRIMARY KEY,
    rca_id STRING,
    description STRING,
    owner STRING,
    status STRING DEFAULT 'OPEN',
    due_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , completed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_role_assignments (
    assignment_id STRING PRIMARY KEY,
    incident_id STRING,
    role STRING,
    principal STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , expires_at TIMESTAMP_LTZ, metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_root_cause_analysis_notes (
    note_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    note VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_runbook_change_audit (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_runbook_change_decisions (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_runbook_change_requests (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_service_level_report_subscribers (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_support_ticket_links (
    link_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    ticket_url STRING,
    external_ticket_id STRING,
    provider STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_feature_instance_timelines (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.docgen_slo_metrics (
    metric_id STRING PRIMARY KEY,
    org_id STRING,
    slo_name STRING,
    slo_window STRING,
    -- e.g.,
    '1d',
    '7d' p50 FLOAT,
    p90 FLOAT,
    p95 FLOAT,
    sample_count INT,
    measured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.document_embeddings (
    embedding_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    block_id STRING,
    model_id STRING,
    embedding VECTOR,
    embedding_norm FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    provenance VARIANT
) CLUSTER BY (org_id, document_id);


CREATE OR REPLACE TABLE AIFEATUREHUB.document_embeddings_v2 (
    embedding_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    section_id STRING,
    vector VARIANT,
    model_id STRING,
    provenance VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ) CLUSTER BY (org_id, document_id);


CREATE OR REPLACE TABLE AIFEATUREHUB.document_ingest_manifest (
    manifest_id STRING PRIMARY KEY,
    org_id STRING,
    producer_id STRING,
    batch_token STRING,
    status STRING DEFAULT 'PENDING',
    rows_expected NUMBER,
    rows_received NUMBER DEFAULT 0,
    provenance VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.document_section_tokens (
    token_row_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    section_id STRING,
    token_count NUMBER,
    model_hint STRING,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.doc_evidence_access_log (
    access_id STRING PRIMARY KEY,
    bundle_id STRING,
    document_id STRING,
    org_id STRING,
    accessed_by STRING,
    access_purpose STRING,
    access_context VARIANT,
    accessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    outcome STRING -- SUCCESS / DENIED / ERROR
);


CREATE OR REPLACE TABLE AIFEATUREHUB.doc_hash_index (
    hash_id STRING PRIMARY KEY,
    document_id STRING,
    org_id STRING,
    sha256_hex STRING,
    snapshot_version_id STRING,
    verified BOOLEAN DEFAULT FALSE,
    verified_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.doc_version_history (
    version_id STRING PRIMARY KEY,
    document_id STRING,
    org_id STRING,
    version_number STRING,
    snapshot_stage_path STRING,
    author STRING,
    change_summary STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    signature VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.embeddings_retention_policy (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    max_age_days INT,
    keep_provenance BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.embeddings_snapshot (
    snapshot_id STRING PRIMARY KEY,
    org_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    stats VARIANT,
    storage_location STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.embedding_quality_checks (
    check_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    block_id STRING,
    check_type STRING,
    result STRING,
    details VARIANT,
    checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.evidence_archive (
    archive_id STRING PRIMARY KEY,
    bundle_id STRING,
    archived_blob VARIANT,
    archived_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , archive_metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.EVIDENCE_BUNDLES (
    BUNDLE_ID STRING PRIMARY KEY,
    SOURCE_REF STRING,
    BUNDLE VARIANT,
    STAGE_URI STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.evidence_bundle_items (
    item_id STRING PRIMARY KEY,
    bundle_id STRING,
    org_id STRING,
    document_id STRING,
    item_type STRING,
    -- e.g.,
    'pdf',
    'cert',
    'audit_json' item_uri STRING,
    content_hash STRING,
    size_bytes NUMBER,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.evidence_export_queue (
    job_id STRING PRIMARY KEY,
    bundle_id STRING,
    org_id STRING,
    destination_stage STRING,
    scheduled_at TIMESTAMP_LTZ,
    attempts INT DEFAULT 0,
    max_attempts INT DEFAULT 5,
    last_attempt_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    -- QUEUED / RUNNING / FAILED / DONE result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.faiss_index_snapshots (
    snapshot_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    index_metadata VARIANT,
    stage_path STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.feature_store (
    feature_id STRING PRIMARY KEY,
    feature_key STRING,
    name STRING,
    description STRING,
    data_type STRING,
    owner STRING,
    tags ARRAY,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.index_retirement_queue (
    retirement_id STRING PRIMARY KEY,
    index_snapshot_id STRING,
    org_id STRING,
    reason STRING,
    queued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed BOOLEAN DEFAULT FALSE,
    processed_at TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.INFERENCE_PROVENANCE (
    PROVENANCE_ID STRING PRIMARY KEY,
    ORG_ID STRING,
    MODEL_ID STRING,
    INPUT_PAYLOAD VARIANT,
    OUTPUT_PAYLOAD VARIANT,
    TOKEN_USAGE VARIANT,
    COST_ESTIMATE NUMBER,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.ingest_checkpoint (
    checkpoint_id STRING PRIMARY KEY,
    pipeline_name STRING,
    last_processed_cursor VARIANT,
    last_updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.ingest_error_summary (
    summary_id STRING PRIMARY KEY,
    pipeline_name STRING,
    error_type STRING,
    occurrences NUMBER DEFAULT 0,
    first_seen TIMESTAMP_LTZ,
    last_seen TIMESTAMP_LTZ,
    sample_payload VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.invoice_archive (
    archive_id STRING PRIMARY KEY,
    invoice_id STRING,
    org_id STRING,
    invoice_payload VARIANT,
    archived_by STRING,
    archived_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.invoice_line_items (
    line_item_id STRING PRIMARY KEY,
    invoice_id STRING,
    description STRING,
    units NUMBER,
    unit_price FLOAT,
    amount FLOAT,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.model_drift_metrics (
  drift_id STRING PRIMARY KEY,
  model_id STRING,
  org_id STRING,
  dataset_snapshot_ref STRING,
  drift_score FLOAT,
  drift_type STRING, -- e.g., &quot;


CREATE OR REPLACE TABLE AIFEATUREHUB.model_registry (
  model_id STRING PRIMARY KEY,
  name STRING,
  version STRING,
  STAGE STRING, -- e.g., &quot;


CREATE OR REPLACE TABLE AIFEATUREHUB.model_registry_versions (
    record_id STRING PRIMARY KEY,
    model_id STRING,
    provider STRING,
    model_name STRING,
    model_version STRING,
    action STRING,
    changed_by STRING,
    change_reason STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.MODEL_TELEMETRY (
    telemetry_id STRING PRIMARY KEY,
    org_id STRING,
    model_id STRING,
    call_type STRING,
    latency_ms FLOAT,
    input_tokens INT,
    output_tokens INT,
    cost NUMBER(18,6
) ,  payload VARIANT,  recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AIFEATUREHUB.ops_maintenance_log (
    log_id STRING PRIMARY KEY,
    window_id STRING,
    description VARIANT,
    operator STRING,
    start_at TIMESTAMP_LTZ,
    end_at TIMESTAMP_LTZ,
    notes VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.parsed_content (
    content_id STRING PRIMARY KEY,
    org_id STRING,
    source_uri STRING,
    raw_text STRING,
    language STRING,
    parsed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.preview_cache_cleanup (
    cleanup_id STRING PRIMARY KEY,
    preview_id STRING,
    org_id STRING,
    scheduled_for TIMESTAMP_LTZ,
    executed_at TIMESTAMP_LTZ,
    status STRING,
    -- SCHEDULED / DONE / FAILED result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.preview_cache_index (
    preview_id STRING PRIMARY KEY,
    document_id STRING,
    org_id STRING,
    preview_uri STRING,
    ttl_seconds INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    expires_at TIMESTAMP_LTZ,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.producer_config (
    producer_id STRING PRIMARY KEY,
    org_id STRING,
    embedding_model_id STRING,
    batch_size NUMBER,
    concurrency INT,
    last_updated TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    config VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.prompt_template_hashmap (
    template_id STRING PRIMARY KEY,
    prompt_hash STRING,
    model_binding STRING,
    safe_mode BOOLEAN DEFAULT FALSE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , schema VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.query_provenance_link (
    link_id STRING PRIMARY KEY,
    query_id STRING,
    provenance_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.RATE_CARD_TIERS (
    tier_id STRING PRIMARY KEY,
    feature_key STRING,
    min_units NUMBER,
    max_units NUMBER,
    unit_price NUMBER(18,6
) ,  currency STRING,  effective_from TIMESTAMP_LTZ,  effective_to TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AIFEATUREHUB.RATE_RULES (
    RULE_ID STRING PRIMARY KEY,
    FEATURE_KEY STRING,
    RULE_TYPE STRING,
    CONFIG VARIANT,
    PRIORITY NUMBER,
    EFFECTIVE_FROM TIMESTAMP_LTZ,
    EFFECTIVE_TO TIMESTAMP_LTZ,
    ACTIVE BOOLEAN DEFAULT FALSE,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.RATE_RULES_APPROVAL_AUDIT (
    AUDIT_ID STRING PRIMARY KEY,
    STAGING_ID STRING,
    ACTION STRING,
    ACTOR STRING,
    ACTION_TS TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    DETAILS VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.RATE_RULES_STAGING (
    STAGING_ID STRING PRIMARY KEY,
    FEATURE_KEY STRING,
    RULE_TYPE STRING,
    CONFIG VARIANT,
    PRIORITY NUMBER DEFAULT 100,
    SUBMITTED_BY STRING,
    SUBMITTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    APPROVED BOOLEAN DEFAULT FALSE,
    APPROVED_BY STRING,
    APPROVED_AT TIMESTAMP_LTZ,
    REJECTED BOOLEAN DEFAULT FALSE,
    REJECT_REASON STRING,
    ARCHIVED BOOLEAN DEFAULT FALSE
);


CREATE OR REPLACE TABLE AIFEATUREHUB.rate_rule_templates (
    template_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    config_sample VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.RETENTION_POLICIES (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    object_type STRING,
    retention_days INT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.retention_policy_audit (
    audit_id STRING PRIMARY KEY,
    org_id STRING,
    previous_policy VARIANT,
    new_policy VARIANT,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    notes STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.retention_purge_jobs (
    job_id STRING PRIMARY KEY,
    policy_id STRING,
    org_id STRING,
    target_scope VARIANT,
    checkpoint VARIANT,
    queued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    started_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    -- QUEUED / RUNNING / PAUSED / COMPLETED / FAILED result VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.retrieval_cache_metrics (
    metric_id STRING PRIMARY KEY,
    org_id STRING,
    query_hash STRING,
    topk_results VARIANT,
    p95_latency_ms FLOAT,
    avg_latency_ms FLOAT,
    cost_estimate FLOAT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.role_account_mapping (
    mapping_id STRING PRIMARY KEY,
    account_id STRING,
    role_name STRING,
    allowed_tenants ARRAY,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.schema_versions (
    version_id STRING PRIMARY KEY,
    component STRING,
    migration_script STRING,
    applied_by STRING,
    applied_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    notes STRING
);


CREATE OR REPLACE TABLE AIFEATUREHUB.section_vector_hash (
    vector_hash STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    section_id STRING,
    model_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.semantic_index_health (
    check_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    recall FLOAT,
    precision FLOAT,
    last_check TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.semantic_index_maintenance_logs (
    maintenance_id STRING PRIMARY KEY,
    index_id STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    performed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.semantic_index_stats_hist LIKE AIFEATUREHUB.semantic_index_stats;


CREATE OR REPLACE TABLE AIFEATUREHUB.semantic_query_logs (
    log_id STRING PRIMARY KEY,
    org_id STRING,
    query_hash STRING,
    query_params VARIANT,
    latency_ms FLOAT,
    topk_results VARIANT,
    cost_estimate FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.semantic_search_cost_estimate (
    estimate_id STRING PRIMARY KEY,
    org_id STRING,
    query_pattern STRING,
    avg_cost FLOAT,
    avg_latency_ms FLOAT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.similarity_query_logs (
    query_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    query_vector VARIANT,
    top_k NUMBER,
    returned_count NUMBER,
    latency_ms FLOAT,
    error_variant VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.similarity_results (
    result_id STRING PRIMARY KEY,
    query_id STRING,
    embedding_id STRING,
    score FLOAT,
    rank INT,
    returned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AIFEATUREHUB.similarity_retry_policy (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    max_retries INT,
    base_backoff_seconds INT,
    max_backoff_seconds INT,
    jitter BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.subscription_invoices (
    invoice_id STRING PRIMARY KEY,
    org_id STRING,
    billing_period_start DATE,
    billing_period_end DATE,
    total_amount NUMBER,
    currency STRING,
    status STRING,
    -- DRAFT / FINAL / PAID created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    finalized_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AIFEATUREHUB.tenant_configuration (
    config_id STRING PRIMARY KEY,
    org_id STRING,
    config_key STRING,
    config_value VARIANT,
    effective_from TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    effective_to TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.tenant_feature_usage (
    usage_id STRING PRIMARY KEY,
    org_id STRING,
    account_id STRING,
    feature_key STRING,
    instance_ref STRING,
    usage_type STRING,
    amount NUMBER,
    event_time TIMESTAMP_LTZ,
    metadata VARIANT
) CLUSTER BY (account_id);


CREATE OR REPLACE TABLE AIFEATUREHUB.USAGE_ANOMALIES (
    anomaly_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    detection_score FLOAT,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    sample_payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.usage_events_detailed (
    usage_id STRING PRIMARY KEY,
    org_id STRING,
    feature_code STRING,
    model_id STRING,
    tokens NUMBER,
    cost FLOAT,
    event_time TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , meta VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.usage_quota_definitions (
    quota_id STRING PRIMARY KEY,
    org_id STRING,
    feature_code STRING,
    monthly_quota NUMBER,
    overage_allowed BOOLEAN DEFAULT FALSE,
    overage_rate FLOAT,
    currency STRING DEFAULT 'USD',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.usage_reservations (
    reservation_id STRING PRIMARY KEY,
    org_id STRING,
    feature_code STRING,
    units_reserved NUMBER,
    reserved_by STRING,
    reserved_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , ttl_seconds INT DEFAULT 300, status STRING DEFAULT 'ACTIVE', metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.vector_gc_candidates (
    candidate_id STRING PRIMARY KEY,
    org_id STRING,
    embedding_row_id STRING,
    model_id STRING,
    reason STRING,
    preserve_provenance BOOLEAN DEFAULT TRUE,
    marked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.vector_store_snapshots (
    snapshot_id STRING PRIMARY KEY,
    index_id STRING,
    snapshot_path STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AIFEATUREHUB.v_billing_run_summary (
    run_id STRING PRIMARY KEY,
    org_id STRING,
    billed_total FLOAT,
    run_start TIMESTAMP_LTZ,
    run_end TIMESTAMP_LTZ,
    status STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AIFEATUREHUB.warehouse_configs (
    config_id STRING PRIMARY KEY,
    name STRING,
    min_size STRING,
    max_size STRING,
    auto_suspend_seconds INT,
    auto_resume BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ACCOUNTS (
    account_id STRING PRIMARY KEY,
    name STRING,
    integration_key_hash VARIANT,
    integration_status STRING DEFAULT 'PENDING',
    default_markup_percent NUMBER(5,2
) DEFAULT 0, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), contact_info VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ACCOUNT_FEATURE_PRICING (
    account_id STRING,
    feature_key STRING,
    base_price_per_unit NUMBER(18,6
) , markup_pct NUMBER(5,2), effective_from TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), effective_to TIMESTAMP_LTZ, PRIMARY KEY (account_id, feature_key, effective_from) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ACCOUNT_FEATURE_PRICING_HISTORY (
    record_id STRING PRIMARY KEY,
    account_id STRING,
    feature_key STRING,
    effective_from DATE,
    effective_to DATE,
    pricing_payload VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ACCOUNT_MARKUP (
    ACCOUNT_ID STRING,
    DEFAULT_MARKUP_PCT NUMBER(9,4
) ,EFFECTIVE_FROM TIMESTAMP_LTZ,EFFECTIVE_TO TIMESTAMP_LTZ,UPDATED_BY STRING,UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),PRIMARY KEY(ACCOUNT_ID, EFFECTIVE_FROM));


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ACTIVATION_AUDIT (
    ACT_ID STRING PRIMARY KEY,
    ADMIN_USER STRING,
    ACCOUNT_ID STRING,
    FEATURE_KEY STRING,
    ACTION STRING,
    EFFECTIVE_FROM TIMESTAMP_LTZ,
    DETAILS VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.admin_audit (
    audit_id STRING PRIMARY KEY,
    actor STRING,
    action_type STRING,
    target_object STRING,
    target_id STRING,
    details VARIANT,
    success BOOLEAN,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ADMIN_PRICING_AUDIT (
    AUDIT_ID STRING AUTOGENERATED,
    ACCOUNT_ID STRING,
    FEATURE_KEY STRING,
    OLD_MARKUP_PCT NUMBER(10,4
) ,NEW_MARKUP_PCT NUMBER(10,4),EFFECTIVE_FROM TIMESTAMP_LTZ,CHANGED_BY STRING,CHANGED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),NOTE STRING,PRIMARY KEY (AUDIT_ID));


CREATE OR REPLACE TABLE AI_FEATURE_HUB.agent_plans (
    plan_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    agent_name STRING,
    plan_steps VARIANT,
    conclusion VARIANT,
    confidence FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.AI_PROCESSING_LOG (
    LOG_ID STRING PRIMARY KEY,
    MODEL_ID STRING,
    REQUEST_ID STRING,
    PROCESSING_TIME_MS NUMBER,
    STATUS STRING,
    METADATA VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ALERTS (
    alert_id STRING PRIMARY KEY,
    name STRING,
    details VARIANT,
    level STRING,
    acked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , acked_at TIMESTAMP_LTZ, metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ALERT_CONFIG (
    ALERT_ID STRING PRIMARY KEY,
    NAME STRING,
    QUERY_TEXT STRING,
    SEVERITY STRING,
    ENABLED BOOLEAN DEFAULT TRUE,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ANNOTATED_CLAUSES (
    clause_id STRING PRIMARY KEY,
    ORG_ID STRING,
    title STRING,
    body STRING,
    risk_level STRING,
    jurisdictions ARRAY,
    tags ARRAY,
    version INT,
    provenance VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_autoheal_events (
    event_id STRING PRIMARY KEY,
    node_id STRING,
    index_id STRING,
    event_type STRING,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  action_taken STRING,  outcome STRING,  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_autoscale_actions (
    action_id STRING PRIMARY KEY,
    container_name STRING,
    recommended_action STRING,
    recommended_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,    approved BOOLEAN DEFAULT FALSE,    approved_by STRING,    approved_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_build_jobs (
    job_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    job_type STRING,
    -- FULL / INCREMENTAL status STRING DEFAULT ’QUEUED’,
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ANN_BUILD_LOGS (
    BUILD_LOG_ID STRING PRIMARY KEY,
    JOB_ID STRING,
    INDEX_ID STRING,
    ORG_ID STRING,
    SHARDS_PROCESSED INT,
    DURATION_SEC FLOAT,
    ERROR_MESSAGE STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_capacity_forecast (
    forecast_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    forecast_window_start TIMESTAMP_LTZ,
    forecast_window_end TIMESTAMP_LTZ,
    predicted_qps FLOAT,
    predicted_peak_nodes INT,
    generated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , model_version STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_cost_allocation (
    allocation_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    billing_period_start TIMESTAMP_LTZ,
    billing_period_end TIMESTAMP_LTZ,
    cost_center STRING,
    allocated_cost NUMBER,
    details VARIANT,
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_deployment_history (
    deployment_id STRING PRIMARY KEY,
    node_id STRING,
    index_id STRING,
    version STRING,
    deployed_by STRING,
    deployed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING, notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_healthcheck_history (
    hc_id STRING PRIMARY KEY,
    index_snapshot_id STRING,
    qps FLOAT,
    p50_latency_ms FLOAT,
    p95_latency_ms FLOAT,
    correctness_sample_score FLOAT,
    checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_build_log (
    log_id STRING PRIMARY KEY,
    build_request_id STRING,
    step_name STRING,
    message STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_build_queue (
    build_request_id STRING PRIMARY KEY,
    org_id STRING,
    index_alias STRING,
    snapshot_source STRING,
    priority INT DEFAULT 100,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_compatibility_matrix (
    matrix_id STRING PRIMARY KEY,
    index_id STRING,
    engine_version STRING,
    supported_shard_sizes ARRAY,
    supported_vector_dims ARRAY,
    validated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_config_overrides (
    override_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    config_key STRING,
    config_value VARIANT,
    effective_from TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , effective_to TIMESTAMP_LTZ, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_manifest (
    index_id STRING PRIMARY KEY,
    org_id STRING,
    index_alias STRING,
    schema_id STRING,
    snapshot_id STRING,
    node_config VARIANT,
    status STRING,
    last_built_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_metadata (
    index_id STRING PRIMARY KEY,
    org_id STRING,
    engine STRING,
    -- FAISS/Annoy/Native metric STRING,
    dims INT,
    shard_count INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_metrics_aggregates (
    aggregate_id STRING PRIMARY KEY,
    index_id STRING,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    qps_avg FLOAT,
    latency_p50 FLOAT,
    latency_p95 FLOAT,
    anomaly_score FLOAT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_scaling_history (
    scale_event_id STRING PRIMARY KEY,
    index_id STRING,
    previous_replicas INT,
    new_replicas INT,
    triggered_by STRING,
    triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , reason STRING, details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_shards (
    shard_id STRING PRIMARY KEY,
    index_id STRING,
    shard_path STRING,
    host_hint STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_snapshots (
    snapshot_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    snapshot_path STRING,
    size_bytes NUMBER,
    vector_count NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    retired_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_node_health_history (
    history_id STRING PRIMARY KEY,
    node_id STRING,
    cpu_percent FLOAT,
    mem_percent FLOAT,
    disk_percent FLOAT,
    last_heartbeat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_node_maintenance_windows (
    window_id STRING PRIMARY KEY,
    node_id STRING,
    start_at TIMESTAMP_LTZ,
    end_at TIMESTAMP_LTZ,
    reason STRING,
    scheduled_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING DEFAULT 'SCHEDULED');


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_node_registry (
    node_id STRING PRIMARY KEY,
    host STRING,
    port INT,
    capacity NUMBER,
    last_heartbeat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT,  status STRING DEFAULT 'ACTIVE');


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_rate_limits (
    org_id STRING PRIMARY KEY,
    max_qps FLOAT,
    max_concurrency INT,
    last_updated TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_rebalance_operations (
    operation_id STRING PRIMARY KEY,
    index_id STRING,
    target_shard_count INT,
    initiated_by STRING,
    initiated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  completed_at TIMESTAMP_LTZ,  status STRING DEFAULT 'PENDING',  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_scaling_policies (
    policy_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    min_replicas INT,
    max_replicas INT,
    scale_up_threshold FLOAT,
    scale_down_threshold FLOAT,
    cool_down_seconds INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_scaling_recommendations (
    recommendation_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    recommended_replicas INT,
    confidence FLOAT,
    suggested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  generated_by STRING,  rationale VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_shard_capacity (
    capacity_id STRING PRIMARY KEY,
    shard_id STRING,
    index_id STRING,
    total_slots INT,
    used_slots INT DEFAULT 0,
    available_slots INT AS (total_slots - used_slots
) , last_updated TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_shard_maintenance_actions (
    action_id STRING PRIMARY KEY,
    shard_id STRING,
    index_id STRING,
    action_type STRING,
    initiated_by STRING,
    initiated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  completed_at TIMESTAMP_LTZ,  status STRING DEFAULT 'REQUESTED',  outcome VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_shard_repair_logs (
    repair_id STRING PRIMARY KEY,
    shard_id STRING,
    index_id STRING,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  repaired_at TIMESTAMP_LTZ,  status STRING DEFAULT 'REPORTED',  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_telemetry_events (
    event_id STRING PRIMARY KEY,
    node_id STRING,
    index_id STRING,
    event_type STRING,
    payload VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.API_AUDIT (
    AUDIT_ID STRING PRIMARY KEY,
    API_NAME STRING,
    REQUEST_PAYLOAD VARIANT,
    RESPONSE_PAYLOAD VARIANT,
    STATUS STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.api_keys (
    key_id STRING PRIMARY KEY,
    org_id STRING,
    key_hash STRING,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.api_key_rotation_log (
    rotation_id STRING PRIMARY KEY,
    key_id STRING,
    org_id STRING,
    rotated_by STRING,
    previous_hash STRING,
    new_hash STRING,
    rotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    notes VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.archival_policy_rules (
    rule_id STRING PRIMARY KEY,
    org_id STRING NOT NULL,
    object_scope STRING,
    retention_days INT,
    hold_flag BOOLEAN DEFAULT FALSE,
    export_before_delete BOOLEAN DEFAULT FALSE,
    last_evaluated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ARCHIVE_JOBS (
    job_id STRING PRIMARY KEY,
    object_type STRING,
    query STRING,
    archive_stage STRING,
    status STRING DEFAULT 'PENDING',
    run_at TIMESTAMP_LTZ,
    last_run_at TIMESTAMP_LTZ,
    result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.archive_restore_requests (
    request_id STRING PRIMARY KEY,
    archive_id STRING,
    requested_by STRING,
    org_id STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING DEFAULT 'REQUESTED', started_at TIMESTAMP_LTZ, completed_at TIMESTAMP_LTZ, details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.assembly_job_history (
    assembly_job_id STRING PRIMARY KEY,
    org_id STRING,
    input_payload VARIANT,
    result_hash STRING,
    worker_id STRING,
    status STRING,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    error_details VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.backup_manifest (
    backup_id STRING PRIMARY KEY,
    table_name STRING,
    export_stage_path STRING,
    backup_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  checksum STRING,  initiated_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_ADJUSTMENT_LOG (
    adjustment_id STRING PRIMARY KEY,
    invoice_id STRING,
    account_id STRING,
    amount NUMBER,
    reason STRING,
    adjusted_by STRING,
    adjusted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  audit_payload VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_AUDIT (
    audit_id STRING PRIMARY KEY,
    invoice_id STRING,
    event_type STRING,
    details VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_LINE_ITEM (
    LINE_ITEM_ID STRING AUTOGENERATED,
    BILLING_RUN_ID STRING,
    ACCOUNT_ID STRING,
    FEATURE_KEY STRING,
    UNITS NUMBER,
    BASE_COST NUMBER,
    MARKUP_PCT NUMBER(10,4
) ,MARKUP_AMOUNT NUMBER(18,6),LINE_TOTAL NUMBER(18,6),PRIMARY KEY (LINE_ITEM_ID));


CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_RECONCILIATION_RUNS (
    run_id STRING PRIMARY KEY,
    invoice_id STRING,
    reconciled BOOLEAN DEFAULT FALSE,
    discrepancy VARIANT,
    run_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_RUN (
    BILLING_RUN_ID STRING AUTOGENERATED,
    ACCOUNT_ID STRING,
    RUN_TS TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,PERIOD_FROM TIMESTAMP_LTZ,PERIOD_TO TIMESTAMP_LTZ,RUN_BY STRING,PREVIEW_FLAG BOOLEAN,INVOICE_HASH STRING,TOTAL_AMOUNT NUMBER(18,6),PRIMARY KEY (BILLING_RUN_ID));


CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_RUNS (
    run_id STRING PRIMARY KEY,
    run_type STRING,
    -- PREVIEW / FINAL started_by STRING,
    started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  completed_at TIMESTAMP_LTZ,  status STRING,  result_payload VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_RUN_AUDIT (
    RUN_ID STRING PRIMARY KEY,
    INVOICE_HASH STRING,
    ACCOUNT_ID STRING,
    PREVIEW_JSON VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_RUN_ITEMS (
    item_id STRING PRIMARY KEY,
    run_id STRING,
    account_id STRING,
    feature_key STRING,
    units NUMBER,
    unit_price NUMBER,
    line_amount NUMBER,
    currency STRING,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.CLAUSE_BLOCKS (
    CLAUSE_ID STRING PRIMARY KEY,
    PARSED_ID STRING,
    CLAUSE_TEXT STRING,
    START_OFF INT,
    END_OFF INT,
    METADATA VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.CLAUSE_CITATION_LINKS (
    link_id STRING PRIMARY KEY,
    clause_id STRING,
    source_doc_id STRING,
    source_section_id STRING,
    confidence FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.Clause_Library (
    clause_id STRING PRIMARY KEY,
    name STRING,
    jurisdiction STRING,
    content VARIANT,
    version STRING,
    tags VARIANT,
    parsed_blocks VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.compliance_packet_schema (
    schema_id STRING PRIMARY KEY,
    org_id STRING,
    schema_version STRING,
    schema_definition VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.compliance_packet_store (
    packet_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    exported_stage_path STRING,
    packet_hash STRING,
    exported_by STRING,
    exported_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.evidence_snapshot_archive ( snapshot_id STRING PRIMARY KEY, org_id STRING, document_id STRING, evidence_stage_path STRING, snapshot_hash STRING, retention_until TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.backup_manifest ( backup_id STRING PRIMARY KEY, table_name STRING, export_stage_path STRING, backup_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), checksum STRING, initiated_by STRING ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.ingest_monitoring_checks ( check_id STRING PRIMARY KEY, pipeline_name STRING, last_success TIMESTAMP_LTZ, last_error_ts TIMESTAMP_LTZ, status STRING, details VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_cache_eviction_log ( evict_id STRING PRIMARY KEY, cache_key STRING, org_id STRING, reason STRING, evicted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_cache_metrics ( metric_id STRING PRIMARY KEY, cache_key STRING, org_id STRING, hit BOOLEAN, access_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.llm_prompt_audit ( prompt_id STRING PRIMARY KEY, org_id STRING, model_id STRING, prompt_hash STRING, prompt_length INT, metadata VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.llm_response_audit ( response_id STRING PRIMARY KEY, prompt_id STRING, response_hash STRING, model_confidence VARIANT, metadata VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_maintenance_queue ( queue_id STRING PRIMARY KEY, index_id STRING, operation STRING, payload VARIANT, queued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), processed BOOLEAN DEFAULT FALSE
) AI_FEATURE_HUB.ACTIVATION_AUDITCREATE OR REPLACE TABLE AI_FEATURE_HUB.ACTIVATION_AUDIT (ACT_ID STRING PRIMARY KEY,ADMIN_USER STRING,ACCOUNT_ID STRING,ORG_ID STRING,FEATURE_KEY STRING,ACTION STRING,EFFECTIVE_FROM TIMESTAMP_LTZ,DETAILS VARIANT,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AI_FEATURE_HUB.COST_ALLOCATION_TAGS (
    tag_key VARCHAR,
    tag_value VARCHAR,
    snowflake_role VARCHAR,
    description VARCHAR
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.COST_BUDGETS (
    budget_id VARCHAR,
    entity_type VARCHAR,
    entity_name VARCHAR,
    monthly_budget_usd FLOAT,
    is_active BOOLEAN
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.data_lineage (
    lineage_id STRING PRIMARY KEY,
    source_object STRING,
    target_object STRING,
    transformation_description STRING,
    executed_by STRING,
    executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.DATA_QUALITY_LOG (
    LOG_ID STRING PRIMARY KEY,
    CHECK_NAME STRING,
    STATUS STRING,
    DETAILS VARIANT,
    CHECKED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.deployment_prereq_checks (
    check_id STRING PRIMARY KEY,
    check_name STRING,
    passed BOOLEAN,
    details VARIANT,
    checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4201featureinstanceservicetokens (
    tokenid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    tokenref STRING,
    issuedto STRING,
    scopes ARRAY,
    expiresat TIMESTAMP_LTZ,
    issuedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4201_feature_instance_service_tokens (
    token_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    token_ref STRING,
    issued_to STRING,
    scopes ARRAY,
    expires_at TIMESTAMP_LTZ,
    issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4203featureinstanceservicetokenaudit (
    auditid STRING PRIMARY KEY,
    tokenid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    actedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4203featureinstance_service_token_audit (
    audit_id STRING PRIMARY KEY,
    token_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4203_feature_instance_service_token_audit (
    audit_id STRING PRIMARY KEY,
    token_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4205featureinstancescheduledhealthchecks (
    scheduleid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    checkid STRING,
    nextrunat TIMESTAMP_LTZ,
    cadenceseconds INT,
    enabled BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4205featureinstance_scheduled_health_checks (
    schedule_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    check_id STRING,
    next_run_at TIMESTAMP_LTZ,
    cadence_seconds INT,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4205_feature_instance_scheduled_health_checks (
    schedule_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    check_id STRING,
    next_run_at TIMESTAMP_LTZ,
    cadence_seconds INT,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4207featureinstancehealthcheckbackofflogs (
    backoffid STRING PRIMARY KEY,
    checkid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    consecutivefailures INT,
    backoffuntil TIMESTAMP_LTZ,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4207featureinstance_health_check_backoff_logs (
    backoff_id STRING PRIMARY KEY,
    check_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    consecutive_failures INT,
    backoff_until TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4207_feature_instance_health_check_backoff_logs (
    backoff_id STRING PRIMARY KEY,
    check_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    consecutive_failures INT,
    backoff_until TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4209featureinstancealertsuppressionrules (
    ruleid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    alerttypes ARRAY,
    suppressedfrom TIMESTAMP_LTZ,
    suppressedto TIMESTAMP_LTZ,
    reason VARIANT,
    createdby STRING,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4209featureinstance_alert_suppression_rules (
    rule_id STRING PRIMARY KEY,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    alert_types ARRAY,
    suppressed_from TIMESTAMP_LTZ,
    suppressed_to TIMESTAMP_LTZ,
    reason VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4209_feature_instance_alert_suppression_rules (
    rule_id STRING PRIMARY KEY,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    alert_types ARRAY,
    suppressed_from TIMESTAMP_LTZ,
    suppressed_to TIMESTAMP_LTZ,
    reason VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4211featureinstancealertsuppressionlog (
    logid STRING PRIMARY KEY,
    ruleid STRING,
    alertid STRING,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    evaluatedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  suppressed BOOLEAN,  reason VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4211featureinstance_alert_suppression_log (
    log_id STRING PRIMARY KEY,
    rule_id STRING,
    alert_id STRING,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , suppressed BOOLEAN, reason VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4211_feature_instance_alert_suppression_log (
    log_id STRING PRIMARY KEY,
    rule_id STRING,
    alert_id STRING,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , suppressed BOOLEAN, reason VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4213featureinstancecostreallocationrequests (
    requestid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requestedby STRING,
    fromcostcenter STRING,
    tocostcenter STRING,
    amount NUMBER,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requestedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  processedat TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4213featureinstance_cost_reallocation_requests (
    request_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    from_cost_center STRING,
    to_cost_center STRING,
    amount NUMBER,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , processed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4213_feature_instance_cost_reallocation_requests (
    request_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    from_cost_center STRING,
    to_cost_center STRING,
    amount NUMBER,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , processed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4215featureinstancecostreallocationaudit (
    auditid STRING PRIMARY KEY,
    requestid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    processedby STRING,
    action STRING,
    notes VARIANT,
    actedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4215featureinstance_cost_reallocation_audit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    processed_by STRING,
    action STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4215_feature_instance_cost_reallocation_audit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    processed_by STRING,
    action STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4217featureinstancealertannotation (
    annotationid STRING PRIMARY KEY,
    alertid STRING,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    author STRING,
    note VARIANT,
    annotatedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4217featureinstance_alert_annotation (
    annotation_id STRING PRIMARY KEY,
    alert_id STRING,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    author STRING,
    note VARIANT,
    annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4217_feature_instance_alert_annotation (
    annotation_id STRING PRIMARY KEY,
    alert_id STRING,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    author STRING,
    note VARIANT,
    annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4219featureinstancecustomerattachmentretention (
    policyid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    retentiondays INT,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4219featureinstance_customer_attachment_retention (
    policy_id STRING PRIMARY KEY,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    retention_days INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4219_feature_instance_customer_attachment_retention (
    policy_id STRING PRIMARY KEY,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    retention_days INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4221featureinstancecustomerattachmentpurgejobs (
    jobid STRING PRIMARY KEY,
    policyid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    scheduledat TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    executedat TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4221featureinstance_customer_attachment_purge_jobs (
    job_id STRING PRIMARY KEY,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    executed_at TIMESTAMP_LTZ,
    result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4221_feature_instance_customer_attachment_purge_jobs (
    job_id STRING PRIMARY KEY,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    executed_at TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4223featureinstancecustomerattachmentpurgehistory (
    historyid STRING PRIMARY KEY,
    jobid STRING,
    policyid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    executedat TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4223featureinstance_customer_attachment_purge_history (
    history_id STRING PRIMARY KEY,
    job_id STRING,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    executed_at TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4223_feature_instance_customer_attachment_purge_history (
    history_id STRING PRIMARY KEY,
    job_id STRING,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    executed_at TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4225featureinstancecustomercommstemplates (
    templateid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    name STRING,
    template VARIANT,
    updatedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4225featureinstance_customer_comms_templates (
    template_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4225_feature_instance_customer_comms_templates (
    template_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4227featureinstancecustomercommsdispatchqueue (
    dispatch_id STRING PRIMARY KEY,
    template_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipients ARRAY,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4229featureinstancecustomercommsdeliverylog ( delivery_id STRING PRIMARY KEY, dispatch_id STRING, template_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, recipient STRING, provider_response VARIANT, delivered_at TIMESTAMP_LTZ, status STRING ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.MODEL_DRIFT_METRICS ( drift_id STRING PRIMARY KEY, model_id STRING, metric_name STRING, metric_value NUMBER, baseline_value NUMBER, drift_score NUMBER, check_timestamp TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.BILLING_AUDIT ( AUDIT_ID STRING PRIMARY KEY, INVOICE_ID STRING, EVENT_TYPE STRING, DETAILS VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.INFERENCE_PROVENANCE ( PROV_ID STRING PRIMARY KEY, REQUEST_ID STRING, MODEL_ID STRING, INPUT VARIANT, OUTPUT VARIANT, TOKENS NUMBER, CONFIDENCE NUMBER, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
) CREATE OR REPLACE TABLE AI_FEATURE_HUB.PARSED_CONTENT (PARSED_ID STRING PRIMARY KEY, DOCUMENT_ID STRING, ORG_ID STRING, PAGE_NUMBER INT, TEXT_CONTENT STRING, MODALITY STRING, CONFIDENCE FLOAT, RAW_PAYLOAD VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4227featureinstance_customer_comms_dispatch_queue (
    dispatch_id STRING PRIMARY KEY,
    template_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipients ARRAY,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4227_feature_instance_customer_comms_dispatch_queue (
    dispatch_id STRING PRIMARY KEY,
    template_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipients ARRAY,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4229featureinstancecustomercommsdeliverylog (
    deliveryid STRING PRIMARY KEY,
    dispatchid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    recipient STRING,
    status STRING,
    attemptedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4229featureinstance_customer_comms_delivery_log (
    delivery_id STRING PRIMARY KEY,
    dispatch_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipient STRING,
    status STRING,
    attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4229_feature_instance_customer_comms_delivery_log (
    delivery_id STRING PRIMARY KEY,
    dispatch_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipient STRING,
    status STRING,
    attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4231featureinstanceapiusagequotas (
    quotaid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    limitperminute INT,
    limitperhour INT,
    limitperday INT,
    enforced BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4231featureinstance_api_usage_quotas (
    quota_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    max_requests NUMBER,
    window_seconds INT,
    enforcement_mode STRING DEFAULT 'LENIENT',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4231_feature_instance_api_usage_quotas (
    quota_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    limit_per_minute INT,
    limit_per_hour INT,
    limit_per_day INT,
    enforced BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4233featureinstanceapiquotaviolations (
    violationid STRING PRIMARY KEY,
    quotaid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    observedcount NUMBER,
    detectedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4233_feature_instance_api_quota_violations (
    violation_id STRING PRIMARY KEY,
    quota_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    observed_count INT,
    period_start TIMESTAMP_LTZ,
    period_end TIMESTAMP_LTZ,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4235_feature_instance_feature_flags (
    flag_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    flag_key STRING,
    enabled BOOLEAN,
    criteria VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_by STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4237_feature_instance_flag_evaluation_logs (
    eval_id STRING PRIMARY KEY,
    flag_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    target_ref STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , result BOOLEAN, context VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4243featureinstancemaintenancechecklists (
    checklistid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    items VARIANT,
    version INT,
    updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4245featureinstancemaintenanceexecutions (
    executionid STRING PRIMARY KEY,
    checklistid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    executedby STRING,
    itemresults VARIANT,
    executedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4247featureinstancemaintenancefollowups (
    followupid STRING PRIMARY KEY,
    executionid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    description STRING,
    assignedto STRING,
    status STRING DEFAULT 'OPEN',
    dueat TIMESTAMPLTZ,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4249featureinstancemaintenancefollowupupdates (
    updateid STRING PRIMARY KEY,
    followupid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    comment STRING,
    updatedby STRING,
    updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4251featureinstanceschedulingconstraints (
    constraintid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    constraintblob VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4253featureinstanceschedulingconflictlogs (
    conflictid STRING PRIMARY KEY,
    constraintid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    detectedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    conflict_details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4255featureinstancemetadatacatalog (
    schemaid STRING PRIMARY KEY,
    featurekey STRING,
    orgid STRING,
    schemablob VARIANT,
    version INT,
    registeredat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4317featureinstancedynamicriskscores (
    scoreid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    riskscore FLOAT,
    drivers VARIANT,
    computedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4319featureinstanceriskalerts (
    alertid STRING PRIMARY KEY,
    scoreid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    riskscore FLOAT,
    threshold FLOAT,
    message VARIANT,
    triggeredat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    acknowledged BOOLEAN DEFAULT FALSE
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4321featureinstanceconfigurationchangerequests (
    requestid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requestedby STRING,
    configpayload VARIANT,
    status STRING DEFAULT 'PENDING',
    requestedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    processedat TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4323featureinstanceconfigurationchangeaudit (
    auditid STRING PRIMARY KEY,
    requestid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    processedby STRING,
    action STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4325featureinstanceexperimentalfeaturesregistry (
    regid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    experimentalfeaturekey STRING,
    enabled BOOLEAN DEFAULT FALSE,
    enabledby STRING,
    enabledat TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4327featureinstanceexperimentfeedback (
    feedbackid STRING PRIMARY KEY,
    regid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    userid STRING,
    feedback VARIANT,
    submittedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4329featureinstanceexperimentsummaryreports (
    reportid STRING PRIMARY KEY,
    regid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    summaryblob VARIANT,
    generatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4331featureinstancefeatureusagemeters (
    meterid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    meterspec VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4333featureinstancefeatureusagemeasurements (
    measurementid STRING PRIMARY KEY,
    meterid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    measuredat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    value NUMBER,
    dimensions VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4335featureinstancebillinginvoices (
    invoiceid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    customerid STRING,
    invoice_date TIMESTAMPLTZ,
    due_date TIMESTAMPLTZ,
    total_amount NUMBER(18,6),
    currency STRING DEFAULT 'USD',
    line_items VARIANT,
    -- array of line item objects {id,
    description,
    units,
    unit_price,
    amount} status STRING DEFAULT 'DRAFT',
    -- DRAFT / SENT / PAID / CANCELLED created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMPLTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4401featureinstancepagerdutyintegration (
    integrationid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    pdserviceref STRING,
    routingrules VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4403featureinstancepagerdutyevents (
    eventid STRING PRIMARY KEY,
    integrationid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    pdincidentref STRING,
    payload VARIANT,
    sentat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4405featureinstanceslaexposurenotifications (
    notificationid STRING PRIMARY KEY,
    mappingid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    exposuremetric VARIANT,
    message VARIANT,
    sentat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4501featureinstancemetricsingestqueue (
    ingestid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    batchblob VARIANT,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    enqueuedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processedat TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4503featureinstancemetricsingestaudit (
    auditid STRING PRIMARY KEY,
    ingestid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    processedby STRING,
    status STRING,
    details VARIANT,
    processedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4505featureinstancecustomalertrules (
    ruleid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    rulespec VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4507featureinstancealertexecutionhistory (
    execid STRING PRIMARY KEY,
    ruleid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    evaluationblob VARIANT,
    fired BOOLEAN,
    executedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4509featureinstanceapikeysrotationschedule (
    rotationid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    keyref STRING,
    rotateeverydays INT,
    nextrotationat TIMESTAMP_LTZ,
    enabled BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4511featureinstanceapikeyrotationlogs (
    logid STRING PRIMARY KEY,
    rotationid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    oldkeyref STRING,
    newkeyref STRING,
    rotatedby STRING,
    rotatedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4513featureinstancequalitygatedefinitions (
    gateid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    gatespec VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4515featureinstancequalitygateresults (
    resultid STRING PRIMARY KEY,
    gateid STRING,
    deploymentid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    passed BOOLEAN,
    details VARIANT,
    evaluatedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4517featureinstanceabusereports (
    reportid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    reportedby STRING,
    reportblob VARIANT,
    status STRING DEFAULT 'OPEN',
    reportedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    resolvedat TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4519featureinstanceabuseinvestigationlogs (
    logid STRING PRIMARY KEY,
    reportid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    investigator STRING,
    notes VARIANT,
    actiontaken VARIANT,
    loggedat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4521featureinstancedataretentionpolicies (
    policyid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    retention_days INT,
    scope VARIANT,
    createdat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4601featureinstanceeventforwardingrules (
    rule_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    destination_type STRING,
    -- 'WEBHOOK',
    'QUEUE',
    'PUBSUB' destination_config VARIANT,
    -- e.g. {url,
    auth,
    headers} or queue descriptor event_filter VARIANT,
    -- expression or predicate to select events transform_template VARIANT,
    -- optional mapping/templating instructions enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4603featureinstanceeventforwardinglog (
    log_id STRING PRIMARY KEY,
    rule_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    event_id STRING,
    event_payload VARIANT,
    destination_details VARIANT,
    attempt_count INT DEFAULT 0,
    last_attempt_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    -- 'QUEUED',
    'SENT',
    'FAILED',
    'DLQ' response VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4605featureinstanceeventwebhookconfigs (
    config_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    name STRING,
    url STRING,
    http_method STRING DEFAULT 'POST',
    headers VARIANT,
    auth_config VARIANT,
    -- e.g. {type:'bearer',
    token_ref:...} or {type:'basic',
    user:...,
    password_ref:...} timeout_seconds INT DEFAULT 30,
    retry_policy VARIANT,
    -- e.g. {max_attempts:5,
    backoff_seconds:60} enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4607featureinstancewebhookdeliverylog (
    delivery_id STRING PRIMARY KEY,
    config_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    event_id STRING,
    request_payload VARIANT,
    response_status INT,
    response_headers VARIANT,
    response_body VARIANT,
    attempt INT,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    latency_ms NUMBER,
    outcome STRING -- 'SUCCESS' / 'TEMP_FAIL' / 'PERM_FAIL'
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4609featureinstanceeventschemaregistry (
    schema_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    schema_name STRING,
    schema_version STRING,
    schema_definition VARIANT,
    -- JSON Schema / Avro / Protobuf descriptor compatibility_mode STRING DEFAULT 'BACKWARD',
    -- 'BACKWARD',
    'FORWARD',
    'FULL' created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4611featureinstancewebhookretryqueue (
    retry_id STRING PRIMARY KEY,
    delivery_id STRING,
    config_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    event_payload VARIANT,
    next_attempt_at TIMESTAMP_LTZ,
    attempt_count INT DEFAULT 0,
    max_attempts INT DEFAULT 5,
    last_error VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4613featureinstanceeventtransformtemplates (
    template_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    name STRING,
    language STRING DEFAULT 'JINJA',
    -- templating language template_def VARIANT,
    -- template body / mapping instructions version INT DEFAULT 1,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4613featureinstancetelemetryingesterrors (
    error_id STRING PRIMARY KEY,
    ingest_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    error_blob VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4615featureinstanceeventmappingversions (
    mapping_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    mapping_name STRING,
    mapping_def VARIANT,
    version INT,
    active BOOLEAN DEFAULT FALSE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4615featureinstancetelemetryrepairrequests (
    request_id STRING PRIMARY KEY,
    ingest_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , processed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4617featureinstanceintegrationsecrets (
    secret_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    secret_name STRING,
    secret_ref STRING,
    -- pointer to encrypted store or stage object metadata VARIANT,
    rotated_at TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4617featureinstancetelemetryrepairaudit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    ingest_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4619featureinstanceincidentcorrelationmetrics (
    metric_id STRING PRIMARY KEY,
    correlation_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    metric_value FLOAT,
    measured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4619featureinstancereplayjobs (
    replay_job_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    event_filter VARIANT,
    timeframe VARIANT,
    -- {from_ts,
    to_ts} target_rule_id STRING,
    -- optional override to route replayed events submitted_by STRING,
    status STRING DEFAULT 'QUEUED',
    -- 'QUEUED',
    'RUNNING',
    'COMPLETED',
    'FAILED' progress VARIANT,
    scheduled_at TIMESTAMP_LTZ,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4621featureinstancereplayhistory (
    replay_row_id STRING PRIMARY KEY,
    replay_job_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    original_event_id STRING,
    replayed_event_id STRING,
    outcome STRING,
    -- 'REPLAYED',
    'DROPPED',
    'ERROR' details VARIANT,
    processed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4621featureinstancetelemetryerror_aggregates (
    aggregate_id STRING PRIMARY KEY,
    ingest_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    error_count NUMBER,
    first_occurred_at TIMESTAMP_LTZ,
    last_occurred_at TIMESTAMP_LTZ,
    sample_errors ARRAY,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4623featureinstancetelemetryingest_stats ( stats_id STRING PRIMARY KEY, ingest_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, total_records NUMBER, failed_records NUMBER, processed_bytes NUMBER, ingest_window_start TIMESTAMP_LTZ, ingest_window_end TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4625featureinstancetelemetry_checkpoint ( checkpoint_id STRING PRIMARY KEY, ingest_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, checkpoint_offset VARIANT, checkpoint_meta VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), updated_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4627featureinstanceincident_followups ( followup_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, author STRING, followup_type STRING, payload VARIANT, due_at TIMESTAMP_LTZ, completed BOOLEAN DEFAULT FALSE, completed_at TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), updated_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4629featureinstanceincident_followups_audit ( audit_id STRING PRIMARY KEY, followup_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, action STRING, actor STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4631featureinstanceincident_activity_log ( activity_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, activity_type STRING, actor STRING, details VARIANT, occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4633featureinstanceincident_assignment_queue ( queue_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, assigned_to STRING, priority STRING, status STRING DEFAULT 'PENDING', enqueued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), dequeued_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4635featureinstanceincident_escalation_rules ( rule_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, severity STRING, escalate_after_seconds INT, escalate_to ARRAY, auto_escalate BOOLEAN DEFAULT TRUE, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4637featureinstanceincident_sla_tracking ( sla_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, sla_name STRING, sla_deadline TIMESTAMP_LTZ, breached BOOLEAN DEFAULT FALSE, breached_at TIMESTAMP_LTZ, metadata VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4639featureinstanceincident_response_templates ( template_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, name STRING, channel STRING, template VARIANT, updated_by STRING, updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4641featureinstanceincident_comment_threads ( thread_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, comments ARRAY, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), updated_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4643featureinstanceincident_followup_reminders ( reminder_id STRING PRIMARY KEY, followup_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, remind_at TIMESTAMP_LTZ, reminded BOOLEAN DEFAULT FALSE, reminded_at TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4645featureinstanceincident_metrics_rollups ( rollup_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, metric_name STRING, metric_value NUMBER, rollup_window_start TIMESTAMP_LTZ, rollup_window_end TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4647featureinstanceincident_root_cause_analysis ( rca_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, hypothesis VARIANT, supporting_evidence VARIANT, confidence NUMBER, concluded_by STRING, concluded_at TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4649featureinstanceincident_tag_mapping ( mapping_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, tags ARRAY, tagged_by STRING, tagged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4651featureinstanceincident_status_transitions ( transition_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, from_status STRING, to_status STRING, changed_by STRING, changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), reason VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4653featureinstanceincident_resolution_catalog ( resolution_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, title STRING, resolution_steps VARIANT, estimated_time_minutes INT, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4655featureinstanceincident_postmortem_documents ( document_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, title STRING, content VARIANT, author STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), archived BOOLEAN DEFAULT FALSE ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4657featureinstanceincident_postmortem_actions ( action_id STRING PRIMARY KEY, postmortem_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, action_text STRING, owner STRING, due_at TIMESTAMP_LTZ, completed BOOLEAN DEFAULT FALSE, completed_at TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4659featureinstanceincident_postmortem_action_audit ( audit_id STRING PRIMARY KEY, action_id STRING, postmortem_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, action STRING, actor STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4661featureinstanceincident_escalation_log ( escalation_log_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, escalation_level INT, escalated_to ARRAY, reason VARIANT, escalated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), resolved BOOLEAN DEFAULT FALSE, resolved_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4663featureinstanceincident_communications ( comm_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, channel STRING, recipient STRING, subject STRING, body VARIANT, sent_at TIMESTAMP_LTZ, status STRING, delivery_details VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4665featureinstanceincident_suspected_root_causes ( suspected_rca_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, rca_type STRING, description VARIANT, confidence_score NUMBER, proposed_actions VARIANT, recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4667featureinstanceincident_attachments ( attachment_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, filename STRING, content_uri STRING, content_type STRING, uploaded_by STRING, uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), storage_meta VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4669featureinstanceincident_notifications_queue ( notification_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, notify_to ARRAY, notify_channel STRING, payload VARIANT, scheduled_at TIMESTAMP_LTZ, attempts INT DEFAULT 0, last_attempt_at TIMESTAMP_LTZ, status STRING DEFAULT 'PENDING', created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4671featureinstanceincident_kpi_tracking ( kpi_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, kpi_name STRING, kpi_value NUMBER, kpi_meta VARIANT, measured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4673featureinstanceincident_sla_breaches ( sla_breach_id STRING PRIMARY KEY, sla_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, breach_reason VARIANT, breach_detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), remedied BOOLEAN DEFAULT FALSE, remedied_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4675featureinstanceincident_postmortem_summary ( postmortem_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, summary VARIANT, lessons_learned VARIANT, action_items ARRAY, author STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), published BOOLEAN DEFAULT FALSE, published_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4677featureinstanceincident_change_requests ( change_request_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, requested_by STRING, change_payload VARIANT, status STRING DEFAULT 'OPEN', requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), reviewed_by STRING, reviewed_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4679featureinstanceincident_runbook_links ( runbook_link_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, runbook_title STRING, runbook_uri STRING, added_by STRING, added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4681featureinstanceincident_impact_assessment ( impact_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, impacted_customers ARRAY, estimated_cost NUMBER, business_impact VARIANT, assessed_by STRING, assessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4683featureinstanceincident_automations ( automation_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, automation_type STRING, trigger_conditions VARIANT, runbook VARIANT, last_run_at TIMESTAMP_LTZ, run_status STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4685featureinstanceincident_sla_config ( sla_config_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, sla_name STRING, target_seconds INT, breach_policy VARIANT, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), active BOOLEAN DEFAULT TRUE ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4687featureinstanceincident_priority_matrix ( matrix_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, priority_rules VARIANT, effective_from TIMESTAMP_LTZ, effective_to TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4689featureinstanceincident_escalation_timers ( timer_id STRING PRIMARY KEY, rule_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, escalation_after_seconds INT, next_escalation_at TIMESTAMP_LTZ, enabled BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4691featureinstanceincident_deduplication_keys ( dedupe_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, dedupe_key STRING, occurrence_count INT DEFAULT 1, first_seen_at TIMESTAMP_LTZ, last_seen_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4693featureinstanceincident_suppression_exceptions ( exception_id STRING PRIMARY KEY, rule_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, exception_reason VARIANT, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), expires_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4695featureinstanceincident_operational_notes ( note_id STRING PRIMARY KEY, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, note_text STRING, author STRING, visibility STRING DEFAULT 'TEAM', created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4697featureinstanceincident_correlation_links ( correlation_id STRING PRIMARY KEY, primary_incident_id STRING, correlated_incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, correlation_type STRING, confidence_score NUMBER, linked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4699featureinstanceincident_escalation_policy_versions ( policy_version_id STRING PRIMARY KEY, policy_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, policy_definition VARIANT, version_number INT, effective_from TIMESTAMP_LTZ, effective_to TIMESTAMP_LTZ, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4201_feature_instance_service_tokens ( token_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, token_ref STRING, issued_to STRING, scopes ARRAY, expires_at TIMESTAMP_LTZ, issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4203_feature_instance_service_token_audit ( audit_id STRING PRIMARY KEY, token_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, action STRING, actor STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4205_feature_instance_scheduled_health_checks ( schedule_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, check_id STRING, next_run_at TIMESTAMP_LTZ, cadence_seconds INT, enabled BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4207_feature_instance_health_check_backoff_logs ( backoff_id STRING PRIMARY KEY, check_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, consecutive_failures INT, backoff_until TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4209_feature_instance_alert_suppression_rules ( rule_id STRING PRIMARY KEY, feature_key STRING, instance_ref STRING, org_id STRING, alert_types ARRAY, suppressed_from TIMESTAMP_LTZ, suppressed_to TIMESTAMP_LTZ, reason VARIANT, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4211_feature_instance_alert_suppression_log ( log_id STRING PRIMARY KEY, rule_id STRING, alert_id STRING, feature_key STRING, instance_ref STRING, org_id STRING, evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), suppressed BOOLEAN, reason VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4213_feature_instance_cost_reallocation_requests ( request_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, requested_by STRING, from_cost_center STRING, to_cost_center STRING, amount NUMBER, reason VARIANT, status STRING DEFAULT 'PENDING', requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), processed_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4215_feature_instance_cost_reallocation_audit ( audit_id STRING PRIMARY KEY, request_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, processed_by STRING, action STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4217_feature_instance_alert_annotation ( annotation_id STRING PRIMARY KEY, alert_id STRING, feature_key STRING, instance_ref STRING, org_id STRING, author STRING, note VARIANT, annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4219_feature_instance_customer_attachment_retention ( policy_id STRING PRIMARY KEY, feature_key STRING, instance_ref STRING, org_id STRING, retention_days INT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.invoice_archive ( invoice_id STRING PRIMARY KEY, account_id STRING, subtotal NUMBER, markup NUMBER, tax NUMBER, total NUMBER, currency STRING, archived_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.alerts ( alert_id STRING PRIMARY KEY, name STRING, details VARIANT, level STRING, acked BOOLEAN DEFAULT FALSE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), acked_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.billing_audit ( audit_id STRING PRIMARY KEY, invoice_id STRING, event_type STRING, details VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.inference_provenance ( prov_id STRING PRIMARY KEY, request_id STRING, model_id STRING, input VARIANT, output VARIANT, tokens NUMBER, confidence NUMBER, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.api_keys ( key_id STRING PRIMARY KEY, org_id STRING, key_hash STRING, is_active BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.retention_policies ( policy_id STRING PRIMARY KEY, name STRING, description STRING, apply_to STRING, retention_days NUMBER, is_active BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.archive_jobs ( job_id STRING PRIMARY KEY, object_type STRING, query STRING, archive_stage STRING, status STRING DEFAULT 'PENDING', run_at TIMESTAMP_LTZ, completed_at TIMESTAMP_LTZ, details VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.rate_card_tiers ( tier_id STRING PRIMARY KEY, feature_key STRING, min_units NUMBER, max_units NUMBER, unit_price NUMBER, effective_from TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.usage_anomalies ( anomaly_id STRING PRIMARY KEY, account_id STRING, feature_key STRING, detected_at TIMESTAMP_LTZ, anomaly_score FLOAT, details VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.model_drift_metrics ( metric_id STRING PRIMARY KEY, model_id STRING, metric_name STRING, metric_value NUMBER, baseline_value NUMBER, drift_score NUMBER, check_timestamp TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4221_feature_instance_customer_attachment_purge_jobs ( job_id STRING PRIMARY KEY, policy_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, scheduled_at TIMESTAMP_LTZ, status STRING DEFAULT 'QUEUED', executed_at TIMESTAMP_LTZ, result VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4223_feature_instance_customer_attachment_purge_history ( history_id STRING PRIMARY KEY, job_id STRING, policy_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, purged_at TIMESTAMP_LTZ, purged_by STRING, details VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4201_feature_instance_service_tokens ( token_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, token_ref STRING, issued_to STRING, scopes ARRAY, expires_at TIMESTAMP_LTZ, issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4203_feature_instance_service_token_audit ( audit_id STRING PRIMARY KEY, token_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, action STRING, actor STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4205_feature_instance_scheduled_health_checks ( schedule_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, check_id STRING, next_run_at TIMESTAMP_LTZ, cadence_seconds INT, enabled BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4207_feature_instance_health_check_backoff_logs ( backoff_id STRING PRIMARY KEY, check_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, consecutive_failures INT, backoff_until TIMESTAMP_LTZ, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4209_feature_instance_alert_suppression_rules ( rule_id STRING PRIMARY KEY, feature_key STRING, instance_ref STRING, org_id STRING, alert_types ARRAY, suppressed_from TIMESTAMP_LTZ, suppressed_to TIMESTAMP_LTZ, reason VARIANT, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4211_feature_instance_alert_suppression_log ( log_id STRING PRIMARY KEY, rule_id STRING, alert_id STRING, feature_key STRING, instance_ref STRING, org_id STRING, evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), suppressed BOOLEAN, reason VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4213_feature_instance_cost_reallocation_requests ( request_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, requested_by STRING, from_cost_center STRING, to_cost_center STRING, amount NUMBER, reason VARIANT, status STRING DEFAULT 'PENDING', requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), processed_at TIMESTAMP_LTZ ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4215_feature_instance_cost_reallocation_audit ( audit_id STRING PRIMARY KEY, request_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, processed_by STRING, action STRING, notes VARIANT, acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4217_feature_instance_alert_annotation ( annotation_id STRING PRIMARY KEY, alert_id STRING, feature_key STRING, instance_ref STRING, org_id STRING, author STRING, note VARIANT, annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4219_feature_instance_customer_attachment_retention ( policy_id STRING PRIMARY KEY, feature_key STRING, instance_ref STRING, org_id STRING, retention_days INT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.clause_citation_links ( link_id STRING PRIMARY KEY, clause_id STRING, source_doc_id STRING, source_section_id STRING, confidence FLOAT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.agent_plans ( plan_id STRING PRIMARY KEY, org_id STRING, document_id STRING, agent_name STRING, plan_steps VARIANT, conclusion VARIANT, confidence FLOAT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.section_quality_scores ( score_id STRING PRIMARY KEY, org_id STRING, document_id STRING, section_id STRING, coverage FLOAT, cleanliness FLOAT, confidence FLOAT, assessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.reviewer_queue ( review_id STRING PRIMARY KEY, org_id STRING, document_id STRING, section_id STRING, reason STRING, assigned_to STRING, status STRING DEFAULT 'OPEN', created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.review_actions ( action_id STRING PRIMARY KEY, review_id STRING, reviewer STRING, action STRING, comment STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.workflow_audit_trail ( audit_id STRING PRIMARY KEY, org_id STRING, workflow_id STRING, step_name STRING, step_status STRING, actor STRING, details VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_hash_index ( doc_hash STRING PRIMARY KEY, archive_id STRING, org_id STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.tamper_alerts ( alert_id STRING PRIMARY KEY, org_id STRING, archive_id STRING, detected_via STRING, details VARIANT, severity STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4225_feature_instance_customer_comms_templates ( template_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, name STRING, template VARIANT, updated_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4227_feature_instance_customer_comms_dispatch_queue ( dispatch_id STRING PRIMARY KEY, template_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, recipients ARRAY, scheduled_at TIMESTAMPLTZ, status STRING DEFAULT 'QUEUED', attempts INT DEFAULT 0, created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4229_feature_instance_customer_comms_delivery_log ( delivery_id STRING PRIMARY KEY, dispatch_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, recipient STRING, status STRING, attempted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(), details VARIANT ) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4231_feature_instance_api_usage_quotas ( quota_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, limit_per_minute INT, limit_per_hour INT, limit_per_day INT, enforced BOOLEAN DEFAULT TRUE, created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP()
) CREATE OR REPLACE TABLE AI_FEATURE_HUB.Template_Metadata ( template_id STRING PRIMARY KEY, name STRING, version STRING, storage_stage_path STRING, mime_type STRING, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), checksum STRING, metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4623featureinstanceeventschemaversions (
    schema_version_id STRING PRIMARY KEY,
    schema_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    version_number INT,
    schema_snapshot VARIANT,
    validated BOOLEAN DEFAULT FALSE,
    validated_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4625featureinstanceeventcontracts (
    contract_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    provider STRING,
    consumer STRING,
    contract_def VARIANT,
    -- expectations,
    SLA,
    schema references effective_from TIMESTAMP_LTZ,
    effective_to TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4627featureinstanceeventsubscriptions (
    subscription_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    subscriber STRING,
    -- consumer identifier subscription_config VARIANT,
    status STRING DEFAULT 'ACTIVE',
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    last_heartbeat TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4629featureinstanceeventsubscriptionaudit (
    audit_id STRING PRIMARY KEY,
    subscription_id STRING,
    action STRING,
    -- 'CREATE',
    'UPDATE',
    'DELETE',
    'PAUSE',
    'RESUME' actor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4631featureinstanceeventdeliverystats (
    stats_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    period_start TIMESTAMP_LTZ,
    period_end TIMESTAMP_LTZ,
    delivered_count NUMBER,
    failed_count NUMBER,
    avg_latency_ms NUMBER,
    p95_latency_ms NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4633featureinstanceeventbackpressurestate (
    state_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    measured_rate NUMBER,
    allowed_rate NUMBER,
    threshold_config VARIANT,
    state VARIANT,
    -- e.g. {level:'NORMAL'|'DEGRADED'|'THROTTLED'} updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4635featureinstanceeventratelimits (
    ratelimit_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    scope STRING,
    -- 'INSTANCE',
    'FEATURE',
    'ORG' limit_per_minute NUMBER,
    burst_capacity NUMBER,
    enforcement_action STRING DEFAULT 'THROTTLE',
    -- 'THROTTLE'|'DROP'|'QUEUE' updated_by STRING,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4637featureinstanceeventdlq (
    dlq_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    original_event_id STRING,
    payload VARIANT,
    failure_reason VARIANT,
    first_failed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    last_attempted_at TIMESTAMP_LTZ,
    attempt_count INT DEFAULT 0,
    processed BOOLEAN DEFAULT FALSE,
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4639featureinstanceeventmonitoringmetrics (
    metric_row_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    metric_name STRING,
    metric_value NUMBER,
    tags VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4801featureinstancepolicychangerequests (
    request_id STRING PRIMARY KEY,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    change_spec VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4803featureinstancepolicychangeaudit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4805featureinstanceeventschemaregistry (
    schema_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    schema_blob VARIANT,
    version INT,
    registered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4807featureinstanceeventschemavalidationresults (
    validation_id STRING PRIMARY KEY,
    schema_id STRING,
    event_ref STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    passed BOOLEAN,
    result_blob VARIANT,
    validated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4809featureinstancetelemetrymetricsindex (
    index_id STRING PRIMARY KEY,
    telemetry_ref STRING,
    metric_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    mapping_blob VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4811featureinstancemetricbackfillrequests (
    request_id STRING PRIMARY KEY,
    metric_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    requested_by STRING,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4813featureinstancemetricbackfillaudit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    metric_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4815featureinstanceincidentsuppressionrules (
    rule_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    conditions VARIANT,
    suppressed_from TIMESTAMP_LTZ,
    suppressed_to TIMESTAMP_LTZ,
    reason VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4817featureinstanceincidentsuppressionevaluations (
    evaluation_id STRING PRIMARY KEY,
    rule_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    suppressed BOOLEAN,
    reason VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4819featureinstanceoperationalcadencedefinitions (
    cadence_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    instance_ref STRING,
    cadence_blob VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4821featureinstanceoperationalcadenceevents (
    event_id STRING PRIMARY KEY,
    cadence_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    event_blob VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1401_snapshot_retention_policies (
    policy_id STRING PRIMARY KEY,
    org_id STRING NOT NULL,
    retention_days INT,
    include_manifests BOOLEAN DEFAULT TRUE,
    include_packages BOOLEAN DEFAULT TRUE,
    last_evaluated_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1501_org_security_policies (
    policy_id STRING PRIMARY KEY,
    org_id STRING NOT NULL,
    policy_name STRING,
    policy_blob VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1503_org_alert_contacts (
    contact_id STRING PRIMARY KEY,
    org_id STRING,
    contact_name STRING,
    contact_type STRING,
    contact_endpoint STRING,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1505_third_party_integration_registry (
    integration_id STRING PRIMARY KEY,
    org_id STRING,
    provider STRING,
    config VARIANT,
    status STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1507_export_transfer_monitor (
    transfer_id STRING PRIMARY KEY,
    org_id STRING,
    manifest_id STRING,
    destination STRING,
    status STRING,
    bytes_transferred NUMBER,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1509_async_job_checkpoint (
    checkpoint_id STRING PRIMARY KEY,
    pipeline_name STRING,
    last_processed_cursor VARIANT,
    last_updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1511_user_notification_preferences (
    pref_id STRING PRIMARY KEY,
    org_id STRING,
    user_id STRING,
    channels ARRAY,
    quiet_hours VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1513_user_rate_limit_counters (
    counter_id STRING PRIMARY KEY,
    org_id STRING,
    user_id STRING,
    metric STRING,
    window_start TIMESTAMP_LTZ,
    count NUMBER,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1515_user_session_index (
    session_id STRING PRIMARY KEY,
    org_id STRING,
    user_id STRING,
    client_info VARIANT,
    expires_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1517_document_preview_access_log (
    access_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    session_id STRING,
    token_id STRING,
    action STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1519_template_retention_marks (
    mark_id STRING PRIMARY KEY,
    org_id STRING,
    template_id STRING,
    mark_reason STRING,
    placed_by STRING,
    placed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,expires_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1521_template_scheduling_queue (
    schedule_id STRING PRIMARY KEY,
    org_id STRING,
    template_id STRING,
    cron_expr STRING,
    last_run TIMESTAMP_LTZ,
    next_run TIMESTAMP_LTZ,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1525_template_dependency_graph (
    edge_id STRING PRIMARY KEY,
    org_id STRING,
    parent_template_id STRING,
    child_template_id STRING,
    relation_type STRING,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1533_field_normalization_rules (
    rule_id STRING PRIMARY KEY,
    org_id STRING,
    field_name STRING,
    transform_expression STRING,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_1537_template_safety_whitelist (
    whitelist_id STRING PRIMARY KEY,
    org_id STRING,
    construct STRING,
    justification STRING,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,expires_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4201_feature_instance_service_tokens (
    token_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    token_ref STRING,
    issued_to STRING,
    scopes ARRAY,
    expires_at TIMESTAMP_LTZ,
    issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4203_feature_instance_service_token_audit (
    audit_id STRING PRIMARY KEY,
    token_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4205_feature_instance_scheduled_health_checks (
    schedule_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    check_id STRING,
    next_run_at TIMESTAMP_LTZ,
    cadence_seconds INT,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4207_feature_instance_health_check_backoff_logs (
    backoff_id STRING PRIMARY KEY,
    check_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    consecutive_failures INT,
    backoff_until TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4209_feature_instance_alert_suppression_rules (
    rule_id STRING PRIMARY KEY,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    alert_types ARRAY,
    suppressed_from TIMESTAMP_LTZ,
    suppressed_to TIMESTAMP_LTZ,
    reason VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4211_feature_instance_alert_suppression_log (
    log_id STRING PRIMARY KEY,
    rule_id STRING,
    alert_id STRING,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,suppressed BOOLEAN,reason VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4213_feature_instance_cost_reallocation_requests (
    request_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    from_cost_center STRING,
    to_cost_center STRING,
    amount NUMBER,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , processed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4215_feature_instance_cost_reallocation_audit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    processed_by STRING,
    action STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4217_feature_instance_alert_annotation (
    annotation_id STRING PRIMARY KEY,
    alert_id STRING,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    author STRING,
    note VARIANT,
    annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4219_feature_instance_customer_attachment_retention (
    policy_id STRING PRIMARY KEY,
    feature_key STRING,
    instance_ref STRING,
    org_id STRING,
    retention_days INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4221_feature_instance_customer_attachment_purge_jobs (
    job_id STRING PRIMARY KEY,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    executed_at TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4223_feature_instance_customer_attachment_purge_history (
    history_id STRING PRIMARY KEY,
    job_id STRING,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    executed_at TIMESTAMP_LTZ,
    status STRING,
    result VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4225_feature_instance_customer_comms_templates (
    template_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4227_feature_instance_customer_comms_dispatch_queue (
    dispatch_id STRING PRIMARY KEY,
    template_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipients ARRAY,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4229_feature_instance_customer_comms_delivery_log (
    delivery_id STRING PRIMARY KEY,
    dispatch_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    recipient STRING,
    status STRING,
    attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4231_feature_instance_api_usage_quotas (
    quota_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    ORG_ID STRING,
    limit_per_minute INT,
    limit_per_hour INT,
    limit_per_day INT,
    enforced BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4233_feature_instance_api_quota_violations (
    violation_id STRING PRIMARY KEY,
    quota_id STRING,
    instance_ref STRING,
    feature_key STRING,
    ORG_ID STRING,
    observed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , count INT, details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4235_feature_instance_feature_flags (
    flag_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    flag_key STRING,
    enabled BOOLEAN,
    criteria VARIANT,
    updated_at TIMESTAMP_LTZ,
    updated_by STRING
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4237_feature_instance_flag_evaluation_logs (
    eval_id STRING PRIMARY KEY,
    flag_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    target_ref STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    result BOOLEAN,
    context VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4239_feature_instance_runtime_metadata (
    meta_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    metadata VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4241_feature_instance_runtime_metadata_audit (
    audit_id STRING PRIMARY KEY,
    meta_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    metadata_before VARIANT,
    metadata_after VARIANT,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4601_feature_instance_event_forwarding_rules (
    rule_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    endpoint VARIANT,
    event_types ARRAY,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4603_feature_instance_event_forwarding_log (
    forward_id STRING PRIMARY KEY,
    rule_id STRING,
    event_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    endpoint VARIANT,
    payload VARIANT,
    status STRING,
    details VARIANT,
    attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4605_feature_instance_observer_agents (
    agent_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    agent_spec VARIANT,
    registered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    last_heartbeat TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4607_feature_instance_observer_agent_heartbeats (
    heartbeat_id STRING PRIMARY KEY,
    agent_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    status STRING,
    details VARIANT,
    heartbeat_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4609_feature_instance_automation_run_history (
    run_id STRING PRIMARY KEY,
    rule_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    trigger_context VARIANT,
    actions_executed VARIANT,
    result VARIANT,
    executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4611_feature_instance_incident_runbooks (
    mapping_id STRING PRIMARY KEY,
    incident_id STRING,
    runbook_ref STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4613_feature_instance_telemetry_ingest_errors (
    error_id STRING PRIMARY KEY,
    ingest_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    error_blob VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4615_feature_instance_telemetry_repair_requests (
    request_id STRING PRIMARY KEY,
    ingest_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    reason VARIANT,
    status STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_agent_outputs (
    output_id STRING PRIMARY KEY,
    agent_id STRING,
    task_id STRING,
    org_id STRING,
    instanceref STRING,
    payload VARIANT,
    status STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_agent_output_ingest_queue (
    queue_id STRING PRIMARY KEY,
    output_id STRING,
    ingest_attempts INT DEFAULT 0,
    last_attempt_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'PENDING',
    payload VARIANT,
    enqueued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_agent_output_processing_queue (
    queue_id STRING PRIMARY KEY,
    output_id STRING,
    priority INT DEFAULT 50,
    attempts INT DEFAULT 0,
    last_attempt_at TIMESTAMP_LTZ,
    next_attempt_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'PENDING',
    payload VARIANT,
    enqueued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_agent_output_store (
    output_id STRING PRIMARY KEY,
    agent_id STRING,
    task_id STRING,
    org_id STRING,
    instanceref STRING,
    output_type STRING,
    payload VARIANT,
    content_hash STRING,
    status STRING DEFAULT 'NEW',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , processed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_api_integrations (
    integration_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    type STRING,
    config VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_api_integration_registry (
    integration_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    type STRING,
    config VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_archive_manifest (
    manifest_id STRING PRIMARY KEY,
    org_id STRING NOT NULL,
    snapshot_id STRING,
    package_path STRING,
    package_size_bytes NUMBER,
    retention_tag STRING,
    export_status STRING DEFAULT 'PENDING',
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    error_message STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_attachment_purge_history (
    history_id STRING PRIMARY KEY,
    job_id STRING,
    policy_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    executed_at TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_attachment_purge_jobs (
    job_id STRING PRIMARY KEY,
    policy_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    executed_at TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_attachment_retention_policies (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    retention_days INT,
    scope VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_billing_dispute_registry (
    dispute_id STRING PRIMARY KEY,
    invoice_id STRING,
    org_id STRING,
    raised_by STRING,
    reason VARIANT,
    status STRING DEFAULT 'OPEN',
    opened_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , resolved_at TIMESTAMP_LTZ, resolution VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_billing_reconciliation (
    reconciliation_id STRING PRIMARY KEY,
    billing_run_id STRING,
    org_id STRING,
    external_invoice_ref STRING,
    expected_amount NUMBER,
    observed_amount NUMBER,
    variance NUMBER,
    status STRING DEFAULT 'PENDING',
    discrepancies VARIANT,
    reconciled_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_billing_reconciliation_audit (
    audit_id STRING PRIMARY KEY,
    reconciliation_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_billing_runs (
    billing_run_id STRING PRIMARY KEY,
    org_id STRING,
    run_type STRING,
    params VARIANT,
    status STRING DEFAULT 'QUEUED',
    scheduled_at TIMESTAMP_LTZ,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_billing_run_jobs (
    job_id STRING PRIMARY KEY,
    billing_run_id STRING,
    org_id STRING,
    job_type STRING,
    status STRING DEFAULT 'QUEUED',
    params VARIANT,
    scheduled_at TIMESTAMP_LTZ,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_billing_run_line_items (
    line_item_id STRING PRIMARY KEY,
    billing_run_id STRING,
    org_id STRING,
    feature_key STRING,
    instance_ref STRING,
    usage_value NUMBER,
    unit STRING,
    unit_price NUMBER,
    amount NUMBER,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_billing_run_line_item_details (
    line_item_id STRING PRIMARY KEY,
    billing_run_id STRING,
    invoice_id STRING,
    org_id STRING,
    account_id STRING,
    feature_key STRING,
    metric_key STRING,
    usage_value NUMBER,
    unit STRING,
    unit_price NUMBER,
    base_amount NUMBER,
    markup NUMBER,
    discounts VARIANT,
    tax VARIANT,
    line_total NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_billing_run_telemetry (
    telemetry_id STRING PRIMARY KEY,
    billing_run_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_document_embeddings (
    embedding_id STRING PRIMARY KEY,
    document_id STRING,
    org_id STRING,
    section_id STRING,
    model_id STRING,
    model_version STRING,
    vector VARIANT,
    l2_norm FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_external_functions_registry (
    function_id STRING PRIMARY KEY,
    name STRING,
    integration_type STRING,
    config VARIANT,
    registered_by STRING,
    registered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , last_health_check TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_external_function_registry (
    function_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    integration_type STRING,
    config VARIANT,
    status STRING DEFAULT 'REGISTERED',
    registered_by STRING,
    registered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , last_health_check TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_faiss_index_snapshots (
    snapshot_id STRING PRIMARY KEY,
    index_name STRING,
    snapshot_location STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancealertannotation (
    annotationid STRING PRIMARY KEY,
    alertid STRING,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    author STRING,
    note VARIANT,
    annotatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancealertsuppressionlog (
    logid STRING PRIMARY KEY,
    ruleid STRING,
    alertid STRING,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    evaluatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , suppressed BOOLEAN, reason VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancealertsuppressionrules (
    ruleid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    alerttypes ARRAY,
    suppressedfrom TIMESTAMPLTZ,
    suppressedto TIMESTAMPLTZ,
    reason VARIANT,
    createdby STRING,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancecostreallocationaudit (
    auditid STRING PRIMARY KEY,
    requestid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    processedby STRING,
    action STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancecostreallocationrequests (
    requestid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requestedby STRING,
    fromcostcenter STRING,
    tocostcenter STRING,
    amount NUMBER,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requestedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , processedat TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancecustomerattachmentpurgehistory (
    historyid STRING PRIMARY KEY,
    jobid STRING,
    policyid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    executedat TIMESTAMPLTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancecustomerattachmentpurgejobs (
    jobid STRING PRIMARY KEY,
    policyid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    scheduledat TIMESTAMPLTZ,
    status STRING DEFAULT 'QUEUED',
    executedat TIMESTAMPLTZ,
    result VARIANT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancecustomerattachmentretention (
    policyid STRING PRIMARY KEY,
    featurekey STRING,
    instanceref STRING,
    orgid STRING,
    retentiondays INT,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancecustomercommsdeliverylog (
    deliveryid STRING PRIMARY KEY,
    dispatchid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    recipient STRING,
    status STRING,
    attemptedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , result VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancecustomercommsdispatchqueue (
    dispatchid STRING PRIMARY KEY,
    templateid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    recipients ARRAY,
    scheduledat TIMESTAMPLTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancecustomercommstemplates (
    templateid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    name STRING,
    template VARIANT,
    updatedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancehealthcheckbackofflogs (
    backoffid STRING PRIMARY KEY,
    checkid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    consecutivefailures INT,
    backoffuntil TIMESTAMPLTZ,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstancescheduledhealthchecks (
    scheduleid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    checkid STRING,
    nextrunat TIMESTAMPLTZ,
    cadenceseconds INT,
    enabled BOOLEAN DEFAULT TRUE,
    createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstanceservicetokenaudit (
    auditid STRING PRIMARY KEY,
    tokenid STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    actedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_featureinstanceservicetokens (
    tokenid STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    tokenref STRING,
    issuedto STRING,
    scopes ARRAY,
    expiresat TIMESTAMPLTZ,
    issuedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_flags (
    flag_id STRING PRIMARY KEY,
    feature_key STRING,
    instanceref STRING,
    org_id STRING,
    enabled BOOLEAN DEFAULT FALSE,
    rollout_percent INT DEFAULT 0,
    config VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_flag_audit (
    audit_id STRING PRIMARY KEY,
    flag_id STRING,
    instanceref STRING,
    org_id STRING,
    changed_by STRING,
    change_type STRING,
    prev_value VARIANT,
    new_value VARIANT,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_flag_rollouts (
    rollout_id STRING PRIMARY KEY,
    flag_id STRING,
    instanceref STRING,
    org_id STRING,
    rollout_percent INT,
    start_at TIMESTAMP_LTZ,
    end_at TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_access_review_audit (
    audit_id STRING PRIMARY KEY,
    decision_id STRING,
    request_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_access_review_decisions (
    decision_id STRING PRIMARY KEY,
    request_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    reviewer STRING,
    decision STRING,
    -- 'KEEP' / 'REVOKE' / 'ESCALATE' comment STRING,
    decided_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_access_review_requests (
    request_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requested_by STRING,
    scope VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_acknowledgements (
    id STRING PRIMARY KEY,
    incident_id STRING,
    ack_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    acknowledged_by STRING,
    acknowledged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , channel STRING, note VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_acknowledgement_history (
    id STRING PRIMARY KEY,
    incident_id STRING,
    ack_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    acknowledged_by STRING,
    acknowledged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , channel STRING, note VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_acknowledgement_history_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    ack_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    acknowledged_by STRING,
    acknowledged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , channel STRING, note VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_action_items_audit (
    audit_id STRING PRIMARY KEY,
    action_item_id STRING,
    incident_id STRING,
    previous_state VARIANT,
    new_state VARIANT,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_annotation (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_correlation (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_correlation_index (
    correlation_id STRING PRIMARY KEY,
    alert_ids ARRAY,
    feature_key STRING,
    instanceref STRING,
    org_id STRING,
    correlation_score FLOAT,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_deduplication_results (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_deduplication_rules (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_grouping_results (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_grouping_rules (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_matching_history (
    match_id STRING PRIMARY KEY,
    incident_id STRING,
    alert_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    match_score FLOAT,
    matched_by STRING,
    matched_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  evidence VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_suppression_log (
    log_id STRING PRIMARY KEY,
    rule_id STRING,
    alert_id STRING,
    feature_key STRING,
    instanceref STRING,
    org_id STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , suppressed BOOLEAN, reason VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_analytics_runs (
    run_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    run_spec VARIANT,
    run_result VARIANT,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_annotation_tags (
    id STRING PRIMARY KEY,
    tag STRING,
    description STRING,
    color STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , org_id STRING, instanceref STRING, feature_key STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_annotation_tags_v2 (
    id STRING PRIMARY KEY,
    tag_id STRING,
    tag STRING,
    description STRING,
    color STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , org_id STRING, instanceref STRING, feature_key STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_anomaly_alerts (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_api_quota_violations (
    violation_id STRING PRIMARY KEY,
    quota_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    exceeded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , observed_value NUMBER, window STRING, details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_api_usage_quotas (
    quota_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    limit_per_minute INT,
    limit_per_hour INT,
    limit_per_day INT,
    enforced BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_architecture_changes (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_attachments (
    attachment_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    filename STRING,
    content_type STRING,
    stage_path STRING,
    -- external stage path size_bytes NUMBER,
    uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  retention_until TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_attachment_metadata (
    meta_id STRING PRIMARY KEY,
    attachment_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    tags ARRAY,
    checksum STRING,
    extracted_text VARIANT,
    metadata VARIANT,
    processed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_attachment_retention (
    retention_id STRING PRIMARY KEY,
    attachment_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    retention_days INT,
    purge_scheduled_at TIMESTAMP_LTZ,
    purged_at TIMESTAMP_LTZ,
    status STRING,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_audit_log_exports (
    id STRING PRIMARY KEY,
    parent_id STRING,
    export_job_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_audit_log_export_parts (
    id STRING PRIMARY KEY,
    export_id STRING,
    part_number INT,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    part_payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_audit_trail (
    id STRING PRIMARY KEY,
    entity_id STRING,
    entity_type STRING,
    action STRING,
    performed_by STRING,
    details VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , org_id STRING, instanceref STRING, feature_key STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_audit_trail_v2 (
    id STRING PRIMARY KEY,
    entity_id STRING,
    entity_type STRING,
    action STRING,
    performed_by STRING,
    details VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , org_id STRING, instanceref STRING, feature_key STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_bookmark_shares (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_capacity_forecasts (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_capacity_forecast_errors (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_change_approvals (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_change_approval_audit (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_change_approval_decisions (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_change_history (
    change_id STRING PRIMARY KEY,
    entity STRING,
    entity_id STRING,
    change_type STRING,
    changed_by STRING,
    change_details VARIANT,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_charts_snapshots (
    snapshot_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    chart_spec VARIANT,
    image_stage_path STRING,
    snapshot_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  created_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_closure_approvals (
    id STRING PRIMARY KEY,
    incident_id STRING,
    approval_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    approver STRING,
    approval_status STRING DEFAULT 'PENDING',
    approval_note VARIANT,
    approved_at TIMESTAMP_LTZ,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_closure_approvals_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    approval_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    approver STRING,
    approval_status STRING DEFAULT 'PENDING',
    approval_note VARIANT,
    approved_at TIMESTAMP_LTZ,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_commits (
    commit_id STRING PRIMARY KEY,
    deployment_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    repo STRING,
    commit_hash STRING,
    message STRING,
    author STRING,
    committed_at TIMESTAMP_LTZ,
    metadata VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_comms_templates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    template_name STRING,
    template_payload VARIANT,
    version INT DEFAULT 1,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_comms_template_usages (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    template_id STRING,
    usage_context VARIANT,
    used_by STRING,
    used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_communications_queue (
    queue_id STRING PRIMARY KEY,
    comms_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    attempt_count INT DEFAULT 0,
    next_attempt_at TIMESTAMP_LTZ,
    last_attempt_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'PENDING',
    result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_communication_channels (
    channel_id STRING PRIMARY KEY,
    name STRING,
    type STRING,
    endpoint VARIANT,
    default_preferences VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_communication_playbooks (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_comm_playbook_usages (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_compensation_actions (
    id STRING PRIMARY KEY,
    compensation_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    compensation_type STRING,
    details VARIANT,
    amount NUMBER,
    currency STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_continuous_validation_configs (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_continuous_validation_runs (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_correlation_clusters (
    cluster_id STRING PRIMARY KEY,
    org_id STRING,
    featurekey STRING,
    cluster_members ARRAY,
    -- list of alert/incident refs cluster_metrics VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_cost_estimates (
    id STRING PRIMARY KEY,
    incident_id STRING,
    estimate_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    estimated_cost NUMBER,
    currency STRING,
    breakdown VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_cost_estimates_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    estimate_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    estimated_cost NUMBER,
    currency STRING,
    breakdown VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_cost_reallocation_audit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    processed_by STRING,
    action STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_cost_reallocation_requests (
    request_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    from_cost_center STRING,
    to_cost_center STRING,
    amount NUMBER,
    reason VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , processed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_purge_history (
    history_id STRING PRIMARY KEY,
    job_id STRING,
    policy_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    executed_at TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_purge_jobs (
    job_id STRING PRIMARY KEY,
    policy_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    executed_at TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_retention (
    policy_id STRING PRIMARY KEY,
    feature_key STRING,
    instanceref STRING,
    org_id STRING,
    retention_days INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_comms_delivery_log (
    delivery_id STRING PRIMARY KEY,
    dispatch_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    recipient STRING,
    status STRING,
    attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_comms_dispatch_queue (
    dispatch_id STRING PRIMARY KEY,
    template_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    recipients ARRAY,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_comms_templates (
    template_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_notifications (
    notification_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    customer_ref STRING,
    template_id STRING,
    variables VARIANT,
    delivery_channel STRING,
    status STRING DEFAULT 'QUEUED',
    delivered_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_data_access_requests (
    request_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requested_by STRING,
    request_payload VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_data_access_responses (
    response_id STRING PRIMARY KEY,
    request_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    responder STRING,
    response_payload VARIANT,
    responded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_dependency_changes (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_dependency_graph (
    graph_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    nodes VARIANT,
    -- nodes and edges describing dependencies edges VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_error_mitigation_actions (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_error_mitigation_history (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_escalation_actions (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_escalation_events (
    id STRING PRIMARY KEY,
    escalation_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    triggered_by STRING,
    reason VARIANT,
    triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , resolved BOOLEAN DEFAULT FALSE, resolved_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_escalation_paths (
    id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    level INT,
    role STRING,
    contact VARIANT,
    sla_threshold_seconds NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_escalation_policies (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_event_replay_jobs (
    id STRING PRIMARY KEY,
    job_id STRING,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    schedule VARIANT,
    status STRING DEFAULT 'QUEUED',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_event_replay_job_parts (
    id STRING PRIMARY KEY,
    replay_job_id STRING,
    part_number INT,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    part_payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_evidence_references (
    id STRING PRIMARY KEY,
    incident_id STRING,
    evidence_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    evidence_type STRING,
    reference_path STRING,
    metadata VARIANT,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_evidence_references_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    evidence_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    evidence_type STRING,
    reference_path STRING,
    metadata VARIANT,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_feature_flag_evaluations (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_feature_flag_segments (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followups_audit (
    audit_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_assignees (
    assignment_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    assigned_to STRING,
    role STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  due_at TIMESTAMP_LTZ,  completed_at TIMESTAMP_LTZ,  status STRING DEFAULT 'ASSIGNED');


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_assignment_2054 (
    assignment_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    assignee STRING,
    role STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  note VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_attachments_2052 (
    attachment_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    filename STRING,
    content_type STRING,
    storage_ref STRING,
    size_bytes NUMBER,
    uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_audit_log_2065 (
    audit_id STRING PRIMARY KEY,
    entity_type STRING,
    entity_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_capacity_markers_2066 (
    marker_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    capacity_name STRING,
    value NUMBER,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_comments_2051 (
    comment_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    body VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_escalations_2056 (
    escalation_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    policy_id STRING,
    escalated_to ARRAY,
    escalated_at TIMESTAMP_LTZ,
    resolved BOOLEAN DEFAULT FALSE,
    resolved_at TIMESTAMP_LTZ,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_escalation_policy_versions_2067 (
    version_id STRING PRIMARY KEY,
    policy_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    version_number INT,
    policy_definition VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_integrations_2068 (
    integration_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    provider STRING,
    config VARIANT,
    last_tested_at TIMESTAMP_LTZ,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_metrics_2057 (
    metric_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    unit STRING,
    captured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_notifications_2055 (
    notification_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    channel STRING,
    recipients ARRAY,
    payload VARIANT,
    sent_by STRING,
    sent_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_notification_mappings (
    mapping_id STRING PRIMARY KEY,
    followup_type STRING,
    channel_id STRING,
    template_id STRING,
    default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_reminders (
    reminder_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    remind_at TIMESTAMP_LTZ,
    remind_to VARIANT,
    delivered BOOLEAN DEFAULT FALSE,
    delivered_at TIMESTAMP_LTZ,
    instanceref STRING,
    feature_key STRING,
    org_id STRING
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_reminders_2059 (
    reminder_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    remind_at TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  delivered BOOLEAN DEFAULT FALSE,  delivered_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_retention_2069 (
    retention_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    retention_days INT,
    purge_scheduled_at TIMESTAMP_LTZ,
    last_purged_at TIMESTAMP_LTZ,
    status STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_retry_queue (
    queue_id STRING PRIMARY KEY,
    followup_id STRING,
    attempt_count INT DEFAULT 0,
    next_attempt_at TIMESTAMP_LTZ,
    last_error VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_sla_checks_2058 (
    sla_check_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    sla_name STRING,
    expected_resolution_by TIMESTAMP_LTZ,
    check_time TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  breached BOOLEAN DEFAULT FALSE,  breach_details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_sla_policies_2064 (
    policy_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    sla_name STRING,
    threshold_seconds NUMBER,
    severity STRING,
    notification_policy VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_sla_targets (
    target_id STRING PRIMARY KEY,
    followup_type STRING,
    target_duration_seconds INT,
    target_description STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_status_audit_2053 (
    audit_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    previous_status STRING,
    new_status STRING,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  note VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_tasks (
    id STRING PRIMARY KEY,
    followup_id STRING,
    task_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    assignee STRING,
    status STRING DEFAULT 'TODO',
    priority STRING,
    due_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_task_updates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_templates_2060 (
    template_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    created_by STRING,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_template_versions_2061 (
    version_id STRING PRIMARY KEY,
    template_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    version_number INT,
    template VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_workflow_states_2062 (
    state_id STRING PRIMARY KEY,
    workflow_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    ordinal INT,
    is_terminal BOOLEAN DEFAULT FALSE,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_followup_workflow_transitions_2063 (
    transition_id STRING PRIMARY KEY,
    workflow_id STRING,
    from_state_id STRING,
    to_state_id STRING,
    trigger STRING,
    guard_condition VARIANT,
    action VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_health_check_backoff_logs (
    backoff_id STRING PRIMARY KEY,
    check_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    consecutive_failures INT,
    backoff_until TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_impact_estimates (
    estimate_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    estimated_downtime_seconds NUMBER,
    estimated_customers_affected NUMBER,
    estimated_revenue_impact NUMBER,
    notes VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_acknowledgements (
    id STRING PRIMARY KEY,
    incident_id STRING,
    acknowledged_by STRING,
    acknowledgement_notes STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    acknowledged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_actions (
    id STRING PRIMARY KEY,
    incident_id STRING,
    action_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    description STRING,
    owner STRING,
    status STRING DEFAULT 'PENDING',
    activated_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_action_items (
    action_id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    description STRING,
    assignee STRING,
    priority STRING,
    status STRING DEFAULT 'OPEN',
    due_at TIMESTAMPLTZ,
    outcome VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , completed_at TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_action_item_comments (
    comment_id STRING PRIMARY KEY,
    action_item_id STRING,
    incident_id STRING,
    comment_text STRING,
    commented_by STRING,
    commented_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_assignments (
    assignment_id STRING PRIMARY KEY,
    incident_id STRING,
    task_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    assignee STRING,
    role STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  note VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_attachments (
    attachment_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    filename STRING,
    content_type STRING,
    storage_ref STRING,
    size_bytes NUMBER,
    uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_attachment_metadata (
    metadata_id STRING PRIMARY KEY,
    attachment_id STRING,
    incident_id STRING,
    origin_stage STRING,
    etag STRING,
    checksum STRING,
    additional_meta VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_bookmarks (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_changelogs (
    id STRING PRIMARY KEY,
    incident_id STRING,
    change_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    changed_by STRING,
    change_type STRING,
    details VARIANT,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_change_requests (
    id STRING PRIMARY KEY,
    incident_id STRING,
    change_summary STRING,
    change_details VARIANT,
    requested_by STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , approved BOOLEAN DEFAULT FALSE, approved_by STRING, approved_at TIMESTAMP_LTZ, instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_classifications (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_classification_rules (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_comments (
    comment_id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    body STRING,
    metadata VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_comment_edits (
    edit_id STRING PRIMARY KEY,
    comment_id STRING,
    incident_id STRING,
    previous_text STRING,
    new_text STRING,
    edited_by STRING,
    edited_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_communications (
    comm_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    channel STRING,
    subject STRING,
    body VARIANT,
    sent_by STRING,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_communication_log (
    id STRING PRIMARY KEY,
    incident_id STRING,
    channel STRING,
    recipients VARIANT,
    subject STRING,
    body VARIANT,
    sent_by STRING,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_commUNICATION_templates (
    template_id STRING PRIMARY KEY,
    name STRING,
    channel STRING,
    subject_template STRING,
    body_template VARIANT,
    default_enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_confidence_scores (
    score_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    score_name STRING,
    score_value FLOAT,
    computed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_contributors (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_escalations (
    escalation_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    level STRING,
    escalated_by STRING,
    reason VARIANT,
    escalated_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , resolved_at TIMESTAMPLTZ, status STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_escalation_history (
    escalation_id STRING PRIMARY KEY,
    incident_id STRING,
    escalation_level INT,
    notified_to VARIANT,
    notified_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  resolved_at TIMESTAMP_LTZ,  notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_escalation_rules (
    rule_id STRING PRIMARY KEY,
    orgid STRING,
    featurekey STRING,
    severity_level STRING,
    escalation_steps VARIANT,
    /* ordered steps with targets and delays */enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_evidence_links (
    evidence_link_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    evidence_manifest_id STRING,
    evidence_item_id STRING,
    link_type STRING,
    added_by STRING,
    added_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_feedback_surveys (
    survey_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    created_by STRING,
    survey_spec VARIANT,
    response_summary VARIANT,
    opened_at TIMESTAMP_LTZ,
    closed_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_2050 (
    followup_id STRING PRIMARY KEY,
    incident_id STRING,
    parent_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    followup_type STRING,
    title STRING,
    description VARIANT,
    assigned_to STRING,
    due_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'OPEN',
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_assignments (
    assignment_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    assigned_to STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  due_at TIMESTAMP_LTZ,  priority STRING DEFAULT 'MEDIUM',  instanceref STRING,  feature_key STRING,  org_id STRING,  assignment_metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_attachments_metadata (
    attachment_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    file_name STRING,
    content_type STRING,
    size_bytes NUMBER,
    stage_path STRING,
    etag STRING,
    checksum STRING,
    uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  instanceref STRING,  feature_key STRING,  org_id STRING,  extra_meta VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_audit (
    audit_id STRING PRIMARY KEY,
    followup_id STRING,
    action STRING,
    actor STRING,
    action_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_email_integrations (
    integration_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    to_addresses ARRAY,
    cc_addresses ARRAY,
    subject STRING,
    body VARIANT,
    message_id STRING,
    sent_at TIMESTAMP_LTZ,
    delivery_status STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_escalation_logs (
    escalation_log_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    escalation_level INT,
    notified_to VARIANT,
    notified_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  resolved_at TIMESTAMP_LTZ,  notes VARIANT,  instanceref STRING,  feature_key STRING,  org_id STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_escalation_policies (
    policy_id STRING PRIMARY KEY,
    name STRING,
    followup_types ARRAY,
    levels VARIANT,
    notification_rules VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_history (
    history_id STRING PRIMARY KEY,
    followup_id STRING,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    followup_type STRING,
    payload VARIANT,
    status STRING,
    changed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , changed_by STRING, change_reason VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_integration_status (
    status_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    integration_name STRING,
    last_synced_at TIMESTAMP_LTZ,
    last_synced_payload VARIANT,
    sync_status STRING,
    error_details VARIANT,
    instanceref STRING,
    feature_key STRING,
    org_id STRING
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_kpi_logs (
    kpi_log_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    kpi_name STRING,
    kpi_value NUMBER,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  instanceref STRING,  feature_key STRING,  org_id STRING,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_metrics_rollup (
    rollup_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    metric_name STRING,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    aggregation_method STRING,
    value NUMBER,
    instanceref STRING,
    feature_key STRING,
    org_id STRING
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_notes (
    note_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    author STRING,
    note TEXT,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_notification_mappings (
    mapping_id STRING PRIMARY KEY,
    followup_type STRING,
    channel STRING,
    template_id STRING,
    channel_config VARIANT,
    default_mapping BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  created_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_personalization_settings (
    setting_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    user_id STRING,
    preferences VARIANT,
    last_updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  instanceref STRING,  feature_key STRING,  org_id STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_retention_policies (
    policy_id STRING PRIMARY KEY,
    followup_type STRING,
    retention_days INT,
    archival_target VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_retry_queue (
    queue_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    attempt_count INT DEFAULT 0,
    last_error VARIANT,
    next_attempt_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  instanceref STRING,  feature_key STRING,  org_id STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_slack_integrations (
    integration_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    workspace_id STRING,
    channel_id STRING,
    message_ts STRING,
    delivered BOOLEAN DEFAULT FALSE,
    delivered_at TIMESTAMP_LTZ,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_sla_targets (
    sla_target_id STRING PRIMARY KEY,
    followup_type STRING,
    target_seconds INT,
    description STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_statuses (
    status_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    status STRING,
    updated_by STRING,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  instanceref STRING,  feature_key STRING,  org_id STRING,  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_tag_mappings (
    mapping_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    tag STRING,
    tagged_by STRING,
    tagged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  instanceref STRING,  feature_key STRING,  org_id STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_templates (
    template_id STRING PRIMARY KEY,
    name STRING,
    channel STRING,
    subject_template STRING,
    body_template VARIANT,
    variables VARIANT,
    default BOOLEAN DEFAULT FALSE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  version INT DEFAULT 1);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    followup_type STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    details VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_at TIMESTAMP_LTZ,  status STRING DEFAULT 'OPEN');


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followups_webhook_events (
    event_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    webhook_name STRING,
    payload VARIANT,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  response_status INT,  response_payload VARIANT,  retry_count INT DEFAULT 0,  next_retry_at TIMESTAMP_LTZ,  instanceref STRING,  feature_key STRING,  org_id STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_action_templates (
    action_template_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    action_spec VARIANT,
    created_by STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_assignments (
    assignment_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    assigned_to STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  due_at TIMESTAMP_LTZ,  priority STRING DEFAULT 'MEDIUM',  status STRING DEFAULT 'ASSIGNED');


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_attachments (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_audit_log (
    audit_id STRING PRIMARY KEY,
    entity_id STRING,
    entity_type STRING,
    action STRING,
    actor STRING,
    action_details VARIANT,
    action_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_audit_trail (
    audit_id STRING PRIMARY KEY,
    entity_id STRING,
    entity_type STRING,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    acted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_commands (
    command_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    command_name STRING,
    payload VARIANT,
    invoked_by STRING,
    invoked_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , result VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_comments (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_escalation_logs (
    escalation_log_id STRING PRIMARY KEY,
    escalation_id STRING,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    level STRING,
    escalated_by STRING,
    reason VARIANT,
    escalated_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , resolved_at TIMESTAMPLTZ, resolution_notes VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_escalation_rules (
    rule_id STRING PRIMARY KEY,
    followup_type STRING,
    escalation_steps VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_external_refs (
    ext_ref_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    external_system STRING,
    external_id STRING,
    url STRING,
    added_by STRING,
    added_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_integrations_sync (
    integration_sync_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    integration_name STRING,
    external_reference STRING,
    sync_status STRING,
    last_synced_at TIMESTAMPLTZ,
    config VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_integration_events (
    event_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    integration_name STRING,
    event_payload VARIANT,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  delivery_status STRING,  response VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_kpi_tracking (
    kpi_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    kpi_name STRING,
    kpi_value NUMBER,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_learning_items (
    learning_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    content VARIANT,
    created_by STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_metrics (
    id STRING PRIMARY KEY,
    incident_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    metric_unit STRING,
    captured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_notifications (
    notification_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    channel STRING,
    recipient STRING,
    payload VARIANT,
    status STRING DEFAULT 'QUEUED',
    attempted_at TIMESTAMPLTZ,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_postmortem_checklist (
    checklist_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    items VARIANT,
    completed BOOLEAN DEFAULT FALSE,
    completed_by STRING,
    completed_at TIMESTAMPLTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_publish_history (
    publish_history_id STRING PRIMARY KEY,
    publish_queue_id STRING,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    target STRING,
    payload VARIANT,
    status STRING,
    attempted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , result VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_publish_queue (
    publish_queue_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    target STRING,
    payload VARIANT,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    next_attempt_at TIMESTAMPLTZ,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_ratings (
    rating_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    rater STRING,
    rating INT,
    comment STRING,
    rated_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_resolution_templates (
    template_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    created_by STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_retro_votes (
    vote_id STRING PRIMARY KEY,
    retro_id STRING,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    voter STRING,
    vote_value INT,
    comment STRING,
    voted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_sla_metrics (
    sla_metric_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    measured_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_subscription (
    subscription_id STRING PRIMARY KEY,
    incident_id STRING,
    subscriber STRING,
    notify_via STRING,
    preferences VARIANT,
    subscribed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_tasks (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_tasks_history (
    task_hist_id STRING PRIMARY KEY,
    task_id STRING,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    description STRING,
    assignee STRING,
    status_before STRING,
    status_after STRING,
    changed_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , changed_by STRING, metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_templates (
    template_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    template_body VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_types (
    type_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    default_duration_days INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_followup_visibility_changes (
    visibility_change_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    principal_type STRING,
    principal_id STRING,
    permission STRING,
    granted_by STRING,
    granted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , expires_at TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_integrations (
    integration_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    integration_name STRING,
    external_reference STRING,
    config VARIANT,
    status STRING,
    last_synced_at TIMESTAMPLTZ,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_kpi_samples (
    sample_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    sample_ts TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_labels (
    label_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    label STRING,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_links (
    link_id STRING PRIMARY KEY,
    incident_id STRING,
    linked_incident_id STRING,
    relationship_type STRING,
    -- DUPLICATE/CAUSE/RELATED noted_by STRING,
    noted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_metrics_archive (
    id STRING PRIMARY KEY,
    incident_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    metric_unit STRING,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING, metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_metrics_definitions (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    metric_name STRING,
    metric_spec VARIANT,
    unit STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_metric_samples (
    id STRING PRIMARY KEY,
    metric_def_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    sample_ts TIMESTAMP_LTZ,
    value NUMBER,
    tags VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_notes (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_note_edits (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_notifications (
    notification_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    channel STRING,
    recipient STRING,
    payload VARIANT,
    status STRING DEFAULT 'QUEUED',
    attempted_at TIMESTAMPLTZ,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_notifications_config (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_notification_history (
    notification_id STRING PRIMARY KEY,
    incident_id STRING,
    channel STRING,
    recipients VARIANT,
    template_id STRING,
    sent_by STRING,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  delivery_status STRING,  delivery_response VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_notification_sends (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_notification_templates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_owners (
    id STRING PRIMARY KEY,
    incident_id STRING,
    owner_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    role STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , removed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_ownership_history (
    id STRING PRIMARY KEY,
    incident_id STRING,
    owner_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , released_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_owner_history (
    id STRING PRIMARY KEY,
    incident_id STRING,
    previous_owner STRING,
    new_owner STRING,
    changed_by STRING,
    change_reason STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_participants (
    participant_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    user_id STRING,
    role STRING,
    contact VARIANT,
    joined_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , left_at TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_playbooks (
    playbook_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    playbook_name STRING,
    steps VARIANT,
    current_step INT,
    metadata VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_postmortem_actions (
    id STRING PRIMARY KEY,
    incident_id STRING,
    action_title STRING,
    action_description STRING,
    owner STRING,
    target_date TIMESTAMP_LTZ,
    status STRING DEFAULT 'OPEN',
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_postmortem_action_status (
    status_id STRING PRIMARY KEY,
    postmortem_action_id STRING,
    incident_id STRING,
    owner STRING,
    status STRING DEFAULT 'OPEN',
    last_updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  status_details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_postmortem_documents (
    id STRING PRIMARY KEY,
    incident_id STRING,
    document_title STRING,
    document_path STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_recovery_steps (
    step_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    description VARIANT,
    executed_by STRING,
    executed_at TIMESTAMP_LTZ,
    outcome VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_related_alerts (
    id STRING PRIMARY KEY,
    incident_id STRING,
    alert_id STRING,
    alert_source STRING,
    alert_severity STRING,
    alert_time TIMESTAMP_LTZ,
    instanceref STRING,
    feature_key STRING,
    org_id STRING
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_related_changes (
    related_change_id STRING PRIMARY KEY,
    incident_id STRING,
    change_ticket_id STRING,
    change_description VARIANT,
    linked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  linked_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_reports (
    id STRING PRIMARY KEY,
    incident_id STRING,
    report_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    report_body VARIANT,
    generated_by STRING,
    generated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_resolutions (
    resolution_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    resolution_text STRING,
    resolved_by STRING,
    resolution_type STRING,
    resolution_evidence VARIANT,
    resolved_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_resolution_steps (
    id STRING PRIMARY KEY,
    incident_id STRING,
    step_order INT,
    description STRING,
    performed_by STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    performed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_response_playbooks (
    playbook_id STRING PRIMARY KEY,
    orgid STRING,
    playbook_name STRING,
    playbook_payload VARIANT,
    version INT DEFAULT 1,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_retrospectives (
    retro_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    summary VARIANT,
    actions VARIANT,
    author STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_risk_assessments (
    id STRING PRIMARY KEY,
    incident_id STRING,
    risk_level STRING,
    likelihood STRING,
    impact STRING,
    assessor STRING,
    assessment_notes VARIANT,
    assessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_rootcause_analysis (
    analysis_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    analysis_payload VARIANT,
    analyst STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_root_causes (
    root_cause_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    root_cause TEXT,
    confidence FLOAT,
    evidence VARIANT,
    created_by STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_root_cause_analysis (
    id STRING PRIMARY KEY,
    incident_id STRING,
    rca_summary STRING,
    rca_details VARIANT,
    authors VARIANT,
    rca_timestamp TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_root_cause_evidence (
    evidence_id STRING PRIMARY KEY,
    incident_id STRING,
    rca_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    evidence_type STRING,
    evidence_ref STRING,
    metadata VARIANT,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_root_cause_templates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_sensitivity_tags (
    tag_id STRING PRIMARY KEY,
    incident_id STRING,
    tag STRING,
    sensitivity_level STRING,
    applied_by STRING,
    applied_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_severity_history (
    sev_hist_id STRING PRIMARY KEY,
    incident_id STRING,
    previous_severity STRING,
    new_severity STRING,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  reason STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_severity_levels (
    severity_id STRING PRIMARY KEY,
    orgid STRING,
    level_name STRING,
    description STRING,
    sla_minutes NUMBER,
    notify_escalation BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_severity_thresholds (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_sla_breaches (
    id STRING PRIMARY KEY,
    incident_id STRING,
    sla_name STRING,
    breach_duration_seconds NUMBER,
    breach_reason STRING,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , resolved_at TIMESTAMP_LTZ, instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_slrs (
    slr_id STRING PRIMARY KEY,
    orgid STRING,
    featurekey STRING,
    metric_name STRING,
    objective_number NUMBER,
    window_minutes INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_snapshots (
    snapshot_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    snapshot_path STRING,
    snapshot_hash STRING,
    snapshot_metadata VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_status_history (
    history_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    from_status STRING,
    to_status STRING,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  note VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_summaries (
    summary_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    summary_text STRING,
    author STRING,
    summary_type STRING,
    metadata VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_summaries_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    summary_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    executive_summary VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , published_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_summary_views (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    view_name STRING,
    view_definition VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_tags (
    tag_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    tag STRING,
    added_by STRING,
    added_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_tasks (
    task_id STRING PRIMARY KEY,
    incident_id STRING,
    parent_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    description VARIANT,
    assignee STRING,
    priority STRING,
    status STRING,
    started_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_task_attachments (
    id STRING PRIMARY KEY,
    task_id STRING,
    incident_id STRING,
    file_name STRING,
    file_path STRING,
    file_size NUMBER,
    content_type STRING,
    uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_telemetry (
    id STRING PRIMARY KEY,
    incident_id STRING,
    telemetry_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    metric_unit STRING,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_timeline (
    timeline_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    actor STRING,
    action_type STRING,
    details VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_timelines (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_timeline_notes (
    note_id STRING PRIMARY KEY,
    timeline_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    note VARIANT,
    note_type STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_training_examples (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    example_payload VARIANT,
    label STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_visibility (
    visibility_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    principal_type STRING,
    principal_id STRING,
    permission STRING,
    granted_by STRING,
    granted_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , expires_at TIMESTAMPLTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_integration_health (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_integration_health_v2 (
    id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    integration_name STRING,
    status STRING,
    last_checked_at TIMESTAMP_LTZ,
    details VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_kb_links (
    id STRING PRIMARY KEY,
    kb_link_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    url STRING,
    summary VARIANT,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_kpi_breach_events (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_kpi_thresholds (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_learning_items (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    learning_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    description VARIANT,
    owner STRING,
    status STRING DEFAULT 'OPEN',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_learning_items_v2 (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    learning_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    description VARIANT,
    owner STRING,
    status STRING DEFAULT 'OPEN',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_maintenance_feedback (
    feedback_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    submitted_by STRING,
    feedback VARIANT,
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_postmortem_linksCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_links (link_id STRING PRIMARY KEY,postmortem_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,url STRING,description STRING,added_by STRING,added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_notification_preferencesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_notification_preferences (preference_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,user_id STRING,channel STRING,config VARIANT,updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_integration_healthCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_integration_health (health_id STRING PRIMARY KEY,integration_key STRING,instance_ref STRING,feature_key STRING,org_id STRING,status STRING,last_checked_at TIMESTAMP_LTZ,details VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_maintenance_kpisCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_maintenance_kpis (kpi_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,metric_name STRING,metric_value FLOAT,metric_metadata VARIANT,recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_playbook_usageCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_playbook_usage (usage_id STRING PRIMARY KEY,playbook_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,user_id STRING,action VARIANT,used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_postmortem_metrics_rollupsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_metrics_rollups (rollup_id STRING PRIMARY KEY,postmortem_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,metrics VARIANT,rollup_period STRING,rolled_up_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_postmortem_notificationsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_notifications (notification_id STRING PRIMARY KEY,postmortem_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,recipient STRING,payload VARIANT,notified_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_root_cause_tagsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_tags (tag_id STRING PRIMARY KEY,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,tag STRING,tagged_by STRING,tagged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_root_cause_referencesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_references (ref_id STRING PRIMARY KEY,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,reference VARIANT,added_by STRING,added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_incident_severity_thresholdsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_incident_severity_thresholds (threshold_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,metric_name STRING,severity_level STRING,operator STRING,value FLOAT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_alert_annotationCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_annotation (annotation_id STRING PRIMARY KEY,alert_id STRING,feature_key STRING,instance_ref STRING,org_id STRING,author STRING,note VARIANT,annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_alert_grouping_rulesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_grouping_rules (rule_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,rule_definition VARIANT,enabled BOOLEAN DEFAULT TRUE,created_by STRING,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_alert_grouping_resultsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_grouping_results (result_id STRING PRIMARY KEY,grouping_rule_id STRING,alert_ids ARRAY,instance_ref STRING,feature_key STRING,org_id STRING,result VARIANT,evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_escalation_policiesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_escalation_policies (policy_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,policy_name STRING,policy_definition VARIANT,created_by STRING,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_escalation_actionsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_escalation_actions (action_id STRING PRIMARY KEY,policy_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,action_type STRING,action_payload VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_slo_rollup_resultsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_slo_rollup_results (result_id STRING PRIMARY KEY,config_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,metrics VARIANT,period_start TIMESTAMP_LTZ,period_end TIMESTAMP_LTZ,computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_anomaly_detectionsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_anomaly_detections (detection_id STRING PRIMARY KEY,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,detection_payload VARIANT,severity STRING,detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_model_explainability_configsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_model_explainability_configs (config_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,model_id STRING,explainability_params VARIANT,created_by STRING,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) Artifact: AI_FEATURE_HUB.docgen_feature_instance_explainability_artifactsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_explainability_artifacts (artifact_id STRING PRIMARY KEY,config_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,artifact VARIANT,generated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
) CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen4201featureinstance_service_tokens ( token_id STRING PRIMARY KEY, instance_ref STRING, feature_key STRING, org_id STRING, token_ref STRING, issued_to STRING, scopes ARRAY, expires_at TIMESTAMP_LTZ, issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_maintenance_feedback_log (
    feedback_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    submitted_by STRING,
    feedback VARIANT,
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_maintenance_kpis (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_maintenance_kpis_v2 (
    id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    kpi_name STRING,
    kpi_value NUMBER,
    measurement_unit STRING,
    measured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_model_call_traces (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    model_id STRING,
    request_payload VARIANT,
    response_payload VARIANT,
    latency_ms NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_notifications_log (
    id STRING PRIMARY KEY,
    notification_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    recipient STRING,
    channel STRING,
    payload VARIANT,
    status STRING,
    attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , result VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_notification_preferences (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_notification_preferences_v2 (
    id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    user_id STRING,
    channel STRING,
    enabled BOOLEAN DEFAULT TRUE,
    preferences VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_notification_rules (
    rule_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    event_types ARRAY,
    channels ARRAY,
    recipients ARRAY,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_notification_templates (
    template_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    template_name STRING,
    channel STRING,
    subject_template STRING,
    body_template VARIANT,
    variables_spec VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_oncall_roster (
    roster_id STRING PRIMARY KEY,
    team STRING,
    members VARIANT,
    rotation_policy VARIANT,
    effective_from TIMESTAMP_LTZ,
    effective_to TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_operational_metrics (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_operational_metrics_history (
    metric_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    sampled_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_operational_risk_register (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_operational_runbooks (
    runbook_id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    content VARIANT,
    version INT DEFAULT 1,
    status STRING DEFAULT 'ACTIVE',
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_at TIMESTAMP_LTZ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_performance_trends (
    trend_id STRING PRIMARY KEY,
    metric_name STRING,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    aggregate_function STRING,
    value NUMBER,
    instanceref STRING,
    feature_key STRING,
    org_id STRING
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_playbooks (
    playbook_id STRING PRIMARY KEY,
    title STRING,
    description STRING,
    triggers VARIANT,
    steps VARIANT,
    owner STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_playbook_steps (
    id STRING PRIMARY KEY,
    playbook_id STRING,
    step_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    step_order INT,
    title STRING,
    instruction VARIANT,
    expected_outcome VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_playbook_templates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_playbook_usage (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_playbook_usage_v2 (
    id STRING PRIMARY KEY,
    playbook_usage_id STRING,
    playbook_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    invoked_by STRING,
    context VARIANT,
    result VARIANT,
    invoked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_playbook_versions (
    id STRING PRIMARY KEY,
    playbook_id STRING,
    version_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    changes VARIANT,
    released_by STRING,
    released_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_policy_change_audit (
    audit_id STRING PRIMARY KEY,
    request_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    action STRING,
    -- 'SUBMIT',
    'APPROVE',
    'REJECT',
    'APPLY' actor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_policy_change_decisions (
    decision_id STRING PRIMARY KEY,
    request_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    decision_by STRING,
    decision STRING,
    -- 'APPROVE' / 'REJECT' comment STRING,
    decided_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_policy_change_requests (
    request_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    requested_by STRING,
    policy_payload VARIANT,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_actions (
    action_id STRING PRIMARY KEY,
    postmortem_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    owner STRING,
    description STRING,
    due_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'OPEN',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , completed_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_action_attachments (
    attachment_id STRING PRIMARY KEY,
    action_id STRING,
    postmortem_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    file_name STRING,
    stage_path STRING,
    content_type STRING,
    size_bytes NUMBER,
    uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  checksum STRING,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_action_comments (
    comment_id STRING PRIMARY KEY,
    action_id STRING,
    postmortem_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    comment_text STRING,
    commented_by STRING,
    commented_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_action_items (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    action_item_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    description VARIANT,
    owner STRING,
    status STRING DEFAULT 'OPEN',
    priority STRING,
    due_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_action_items_v2 (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    action_item_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    description VARIANT,
    owner STRING,
    status STRING DEFAULT 'OPEN',
    priority STRING,
    due_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_action_priorities (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_action_updates (
    update_id STRING PRIMARY KEY,
    action_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    update_by STRING,
    update_notes STRING,
    update_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_dashboards (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_dashboard_views (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_documents (
    id STRING PRIMARY KEY,
    incident_id STRING,
    document_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    document VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_lessons_learned (
    lesson_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    lesson_text VARIANT,
    recommended_actions VARIANT,
    reported_by STRING,
    reported_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_links (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_links_v2 (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    link_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    url STRING,
    link_type STRING,
    description STRING,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_metadata (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    status STRING DEFAULT 'DRAFT',
    summary VARIANT,
    published_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_metrics (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_metrics_rollups (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_metrics_rollups_v2 (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    rollup_period STRING,
    rollup_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_notes (
    note_id STRING PRIMARY KEY,
    postmortem_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    content VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_notifications (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_notifications_v2 (
    id STRING PRIMARY KEY,
    notification_id STRING,
    postmortem_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    channel STRING,
    recipients ARRAY,
    payload VARIANT,
    status STRING,
    sent_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_outcomes (
    outcome_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    summary VARIANT,
    impact_estimate VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_participants (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    participant_name STRING,
    role STRING,
    contact_info VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_publications (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    publication_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    audience VARIANT,
    delivery_channel STRING,
    published_by STRING,
    published_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_publications_v2 (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    publication_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    audience VARIANT,
    delivery_channel STRING,
    published_by STRING,
    published_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_readers (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    reader_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    permission_level STRING,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_readings (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_retro_actions (
    retro_action_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    description VARIANT,
    owner STRING,
    status STRING DEFAULT 'OPEN',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  closed_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_reviews (
    review_id STRING PRIMARY KEY,
    incident_id STRING,
    review_notes VARIANT,
    reviewers VARIANT,
    outcome STRING,
    reviewed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_review_sessions (
    session_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    scheduled_by STRING,
    scheduled_at TIMESTAMP_LTZ,
    duration_seconds INT,
    agenda VARIANT,
    outcome VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_signoffs (
    signoff_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    approver STRING,
    role STRING,
    decision STRING,
    -- APPROVED/REJECTED notes VARIANT,
    decided_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_summary (
    summary_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    abstract VARIANT,
    findings VARIANT,
    recommendations VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_tasks (
    pm_task_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    description VARIANT,
    owner STRING,
    due_at TIMESTAMP_LTZ,
    status STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_templates (
    id STRING PRIMARY KEY,
    template_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    sections VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_templates_v2 (
    template_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    template_body VARIANT,
    variables VARIANT,
    version INT DEFAULT 1,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_timeline (
    timeline_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    step_index INT,
    step_title STRING,
    step_description VARIANT,
    actor STRING,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_priority_levels (
    id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    rank INT,
    sla_multiplier NUMBER DEFAULT 1.0,
    description STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_priority_levels_v2 (
    id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    rank INT,
    sla_multiplier NUMBER DEFAULT 1.0,
    description STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_rate_rules (
    rule_id STRING PRIMARY KEY,
    template_id STRING,
    feature_key STRING,
    instanceref STRING,
    org_id STRING,
    config VARIANT,
    priority INT DEFAULT 100,
    active BOOLEAN DEFAULT TRUE,
    effective_from TIMESTAMP_LTZ,
    effective_to TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_rate_rule_templates (
    template_id STRING PRIMARY KEY,
    feature_key STRING,
    org_id STRING,
    name STRING,
    description STRING,
    config VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_regression_tests (
    id STRING PRIMARY KEY,
    test_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    test_name STRING,
    test_definition VARIANT,
    last_run_at TIMESTAMP_LTZ,
    last_run_result STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_regression_tests_v2 (
    id STRING PRIMARY KEY,
    test_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    test_name STRING,
    test_definition VARIANT,
    last_run_at TIMESTAMP_LTZ,
    last_run_result STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_related_alerts (
    rel_alert_id STRING PRIMARY KEY,
    incident_id STRING,
    alert_id STRING,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    correlation_score FLOAT,
    matched_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  evidence VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_related_change_requests (
    id STRING PRIMARY KEY,
    incident_id STRING,
    change_request_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    summary STRING,
    status STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_related_change_requests_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    change_request_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    summary STRING,
    status STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_release_checklists (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    checklist_name STRING,
    checklist_payload VARIANT,
    version INT DEFAULT 1,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_release_checklist_completions (
    id STRING PRIMARY KEY,
    checklist_id STRING,
    release_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    completed_by STRING,
    completion_payload VARIANT,
    completed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_release_notes (
    note_id STRING PRIMARY KEY,
    deployment_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    notes VARIANT,
    authored_by STRING,
    authored_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_release_postmortem_actions (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_release_postmortem_action_updates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_release_postmortem_checklist (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_release_postmortem_results (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_remediation_runs (
    run_id STRING PRIMARY KEY,
    task_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    initiated_by STRING,
    actions VARIANT,
    result VARIANT,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_remediation_tasks (
    task_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    task_type STRING,
    description VARIANT,
    created_by STRING,
    assigned_to STRING,
    status STRING DEFAULT 'OPEN',
    started_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_reopen_history (
    id STRING PRIMARY KEY,
    incident_id STRING,
    reopen_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    reopened_by STRING,
    reopened_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , reason VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_resolution_codes (
    id STRING PRIMARY KEY,
    code STRING,
    description STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_resolution_notes (
    note_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    note VARIANT,
    authored_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_response_time_metrics (
    id STRING PRIMARY KEY,
    incident_id STRING,
    metric_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    value NUMBER,
    measured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_reviewer_assignments (
    id STRING PRIMARY KEY,
    review_id STRING,
    reviewer_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING DEFAULT 'ASSIGNED' );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_reviewer_assignments_v2 (
    id STRING PRIMARY KEY,
    review_id STRING,
    reviewer_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING DEFAULT 'ASSIGNED' );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_review_comments (
    id STRING PRIMARY KEY,
    review_id STRING,
    comment_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    comment VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , resolved BOOLEAN DEFAULT FALSE, resolved_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_review_comments_v2 (
    id STRING PRIMARY KEY,
    review_id STRING,
    comment_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    comment VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , resolved BOOLEAN DEFAULT FALSE, resolved_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_risk_assessments (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    assessment_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    risks VARIANT,
    mitigations VARIANT,
    assessed_by STRING,
    assessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_risk_assessments_v2 (
    id STRING PRIMARY KEY,
    postmortem_id STRING,
    assessment_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    risks VARIANT,
    mitigations VARIANT,
    assessed_by STRING,
    assessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_risk_mitigation_updates (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_rollback_actions (
    rollback_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action_name STRING,
    action_params VARIANT,
    executed BOOLEAN DEFAULT FALSE,
    executed_at TIMESTAMP_LTZ,
    executed_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_rollback_records (
    rollback_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    reason VARIANT,
    artifacts VARIANT,
    executed_by STRING,
    executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_analysis (
    rca_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    summary VARIANT,
    contributors ARRAY,
    severity STRING,
    conclusions VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_analysis_notes (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_evidence (
    id STRING PRIMARY KEY,
    rca_id STRING,
    evidence_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    evidence_type STRING,
    evidence_path STRING,
    metadata VARIANT,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_evidence_v2 (
    id STRING PRIMARY KEY,
    rca_id STRING,
    evidence_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    evidence_type STRING,
    evidence_path STRING,
    metadata VARIANT,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_references (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_tags (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runbooks (
    id STRING PRIMARY KEY,
    runbook_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    content VARIANT,
    version INT DEFAULT 1,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runbook_change_audit (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,change_type STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runbook_change_decisions (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    decision_by STRING,
    decision_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,decision STRING,notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runbook_change_requests (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    requested_by STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,status STRING DEFAULT 'PENDING');


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runbook_checklists (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runbook_checklist_usages (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runtime_diagnostics (
    diag_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    diagnostic_type STRING,
    payload VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_scheduled_health_checks (
    schedule_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    check_id STRING,
    next_run_at TIMESTAMP_LTZ,
    cadence_seconds INT,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_service_dependency_graphs (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_service_impact (
    id STRING PRIMARY KEY,
    incident_id STRING,
    impact_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    affected_services ARRAY,
    severity STRING,
    customer_impact VARIANT,
    reported_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_service_impact_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    impact_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    affected_services ARRAY,
    severity STRING,
    customer_impact VARIANT,
    reported_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_service_level_reports (
    id STRING PRIMARY KEY,
    report_id STRING,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    report_payload VARIANT,
    generated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_service_level_report_runs (
    id STRING PRIMARY KEY,
    report_id STRING,
    run_id STRING,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    run_payload VARIANT,
    run_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_service_level_report_subscribers (
    subscriber_id STRING PRIMARY KEY,
    report_id STRING,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    subscriber_contact VARIANT,
    delivery_preferences VARIANT,
    subscribed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  unsubscribed_at TIMESTAMP_LTZ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_service_tokens (
    token_id STRING PRIMARY KEY,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    token_ref STRING,
    issued_to STRING,
    scopes ARRAY,
    expires_at TIMESTAMP_LTZ,
    issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_service_token_audit (
    audit_id STRING PRIMARY KEY,
    token_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    actor STRING,
    notes VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_severity_history (
    id STRING PRIMARY KEY,
    incident_id STRING,
    severity_record_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    previous_severity STRING,
    new_severity STRING,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_sla_acknowledgements (
    ack_id STRING PRIMARY KEY,
    breach_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    acknowledged_by STRING,
    acknowledged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  note VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_sla_breaches (
    breach_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    sla_name STRING,
    expected_resolution_by TIMESTAMP_LTZ,
    actual_resolved_at TIMESTAMP_LTZ,
    breach_duration_seconds NUMBER,
    details VARIANT,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_sla_configurations (
    id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    sla_name STRING,
    target_duration_seconds NUMBER,
    measurement_window STRING,
    breach_policy VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_sla_configurations_v2 (
    id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    sla_name STRING,
    target_duration_seconds NUMBER,
    measurement_window STRING,
    breach_policy VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_slo_policies (
    slo_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    service_level_target VARIANT,
    measurement_window VARIANT,
    alert_thresholds VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_slo_rollup_configs (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_snapshot_archives (
    snapshot_id STRING PRIMARY KEY,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    org_id STRING,
    snapshot_stage_path STRING,
    snapshot_metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_stakeholder_contacts (
    contact_id STRING PRIMARY KEY,
    incident_id STRING,
    name STRING,
    role STRING,
    contact_methods VARIANT,
    preferred BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_state_transitions (
    transition_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    transition_name STRING,
    triggered_by STRING,
    triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_status_transitions (
    id STRING PRIMARY KEY,
    incident_id STRING,
    from_status STRING,
    to_status STRING,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , reason VARIANT, instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_status_transitions_v2 (
    id STRING PRIMARY KEY,
    incident_id STRING,
    from_status STRING,
    to_status STRING,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , reason VARIANT, instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_supplemental_notes (
    id STRING PRIMARY KEY,
    incident_id STRING,
    note_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    note VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_synthetic_tests (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_synthetic_test_alerting (
    id STRING PRIMARY KEY,
    test_id STRING,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    alert_payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_synthetic_test_alerts (
    alert_id STRING PRIMARY KEY,
    test_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    severity STRING,
    message STRING,
    payload VARIANT,
    acknowledged BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,acknowledged_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_synthetic_test_runs (
    id STRING PRIMARY KEY,
    test_id STRING,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    result VARIANT,
    run_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_synthetic_test_schedule_logs (
    log_id STRING PRIMARY KEY,
    test_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    scheduled_at TIMESTAMP_LTZ,
    triggered_at TIMESTAMP_LTZ,
    status STRING,
    result VARIANT,
    attempts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_tag_mappings (
    mapping_id STRING PRIMARY KEY,
    incident_id STRING,
    tag STRING,
    tagged_by STRING,
    tagged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , instanceref STRING, feature_key STRING, org_id STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_telemetry_mapping_configs (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_telemetry_mapping_hist (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_testing_plans (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_testing_runs (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_test_run_results (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_third_party_incident_mappings (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    external_system STRING,
    external_reference STRING,
    mapping_payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_third_party_integration_configs (
    config_id STRING PRIMARY KEY,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    integration_name STRING,
    config_payload VARIANT,
    enabled BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_third_party_integration_health (
    health_id STRING PRIMARY KEY,
    config_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    last_checked_at TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_third_party_notification_logs (
    log_id STRING PRIMARY KEY,
    config_id STRING,
    instanceref STRING,
    featurekey STRING,
    orgid STRING,
    notification_payload VARIANT,
    sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    status STRING,
    response_payload VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_timelines (
    timeline_id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    event_type STRING,
    payload VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_user_feedback (
    id STRING PRIMARY KEY,
    incident_id STRING,
    user_id STRING,
    rating INT,
    comments STRING,
    contact_permission BOOLEAN DEFAULT FALSE,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_visibility_views (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_visibility_view_access_logs (
    id STRING PRIMARY KEY,
    parent_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    payload VARIANT,
    accessed_by STRING,
    accessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_integration_health_checks (
    check_id STRING PRIMARY KEY,
    integration_id STRING,
    org_id STRING,
    status STRING,
    last_checked_at TIMESTAMP_LTZ,
    details VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_model_deployment_history (
    deployment_id STRING PRIMARY KEY,
    model_id STRING,
    model_version_id STRING,
    env STRING,
    deployed_by STRING,
    deployed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , endpoint STRING, config VARIANT, metrics VARIANT, status STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_model_registry (
    model_id STRING PRIMARY KEY,
    model_name STRING,
    provider STRING,
    model_type STRING,
    default_version STRING,
    metadata VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_model_registry_deployments (
    deployment_id STRING PRIMARY KEY,
    model_id STRING,
    version_id STRING,
    env STRING,
    deployed_by STRING,
    deployed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , endpoint STRING, status STRING, metrics VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_model_registry_versions (
    model_id STRING,
    version_id STRING PRIMARY KEY,
    org_id STRING,
    metadata VARIANT,
    artifact_location STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_model_versions (
    model_version_id STRING PRIMARY KEY,
    model_id STRING,
    version STRING,
    artifact_location STRING,
    signature VARIANT,
    metrics VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_notification_delivery_history (
    delivery_id STRING PRIMARY KEY,
    dispatch_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    recipient STRING,
    channel STRING,
    status STRING,
    attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , result VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_notification_dispatch_queue (
    dispatch_id STRING PRIMARY KEY,
    rule_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    recipient STRING,
    channel STRING,
    payload VARIANT,
    scheduled_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_rate_rules (
    rule_id STRING PRIMARY KEY,
    staging_id STRING,
    template_id STRING,
    feature_key STRING,
    instanceref STRING,
    org_id STRING,
    rule_type STRING,
    config VARIANT,
    priority INT DEFAULT 100,
    active BOOLEAN DEFAULT TRUE,
    effective_from TIMESTAMP_LTZ,
    effective_to TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_rate_rules_approval_audit (
    audit_id STRING PRIMARY KEY,
    staging_id STRING,
    action STRING,
    actor STRING,
    action_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_rate_rules_staging (
    staging_id STRING PRIMARY KEY,
    feature_key STRING,
    rule_type STRING,
    config VARIANT,
    priority INT,
    submitted_by STRING,
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , approved BOOLEAN DEFAULT FALSE, approved_by STRING, approved_at TIMESTAMP_LTZ, rejected BOOLEAN DEFAULT FALSE, reject_reason STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_rate_rule_templates_metadata (
    template_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    version STRING,
    author STRING,
    tags ARRAY,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_scheduled_tasks (
    task_id STRING PRIMARY KEY,
    name STRING,
    owner STRING,
    schedule_cron STRING,
    task_spec VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    last_run_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_scheduled_task_registry (
    task_id STRING PRIMARY KEY,
    name STRING,
    owner STRING,
    schedule_cron STRING,
    task_payload VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    last_run_at TIMESTAMP_LTZ,
    next_run_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_schema_migrations (
    migration_id STRING PRIMARY KEY,
    version STRING,
    description STRING,
    applied_by STRING,
    applied_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , checksum STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_schema_migration_history (
    migration_id STRING PRIMARY KEY,
    migration_name STRING,
    version STRING,
    description STRING,
    applied_by STRING,
    applied_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , checksum STRING, metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_similarity_indexes (
    index_id STRING PRIMARY KEY,
    index_name STRING,
    algorithm STRING,
    dimension INT,
    metric STRING,
    shard_count INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_similarity_index_metadata (
    index_id STRING PRIMARY KEY,
    index_name STRING,
    algorithm STRING,
    dimension INT,
    metric STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_slo_metrics (
    metric_id STRING PRIMARY KEY,
    org_id STRING,
    metric_name STRING,
    metric_value FLOAT,
    metric_tags VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_task_run_history (
    run_id STRING PRIMARY KEY,
    task_id STRING,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    status STRING,
    output VARIANT,
    error VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_task_run_logs (
    run_id STRING PRIMARY KEY,
    task_id STRING,
    run_status STRING,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    duration_ms NUMBER,
    output VARIANT,
    error VARIANT,
    logged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_vectorstore_documents (
    document_id STRING PRIMARY KEY,
    org_id STRING,
    instanceref STRING,
    source_uri STRING,
    content VARIANT,
    content_hash STRING,
    content_length NUMBER,
    parsed_at TIMESTAMP_LTZ,
    embedding_generated_at TIMESTAMP_LTZ,
    embedding_model_id STRING
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_vectorstore_index_snapshots (
    snapshot_id STRING PRIMARY KEY,
    index_name STRING,
    snapshot_uri STRING,
    shard_count INT,
    dimension INT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_archive_enhanced (
    archive_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    template_id STRING,
    artifact_url STRING,
    sha256_hash STRING,
    explainability_provenance_id STRING,
    retention_tag STRING,
    jurisdiction STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ) CLUSTER BY (org_id, created_at);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_assembly_metrics (
    metrics_id STRING PRIMARY KEY,
    org_id STRING,
    assembly_id STRING,
    latency_ms FLOAT,
    page_count INT,
    error_count INT,
    metadata VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.Document_Audit (
    audit_id STRING PRIMARY KEY,
    document_id STRING,
    event_type STRING,
    actor STRING,
    event_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.DOCUMENT_EMBEDDINGS (
    embedding_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    section_id STRING,
    vector VARIANT,
    model_id STRING,
    provenance VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ) CLUSTER BY (org_id, document_id);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_embeddings_v2 (
    embedding_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    section_id STRING,
    vector VARIANT,
    model_id STRING,
    provenance VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ) CLUSTER BY (org_id, document_id);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_hash_index (
    doc_hash STRING PRIMARY KEY,
    archive_id STRING,
    org_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_index_annotations (
    annotation_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    index_entry_id STRING,
    annotation_type STRING,
    details VARIANT,
    annotated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_ingest_manifest (
    manifest_id STRING PRIMARY KEY,
    org_id STRING,
    producer_id STRING,
    batch_token STRING,
    status STRING DEFAULT 'PENDING',
    rows_expected NUMBER,
    rows_received NUMBER DEFAULT 0,
    provenance VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.Document_Instance (
    document_id STRING PRIMARY KEY,
    template_id STRING,
    tenant_id STRING,
    status STRING DEFAULT 'QUEUED',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ, rendered_stage_path STRING, rendered_checksum STRING, size_bytes NUMBER, metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.DOCUMENT_SECTIONS (
    section_id STRING PRIMARY KEY,
    ORG_ID STRING,
    document_id STRING,
    section_index INT,
    start_offset INT,
    end_offset INT,
    section_text STRING,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.doc_evidence_access_log (
    access_id STRING PRIMARY KEY,
    manifest_id STRING,
    org_id STRING,
    actor STRING,
    action STRING,
    purpose STRING,
    context VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.doc_hash_index (
    doc_hash STRING PRIMARY KEY,
    document_id STRING,
    org_id STRING,
    algorithm STRING DEFAULT 'SHA-256',
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.doc_version_history (
    version_id STRING PRIMARY KEY,
    org_id STRING NOT NULL,
    document_id STRING NOT NULL,
    version_number STRING,
    snapshot_manifest_id STRING,
    content_path STRING,
    hash STRING,
    change_summary STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embeddings_backfill_audit (
    backfill_job_id STRING PRIMARY KEY,
    org_id STRING,
    initiated_by STRING,
    rows_expected NUMBER,
    rows_processed NUMBER DEFAULT 0,
    status STRING,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embeddings_deleted_audit (
    audit_id STRING PRIMARY KEY,
    embedding_id STRING,
    org_id STRING,
    deletion_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,archived_snapshot_id STRING,reason STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embeddings_retention_policy (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    max_age_days INT,
    keep_provenance BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.EMBEDDINGS_SNAPSHOT (
    SNAPSHOT_ID STRING PRIMARY KEY,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , S3_PREFIX STRING, SHARD_COUNT NUMBER, MANIFEST VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_access_control_list (
    acl_id STRING PRIMARY KEY,
    embedding_id STRING,
    index_id STRING,
    principal STRING,
    principal_type STRING,
    permission STRING,
    granted_by STRING,
    granted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  expires_at TIMESTAMP_LTZ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_deletion_requests (
    deletion_id STRING PRIMARY KEY,
    embedding_id STRING,
    index_id STRING,
    org_id STRING,
    requested_by STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , processed_at TIMESTAMP_LTZ, status STRING DEFAULT 'PENDING', reason STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_deprecation_schedule (
    schedule_id STRING PRIMARY KEY,
    embedding_id STRING,
    index_id STRING,
    deprecate_after TIMESTAMP_LTZ,
    reason STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  status STRING DEFAULT 'SCHEDULED');


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_garbage_collection_candidates (
    candidate_id STRING PRIMARY KEY,
    embedding_id STRING,
    index_id STRING,
    reason STRING,
    identified_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  score FLOAT,  processed BOOLEAN DEFAULT FALSE,  processed_at TIMESTAMP_LTZ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.EMBEDDING_INDEX_APPEND (
    id STRING PRIMARY KEY,
    shard STRING,
    vec VARIANT,
    org_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_ingest_audit (
    audit_id STRING PRIMARY KEY,
    ingest_job_id STRING,
    org_id STRING,
    index_id STRING,
    record_count NUMBER,
    success_count NUMBER,
    failure_count NUMBER,
    started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  finished_at TIMESTAMP_LTZ,  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_ingest_errors (
    error_id STRING PRIMARY KEY,
    source_uri STRING,
    file_name STRING,
    org_id STRING,
    index_id STRING,
    error_message STRING,
    payload VARIANT,
    first_seen_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  last_seen_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),  occurrences INT DEFAULT 1);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_ingest_queue (
    ingest_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    section_id STRING,
    raw_payload VARIANT,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    enqueued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_at TIMESTAMP_LTZ,
    error VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.EMBEDDING_METADATA (
    document_id STRING PRIMARY KEY,
    model_id STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , retention_ttl_days NUMBER, metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_model_usage_stats (
    stat_id STRING PRIMARY KEY,
    model_id STRING,
    model_version STRING,
    org_id STRING,
    tokens_consumed NUMBER,
    calls NUMBER,
    period_start TIMESTAMP_LTZ,
    period_end TIMESTAMP_LTZ,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.EMBEDDING_PROVENANCE (
    prov_id STRING PRIMARY KEY,
    document_id STRING,
    section_id STRING,
    model_id STRING,
    provenance VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_quality_checks (
    check_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    block_id STRING,
    check_type STRING,
    result STRING,
    details VARIANT,
    checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_quality_metrics (
    metric_id STRING PRIMARY KEY,
    org_id STRING,
    metric_name STRING,
    metric_value FLOAT,
    metric_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_quality_thresholds (
    threshold_id STRING PRIMARY KEY,
    org_id STRING,
    check_type STRING,
    min_score FLOAT,
    max_score FLOAT,
    active BOOLEAN DEFAULT TRUE,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_reindex_audit (
    reindex_id STRING PRIMARY KEY,
    index_id STRING,
    initiated_by STRING,
    start_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , end_ts TIMESTAMP_LTZ, processed_embeddings INT, failed_embeddings INT, status STRING DEFAULT 'RUNNING', log VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_reintegration_queue (
    reintegrate_id STRING PRIMARY KEY,
    embedding_id STRING,
    index_id STRING,
    priority INT DEFAULT 5,
    enqueued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , started_at TIMESTAMP_LTZ, finished_at TIMESTAMP_LTZ, status STRING DEFAULT 'PENDING', notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_repair_backlog (
    backlog_id STRING PRIMARY KEY,
    embedding_id STRING,
    index_id STRING,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , severity STRING, attempted_repair_at TIMESTAMP_LTZ, repair_status STRING DEFAULT 'PENDING', notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_repair_tasks (
    task_id STRING PRIMARY KEY,
    repair_request_id STRING,
    embedding_id STRING,
    index_id STRING,
    assigned_to STRING,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    last_attempt_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  result VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_retention_jobs (
    job_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    retention_days INT,
    scheduled_at TIMESTAMP_LTZ,
    started_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    status STRING DEFAULT 'SCHEDULED',
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_schema_versions (
    schema_id STRING PRIMARY KEY,
    model_id STRING,
    model_version STRING,
    vector_dim INT,
    schema_definition VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , created_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_vector_metrics (
    metric_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    avg_norm FLOAT,
    avg_dimension NUMBER,
    vector_count NUMBER,
    dimensionality INT,
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_version_map (
    embedding_id STRING PRIMARY KEY,
    index_id STRING,
    model_id STRING,
    model_version STRING,
    vector_dim INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  retired_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.embedding_version_registry (
    version_id STRING PRIMARY KEY,
    embedding_id STRING,
    index_id STRING,
    model_id STRING,
    model_version STRING,
    vector_dim INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  created_by STRING,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.Evidence_Bundle (
    evidence_id STRING PRIMARY KEY,
    document_id STRING,
    artifact_type STRING,
    stage_path STRING,
    manifest VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.EVIDENCE_BUNDLES (
    BUNDLE_ID STRING PRIMARY KEY,
    INVOICE_HASH STRING,
    BUNDLE_JSON VARIANT,
    BUNDLE_HASH STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.evidence_bundle_items (
    item_id STRING PRIMARY KEY,
    manifest_id STRING NOT NULL,
    org_id STRING NOT NULL,
    document_id STRING,
    item_type STRING,
    item_path STRING,
    item_size_bytes NUMBER,
    checksum STRING,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.evidence_export_queue (
    export_id STRING PRIMARY KEY,
    manifest_id STRING NOT NULL,
    org_id STRING NOT NULL,
    destination_type STRING,
    destination_path STRING,
    status STRING DEFAULT 'QUEUED',
    attempt_count INT DEFAULT 0,
    next_retry_at TIMESTAMP_LTZ,
    requested_by STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.evidence_snapshot_archive (
    SNAPSHOT_ID STRING PRIMARY KEY,
    ORG_ID STRING,
    DOCUMENT_ID STRING,
    EVIDENCE_STAGE_PATH STRING,
    SNAPSHOT_HASH STRING,
    RETENTION_UNTIL TIMESTAMP_LTZ,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.export_embeddings_stage_manifest (
    manifest_id STRING PRIMARY KEY,
    org_id STRING,
    stage_path STRING,
    file_count INT,
    total_vectors INT,
    model_id STRING,
    model_version STRING,
    exported_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.faiss_index_registry (
    registry_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    container_image STRING,
    snapshot_path STRING,
    deployed BOOLEAN DEFAULT FALSE,
    deployed_at TIMESTAMP_LTZ,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.FAISS_INDEX_SNAPSHOTS (
    SNAPSHOT_ID STRING PRIMARY KEY,
    INDEX_NAME STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , LOCATION VARIANT, METADATA VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.FEATURE_ENTITLEMENTS (
    org_id STRING,
    feature_key STRING,
    enabled BOOLEAN DEFAULT TRUE,
    quota_limit FLOAT,
    assignment_meta VARIANT,
    PRIMARY KEY(org_id, feature_key
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_audit_log_exports (
    export_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    request_payload VARIANT,
    status STRING DEFAULT 'PENDING',
    -- PENDING,
    IN_PROGRESS,
    COMPLETED,
    FAILED destination_stage STRING,
    -- e.g. @~/,
    s3://...,
    etc destination_path STRING,
    total_parts INT DEFAULT 0,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    completed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_audit_log_export_parts (
    part_id STRING PRIMARY KEY,
    export_id STRING NOT NULL,
    part_index INT,
    part_path STRING,
    size_bytes NUMBER,
    checksum STRING,
    status STRING DEFAULT 'PENDING',
    -- PENDING,
    UPLOADED,
    FAILED uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_event_replay_jobs (
    job_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    event_time_window VARIANT,
    -- {from,
    to} or complex spec filter_criteria VARIANT,
    status STRING DEFAULT 'QUEUED',
    total_events NUMBER,
    processed_events NUMBER DEFAULT 0,
    result_summary VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_event_replay_job_parts (
    part_id STRING PRIMARY KEY,
    job_id STRING NOT NULL,
    segment_index INT,
    segment_spec VARIANT,
    -- partition/key ranges for replay status STRING DEFAULT 'PENDING',
    -- PENDING,
    RUNNING,
    COMPLETED,
    FAILED processed_count NUMBER DEFAULT 0,
    error_details VARIANT,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_assignments (
    assignment_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    task_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    assigned_to STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    role STRING,
    status STRING DEFAULT 'ACTIVE'
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_attachments (
    attachment_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    related_id STRING,
    -- note_id,
    task_id,
    comment_id,
    or followup_id instanceref STRING,
    feature_key STRING,
    org_id STRING,
    filename STRING,
    content_type STRING,
    stage_path STRING,
    -- pointer to stage (s3/azure/gcs) size_bytes NUMBER,
    checksum STRING,
    uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_comments (
    comment_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    task_id STRING,
    followup_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    comment_text STRING,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_correlation_index (
    correlation_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    correlated_incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    correlation_score FLOAT,
    evidence VARIANT,
    correlated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_escalations (
    escalation_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    level INT,
    escalated_to STRING,
    reason STRING,
    escalated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    acknowledged BOOLEAN DEFAULT FALSE,
    acknowledged_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_external_refs (
    ref_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    external_system STRING,
    external_ref STRING,
    metadata VARIANT,
    linked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_followups (
    followup_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    followup_type STRING,
    -- TASK,
    NOTE,
    ACTION_ITEM,
    NOTIFICATION payload VARIANT,
    status STRING DEFAULT 'OPEN',
    assigned_to STRING,
    due_at TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_followup_audit (
    audit_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    -- CREATED,
    UPDATED,
    CLOSED,
    REOPENED,
    ASSIGNED actor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_followup_templates (
    template_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    name STRING,
    description STRING,
    template_payload VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_metrics_definitions (
    metric_def_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    metric_name STRING,
    metric_description STRING,
    metric_expression STRING,
    -- SQL/JSON path to compute metric units STRING,
    sla_thresholds VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_metrics_snapshot (
    snapshot_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    metrics VARIANT,
    -- JSON time-series or key metrics at detection time captured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_metric_samples (
    sample_id STRING PRIMARY KEY,
    metric_def_id STRING NOT NULL,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    sample_time TIMESTAMP_LTZ,
    sample_value FLOAT,
    sample_payload VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_notes (
    note_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    followup_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    body STRING,
    attachments VARIANT,
    -- array of attachment metadata created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    edited_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_notifications (
    notification_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    channel STRING,
    -- EMAIL,
    SLACK,
    WEBHOOK,
    SMS payload VARIANT,
    delivered BOOLEAN DEFAULT FALSE,
    delivered_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_ownership_history (
    ownership_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    owner STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    released_at TIMESTAMP_LTZ,
    reason VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_playbook_usage (
    usage_id STRING PRIMARY KEY,
    playbook_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    usage_blob VARIANT,
    used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_postmortems (
    postmortem_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    summary STRING,
    timeline VARIANT,
    -- structured timeline action_items VARIANT,
    -- array of action items author STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    published_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_postmortem_notifications (
    notification_id STRING PRIMARY KEY,
    postmortem_id STRING,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    channel STRING,
    payload VARIANT,
    sent_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_postmortem_templates (
    template_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    template VARIANT,
    version INT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_related_services (
    relation_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    service_name STRING,
    service_role STRING,
    metadata VARIANT,
    linked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_resolution_codes (
    code_id STRING PRIMARY KEY,
    code STRING UNIQUE,
    description STRING,
    category STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_retention_policies (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    retention_days NUMBER,
    apply_to VARIANT,
    -- patterns or scopes hold_exceptions VARIANT,
    -- e.g.,
    legal holds created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_root_cause (
    root_cause_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    category STRING,
    -- e.g.,
    CONFIG,
    DEPENDENCY,
    BUG,
    CAPACITY summary STRING,
    evidence VARIANT,
    identified_by STRING,
    identified_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_root_cause_tags (
    tag_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    tag STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_root_cause_templates (
    template_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    description STRING,
    template_payload VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_severity_thresholds (
    threshold_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    severity_level STRING,
    condition_expr STRING,
    action_spec VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_sla_breaches (
    breach_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    sla_name STRING,
    expected_by TIMESTAMP_LTZ,
    breached_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    breach_duration_seconds NUMBER,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_status_history (
    history_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    previous_status STRING,
    new_status STRING,
    changed_by STRING,
    change_reason STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_tasks (
    task_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    followup_id STRING,
    instanceref STRING,
    feature_key STRING,
    org_id STRING,
    title STRING,
    description STRING,
    assigned_to STRING,
    priority STRING DEFAULT 'MEDIUM',
    status STRING DEFAULT 'OPEN',
    due_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    completed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_incident_timelines (
    timeline_id STRING PRIMARY KEY,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    events VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_maintenance_feedback (
    feedback_id STRING PRIMARY KEY,
    window_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    feedback VARIANT,
    submitted_by STRING,
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_operational_runbooks (
    runbook_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    name STRING,
    description STRING,
    runbook_body VARIANT,
    -- structured steps,
    checks,
    playbooks version INT DEFAULT 1,
    published BOOLEAN DEFAULT FALSE,
    published_at TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_postmortem_action_items (
    action_id STRING PRIMARY KEY,
    postmortem_id STRING NOT NULL,
    incident_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    description STRING,
    priority STRING DEFAULT 'MEDIUM',
    -- LOW/MEDIUM/HIGH status STRING DEFAULT 'OPEN',
    -- OPEN/IN_PROGRESS/DONE owner STRING,
    due_date TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  closed_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_postmortem_action_priorities (
    priority_id STRING PRIMARY KEY,
    postmortem_id STRING NOT NULL,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action_id STRING,
    priority_level STRING,
    -- P0,
    P1,
    P2... rationale STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_postmortem_metrics (
    metric_id STRING PRIMARY KEY,
    review_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    metric_key STRING,
    metric_value NUMBER,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_postmortem_metrics_rollups (
    rollup_id STRING PRIMARY KEY,
    metric_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    agg_value NUMBER,
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_postmortem_participants (
    participant_id STRING PRIMARY KEY,
    postmortem_id STRING NOT NULL,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    user_id STRING,
    role STRING,
    contributed_notes VARIANT,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_root_cause_analysis_notes (
    note_id STRING PRIMARY KEY,
    incident_id STRING,
    postmortem_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    author STRING,
    note_body STRING,
    attachments VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_runbook_change_audit (
    audit_id STRING PRIMARY KEY,
    runbook_id STRING,
    request_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    action STRING,
    -- CREATE,
    UPDATE,
    APPROVE,
    REJECT,
    ROLLBACK actor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_runbook_change_decisions (
    decision_id STRING PRIMARY KEY,
    request_id STRING NOT NULL,
    runbook_id STRING,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    decision STRING,
    -- APPROVE,
    REJECT decided_by STRING,
    decision_notes STRING,
    decided_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_runbook_change_requests (
    request_id STRING PRIMARY KEY,
    runbook_id STRING NOT NULL,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    requested_by STRING,
    request_payload VARIANT,
    -- proposed changes status STRING DEFAULT 'PENDING',
    -- PENDING,
    APPROVED,
    REJECTED decision_by STRING,
    decision_reason STRING,
    decision_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_service_dependency_maps (
    map_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    dependencies VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_service_level_reports (
    report_id STRING PRIMARY KEY,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    report_name STRING,
    cadence STRING,
    -- e.g. DAILY,
    WEEKLY,
    MONTHLY report_definition VARIANT,
    last_generated_at TIMESTAMP_LTZ,
    generated_payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_service_level_report_subscribers (
    subscriber_id STRING PRIMARY KEY,
    report_id STRING NOT NULL,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    subscriber_type STRING,
    -- EMAIL,
    WEBHOOK,
    SLACK subscriber_config VARIANT,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    unsubscribed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_synthetic_test_alerting (
    alert_id STRING PRIMARY KEY,
    run_id STRING NOT NULL,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    alert_type STRING,
    -- e.g. THRESHOLD,
    ABSENCE,
    ANOMALY severity STRING,
    payload VARIANT,
    notified BOOLEAN DEFAULT FALSE,
    notified_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.feature_instance_synthetic_test_runs (
    run_id STRING PRIMARY KEY,
    instance_ref STRING NOT NULL,
    feature_key STRING NOT NULL,
    org_id STRING,
    test_name STRING,
    test_config VARIANT,
    start_time TIMESTAMP_LTZ,
    end_time TIMESTAMP_LTZ,
    status STRING,
    -- e.g. PENDING,
    RUNNING,
    FAILED,
    SUCCEEDED result_summary VARIANT,
    metrics VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.FEATURE_MASTER (
    feature_key STRING PRIMARY KEY,
    name STRING,
    description STRING,
    billing_metric STRING,
    default_price_per_unit NUMBER(18,6
) , created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.FORECASTING_MODELS (
    model_name STRING PRIMARY KEY,
    model_object BLOB,
    feature_key STRING,
    train_timestamp TIMESTAMP_LTZ,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.IDEMPOTENCY_GUARD (
    id STRING PRIMARY KEY,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , meta VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_escalation_log (
    escalation_log_id STRING PRIMARY KEY,
    escalation_id STRING NOT NULL,
    incident_id STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_escalation_queue (
    escalation_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    instance_ref STRING,
    feature_key STRING,
    org_id STRING,
    severity STRING,
    assigned_team STRING,
    status STRING DEFAULT 'PENDING',
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  processed_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_access_audit_trail (
    audit_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    principal STRING,
    -- user or roleaction STRING,
    -- READ/WRITE/DELETE/GRANTdetails VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_access_tokens (
    token_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    token_ref STRING,
    scopes ARRAY,
    issued_to STRING,
    expires_at TIMESTAMP_LTZ,
    issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_activity_feed (
    activity_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    actor STRING,
    activity_type STRING,
    -- NOTE_ADDED,
    STATUS_CHANGE,
    ASSIGNMENT,
    COMMENTpayload VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_activity_log (
    activity_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    actor STRING,
    -- user or system action STRING,
    -- CREATED/UPDATED/COMMENT/ATTACHMENT/STATE_CHANGE etc details VARIANT,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_ai_assist_requests (
    request_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    user_id STRING,
    prompt VARIANT,
    model_id STRING,
    request_status STRING DEFAULT 'QUEUED',
    -- QUEUED/RUNNING/COMPLETED/FAILEDrequested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_ai_assist_responses (
    response_id STRING PRIMARY KEY,
    request_id STRING NOT NULL,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    model_id STRING,
    response_payload VARIANT,
    confidence NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,consumed BOOLEAN DEFAULT FALSE);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_alert_mappings (
    mapping_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    alert_id STRING,
    alert_source STRING,
    linked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_attachments (
    attachment_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    filename STRING,
    content_type STRING,
    size_bytes NUMBER,
    storage_location VARIANT,
    -- stage/path or external ref uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  checksum STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_attachment_indexes (
    attachment_index_id STRING PRIMARY KEY,
    attachment_id STRING,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    indexed_text STRING,
    ocr_metadata VARIANT,
    indexed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_attachment_metadata (
    attachment_meta_id STRING PRIMARY KEY,
    attachment_id STRING,
    followup_id STRING,
    org_id STRING,
    ocr_text STRING,
    extracted_entities VARIANT,
    thumbnails VARIANT,
    indexed BOOLEAN DEFAULT FALSE,
    indexed_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_attachment_purge_jobs (
    purge_job_id STRING PRIMARY KEY,
    policy_id STRING,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    status STRING DEFAULT 'QUEUED',
    -- QUEUED/RUNNING/COMPLETED/FAILEDcandidate_count NUMBER DEFAULT 0,
    purged_count NUMBER DEFAULT 0,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    error_details VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_attachment_retention_policies (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    followup_scope STRING,
    -- per-followup / per-incident / org-wideretention_days INT,
    auto_purge BOOLEAN DEFAULT FALSE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_attachment_store (
    attachment_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    filename STRING,
    content_type STRING,
    size_bytes NUMBER,
    stage_path STRING,
    -- path to staged file uploaded_by STRING,
    uploaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_backfill_queue (
    backfill_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    reason STRING,
    status STRING DEFAULT 'QUEUED',
    -- QUEUED/RUNNING/COMPLETED/FAILED attempts INT DEFAULT 0,
    last_attempt_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_bulk_actions (
    bulk_action_id STRING PRIMARY KEY,
    org_id STRING,
    action_type STRING,
    -- TAG/ASSIGN/UPDATE/DELETEcriteria VARIANT,
    -- selection criteriaaction_payload VARIANT,
    initiated_by STRING,
    status STRING DEFAULT 'QUEUED',
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    result_summary VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_checklist_items (
    checklist_item_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    description STRING,
    completed BOOLEAN DEFAULT FALSE,
    completed_by STRING,
    completed_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_comments (
    comment_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    author STRING,
    content STRING,
    content_format STRING DEFAULT 'TEXT',
    edited BOOLEAN DEFAULT FALSE,
    edited_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_confidence_scores (
    score_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    model_id STRING,
    score NUMBER,
    -- 0-1 meta VARIANT,
    scored_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_contacts (
    contact_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    email STRING,
    phone STRING,
    role STRING,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_custom_fields (
    custom_field_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    field_type STRING,
    -- TEXT/NUMBER/DATE/SELECT/JSONconfig VARIANT,
    -- validation/options/defaultscreated_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_dashboard_tiles (
    tile_id STRING PRIMARY KEY,
    org_id STRING,
    followup_scope STRING,
    -- e.g.,
    ORG,
    TEAM,
    USERtile_definition VARIANT,
    placement VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_email_threads (
    email_thread_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    subject STRING,
    recipients VARIANT,
    -- ARRAY or VARIANT with recipient metadata last_message_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_escalation_logs (
    escalation_id STRING PRIMARY KEY,
    policy_id STRING,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    triggered_by STRING,
    triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,target VARIANT, -- target role/user detailsoutcome STRING, -- NOTIFIED/ACKED/ESCALATED/FAILEDdetails VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_escalation_policies (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    description STRING,
    conditions VARIANT,
    -- criteria that trigger escalationescalation_path ARRAY,
    -- ordered list of targets/rolesenabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_export_jobs (
    job_id STRING PRIMARY KEY,
    export_id STRING,
    org_id STRING,
    started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  finished_at TIMESTAMP_LTZ,  status STRING DEFAULT 'QUEUED',  worker_details VARIANT,  result_location VARIANT,  error VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_external_tickets (
    external_ticket_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    provider STRING,
    -- JIRA,
    ZENDESK,
    GITHUB,
    etc. provider_ticket_ref STRING,
    url STRING,
    linked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_field_definitions (
    field_def_id STRING PRIMARY KEY,
    org_id STRING,
    followup_scope STRING,
    -- followup/incident/templatefield_name STRING,
    display_name STRING,
    field_type STRING,
    required BOOLEAN DEFAULT FALSE,
    default_value VARIANT,
    validation VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_field_values (
    field_value_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    field_def_id STRING,
    value VARIANT,
    set_by STRING,
    set_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_import_jobs (
    import_job_id STRING PRIMARY KEY,
    org_id STRING,
    source VARIANT,
    -- stage/external details mapping VARIANT,
    initiated_by STRING,
    initiated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  status STRING DEFAULT 'QUEUED',  processed_records NUMBER,  error VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_import_mapping (
    mapping_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    source_system STRING,
    source_payload VARIANT,
    mapped_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,mapping_status STRING DEFAULT 'MAPPED' -- MAPPED/ERROR);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_kpi_definitions (
    kpi_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    description STRING,
    calculation VARIANT,
    -- definition or SQL snippettarget_value NUMBER,
    window_minutes INT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_kpi_values (
    kpi_value_id STRING PRIMARY KEY,
    kpi_id STRING NOT NULL,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    value NUMBER,
    period_start TIMESTAMP_LTZ,
    period_end TIMESTAMP_LTZ,
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_kv_meta (
    meta_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    key_name STRING,
    value VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_labels (
    label_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    color STRING,
    description STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_label_assignments (
    assignment_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    label_id STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_label_rules (
    rule_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    condition VARIANT,
    -- rule expression/criteria label_id STRING,
    enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_metrics_aggregates (
    aggregate_id STRING PRIMARY KEY,
    org_id STRING,
    metric_name STRING,
    time_window_start TIMESTAMP_LTZ,
    time_window_end TIMESTAMP_LTZ,
    dimensions VARIANT,
    metric_value NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_notes (
    note_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    author STRING,
    note VARIANT,
    visibility STRING DEFAULT 'INTERNAL',
    -- INTERNAL/EXTERNAL created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_notifications (
    notification_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    channel STRING,
    -- EMAIL,
    SLACK,
    SMS,
    WEBHOOK recipient VARIANT,
    -- ARRAY or VARIANT with recipient metadata payload VARIANT,
    status STRING DEFAULT 'QUEUED',
    -- QUEUED/SENT/FAILED attempts INT DEFAULT 0,
    last_attempt_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_notification_templates (
    notification_template_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    channel STRING,
    -- EMAIL/SLACK/WEBHOOK/SMS subject STRING,
    body VARIANT,
    -- structured (markdown/templating
) variables ARRAY,  enabled BOOLEAN DEFAULT TRUE,  created_by STRING,  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),  updated_by STRING,  updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_ownership_history (
    ownership_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    previous_owner STRING,
    new_owner STRING,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_permissions (
    permission_id STRING PRIMARY KEY,
    org_id STRING,
    principal STRING,
    -- user or role resource_type STRING,
    -- FOLLOWUP/ATTACHMENT/TEMPLATE resource_id STRING,
    actions ARRAY,
    -- allowed actions e.g.,
    ['read',
    'write',
    'delete'] granted_by STRING,
    granted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_priority_overrides (
    override_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    previous_priority STRING,
    new_priority STRING,
    reason STRING,
    overridden_by STRING,
    overridden_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_rate_limit_counters (
    counter_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    subject STRING,
    -- user_id or api_keybucket_start TIMESTAMP_LTZ,
    bucket_end TIMESTAMP_LTZ,
    count INT DEFAULT 0,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_recent_views (
    view_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    user_id STRING,
    viewed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_reminders (
    reminder_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    remind_at TIMESTAMP_LTZ,
    reminder_payload VARIANT,
    triggered BOOLEAN DEFAULT FALSE,
    triggered_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_reporting_exports (
    export_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    parameters VARIANT,
    format STRING,
    -- CSV/JSON/XLSX destination VARIANT,
    -- stage/external location initiated_by STRING,
    initiated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  completed_at TIMESTAMP_LTZ,  status STRING, -- QUEUED/RUNNING/COMPLETED/FAILED  result VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_resolution_notes (
    resolution_note_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    resolved_by STRING,
    resolution_summary STRING,
    resolution_payload VARIANT,
    resolved_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_resolution_workflow (
    workflow_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    current_step STRING,
    steps VARIANT,
    -- ordered list of steps and metadatacreated_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_resource_links (
    link_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    title STRING,
    url STRING,
    link_type STRING,
    -- DOC/KB/PLAYBOOK/REPOadded_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_retention_audit (
    audit_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    policy_id STRING,
    action STRING,
    -- RETAINED/PURGEDacted_by STRING,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_search_index (
    index_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    indexed_text STRING,
    tokens VARIANT,
    ranking_fields VARIANT,
    indexed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_search_suggestions (
    suggestion_id STRING PRIMARY KEY,
    org_id STRING,
    input_fragment STRING,
    suggested_terms ARRAY,
    usage_count INT DEFAULT 0,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_slack_notification_preferences (
    pref_id STRING PRIMARY KEY,
    org_id STRING,
    user_id STRING,
    followup_type STRING,
    channel STRING,
    enabled BOOLEAN DEFAULT TRUE,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_slack_threads (
    thread_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    channel STRING,
    slack_ts STRING,
    last_posted_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_sla_breaches (
    breach_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    sla_id STRING,
    breach_time TIMESTAMP_LTZ,
    severity STRING,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_sla_breach_notifications (
    notification_id STRING PRIMARY KEY,
    breach_id STRING NOT NULL,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    recipients VARIANT,
    -- list of recipients or rolessent_at TIMESTAMP_LTZ,
    channel STRING,
    -- EMAIL/SLACK/WEBHOOKstatus STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_slo_checks (
    slo_check_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    slo_metric STRING,
    threshold NUMBER,
    window_minutes INT,
    last_evaluated_at TIMESTAMP_LTZ,
    state STRING,
    -- OK/ALERTING/NO_DATA created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_snooze_log (
    log_id STRING PRIMARY KEY,
    snooze_id STRING NOT NULL,
    followup_id STRING,
    incident_id STRING,
    action STRING,
    -- SNOOZED,
    UNSNOOZED,
    EXTENDEDactor STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_snooze_windows (
    snooze_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    snoozed_by STRING,
    snooze_from TIMESTAMP_LTZ,
    snooze_to TIMESTAMP_LTZ,
    reason STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_staging (
    staging_id STRING PRIMARY KEY,
    org_id STRING,
    payload VARIANT,
    source STRING,
    received_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  processed BOOLEAN DEFAULT FALSE,  processed_at TIMESTAMP_LTZ,  processing_notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_state_machine_transitions (
    transition_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    from_state STRING,
    to_state STRING,
    triggered_by STRING,
    trigger_reason STRING,
    triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_summaries (
    summary_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    summary_text STRING,
    summary_format STRING,
    -- TEXT/MARKDOWN/HTML generated_by STRING,
    generated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_sync_state (
    sync_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    external_system STRING,
    -- e.g.,
    JIRA,
    ZENDESKexternal_ref STRING,
    last_synced_at TIMESTAMP_LTZ,
    last_sync_status STRING,
    -- OK/FAILED/PENDINGsync_metadata VARIANT,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_tag_index (
    tag_index_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    tag STRING,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_tag_rules (
    rule_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    condition VARIANT,
    -- rule condition to auto-apply tagtags ARRAY,
    enabled BOOLEAN DEFAULT TRUE,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_tag_suggestions (
    suggestion_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    suggested_by STRING,
    -- SYSTEM or USERsuggested_tags ARRAY,
    confidence NUMBER,
    -- 0-1metadata VARIANT,
    suggested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_tasks (
    task_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    title STRING,
    description STRING,
    task_status STRING DEFAULT 'OPEN',
    -- OPEN/IN_PROGRESS/DONE priority STRING DEFAULT 'MEDIUM',
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  started_at TIMESTAMP_LTZ,  completed_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_team_assignments (
    assignment_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    team_id STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,active BOOLEAN DEFAULT TRUE);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_telemetry (
    telemetry_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    metric_key STRING,
    metric_value NUMBER,
    payload VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_templates (
    template_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    description STRING,
    version STRING,
    fields VARIANT,
    -- schema of custom fields and defaults steps VARIANT,
    -- ordered workflow steps created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_by STRING,  updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_templates_history (
    history_id STRING PRIMARY KEY,
    template_id STRING,
    org_id STRING,
    version STRING,
    snapshot VARIANT,
    -- full template snapshot changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  change_reason STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_template_usage_stats (
    usage_id STRING PRIMARY KEY,
    template_id STRING,
    org_id STRING,
    followup_count INT DEFAULT 0,
    last_used_at TIMESTAMP_LTZ,
    aggregated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_third_party_integrations (
    integration_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    provider STRING,
    config VARIANT,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_user_mentions (
    mention_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    mentioned_by STRING,
    mentioned_user STRING,
    context_snippet STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_user_subscriptions (
    subscription_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    user_id STRING,
    notify_on STRING,
    -- e.g.,
    STATUS_CHANGE,
    NOTE_ADDED created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_view_counts (
    view_count_id STRING PRIMARY KEY,
    followup_id STRING,
    incident_id STRING,
    org_id STRING,
    principal STRING,
    viewed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_webhooks (
    webhook_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    url STRING,
    method STRING DEFAULT 'POST',
    headers VARIANT,
    secret_ref STRING,
    event_types ARRAY,
    -- list of event names subscribed to enabled BOOLEAN DEFAULT TRUE,
    last_invoked_at TIMESTAMP_LTZ,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_followup_webhook_deliveries (
    delivery_id STRING PRIMARY KEY,
    followup_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    webhook_url STRING,
    payload VARIANT,
    response_code INT,
    response_body VARIANT,
    attempts INT DEFAULT 0,
    last_attempt_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_recovery_playbooks (
    playbook_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    description STRING,
    steps VARIANT,
    owner STRING,
    version INT DEFAULT 1,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_recovery_runqueue (
    run_id STRING PRIMARY KEY,
    playbook_id STRING NOT NULL,
    incident_id STRING,
    org_id STRING,
    initiated_by STRING,
    status STRING DEFAULT 'QUEUED',
    -- QUEUED/RUNNING/COMPLETED/FAILED started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_reopen_audit (
    audit_id STRING PRIMARY KEY,
    reopen_request_id STRING,
    incident_id STRING,
    actor STRING,
    action STRING,
    details VARIANT,
    acted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_reopen_decisions (
    decision_id STRING PRIMARY KEY,
    reopen_request_id STRING NOT NULL,
    incident_id STRING,
    approved BOOLEAN,
    decided_by STRING,
    decided_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_reopen_requests (
    reopen_request_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    requested_by STRING,
    reason STRING,
    status STRING DEFAULT 'PENDING',
    -- PENDING/APPROVED/DENIED requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  decided_at TIMESTAMP_LTZ,  decided_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.incident_rootcause_tags (
    tag_id STRING PRIMARY KEY,
    incident_id STRING NOT NULL,
    tag STRING,
    confidence NUMBER,
    -- 0-1 score if automated tagged_by STRING,
    tagged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_background_task_registry (
    task_id STRING PRIMARY KEY,
    index_id STRING,
    task_type STRING,
    schedule_cron STRING,
    last_run TIMESTAMP_LTZ,
    next_run TIMESTAMP_LTZ,
    enabled BOOLEAN DEFAULT TRUE,
    owner STRING,
    config VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_compaction_history (
    compaction_id STRING PRIMARY KEY,
    index_id STRING,
    shard_id STRING,
    initiated_by STRING,
    start_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  end_ts TIMESTAMP_LTZ,  compacted_segments INT,  reclaimed_bytes NUMBER,  status STRING,  notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_compaction_logs (
    compaction_id STRING PRIMARY KEY,
    index_id STRING,
    initiated_by STRING,
    started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  completed_at TIMESTAMP_LTZ,  reclaimed_bytes NUMBER,  status STRING DEFAULT 'RUNNING',  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_garbage_collection_log (
    gc_id STRING PRIMARY KEY,
    index_id STRING,
    initiated_by STRING,
    reason STRING,
    candidate_count INT,
    reclaimed_bytes NUMBER,
    started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , completed_at TIMESTAMP_LTZ, status STRING DEFAULT 'QUEUED', details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_manifest_change_history (
    change_id STRING PRIMARY KEY,
    index_id STRING,
    manifest_before VARIANT,
    manifest_after VARIANT,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , reason STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_policy_violation_log (
    violation_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    policy_name STRING,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  detected_by STRING,  severity STRING,  details VARIANT,  resolved BOOLEAN DEFAULT FALSE,  resolved_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_quarantine_registry (
    quarantine_id STRING PRIMARY KEY,
    index_id STRING,
    reason STRING,
    flagged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , flagged_by STRING, resolving_action STRING, resolved_at TIMESTAMP_LTZ, status STRING DEFAULT 'OPEN', metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_repair_requests (
    request_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  priority STRING DEFAULT 'NORMAL',  requested_by STRING,  status STRING DEFAULT 'PENDING',  started_at TIMESTAMP_LTZ,  completed_at TIMESTAMP_LTZ,  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_replication_state (
    replication_id STRING PRIMARY KEY,
    index_id STRING,
    source_shard STRING,
    target_shard STRING,
    progress FLOAT,
    last_heartbeat TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING DEFAULT 'IN_PROGRESS', details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_retention_audit (
    audit_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    retention_policy_id STRING,
    evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  matched_objects INT,  total_objects INT,  action_taken STRING,  operator STRING,  notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_retirement_archive (
    archive_id STRING PRIMARY KEY,
    retirement_id STRING,
    index_id STRING,
    snapshot_path STRING,
    archived_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    archived_by STRING,
    notes VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_retirement_audit (
    audit_id STRING PRIMARY KEY,
    retirement_id STRING,
    action STRING,
    actor STRING,
    action_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_retirement_queue (
    retirement_id STRING PRIMARY KEY,
    index_snapshot_id STRING,
    org_id STRING,
    reason STRING,
    queued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,    processed BOOLEAN DEFAULT FALSE);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_shard_placement (
    placement_id STRING PRIMARY KEY,
    index_id STRING,
    shard_id STRING,
    node_id STRING,
    path STRING,
    size_bytes NUMBER,
    placed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  state STRING DEFAULT 'PLACED');


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_snapshot_checksums (
    checksum_id STRING PRIMARY KEY,
    snapshot_id STRING,
    index_id STRING,
    algorithm STRING,
    checksum STRING,
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , computed_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_snapshot_health (
    health_id STRING PRIMARY KEY,
    snapshot_id STRING,
    index_id STRING,
    vector_count NUMBER,
    shard_count INT,
    integrity_status STRING,
    last_verified_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metrics VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_snapshot_inventory (
    inventory_id STRING PRIMARY KEY,
    snapshot_id STRING,
    index_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  object_count INT,  total_bytes NUMBER,  storage_uri STRING,  checksum STRING,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_snapshot_manifest (
    snapshot_id STRING PRIMARY KEY,
    storage_prefix STRING,
    shard_count NUMBER,
    manifest VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_snapshot_quota (
    quota_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    max_snapshots INT,
    used_snapshots INT DEFAULT 0,
    quota_period_start TIMESTAMP_LTZ,
    quota_period_end TIMESTAMP_LTZ,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_snapshot_retention_policies (
    policy_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    retain_days INT,
    archive_destination STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_snapshot_tags (
    tag_id STRING PRIMARY KEY,
    snapshot_id STRING,
    index_id STRING,
    key STRING,
    value STRING,
    added_by STRING,
    added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_snapshot_validation_runs (
    validation_id STRING PRIMARY KEY,
    snapshot_id STRING,
    index_id STRING,
    initiated_by STRING,
    started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  completed_at TIMESTAMP_LTZ,  record_count INT,  checksum_match BOOLEAN,  status STRING,  report VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.index_storage_cost_estimates (
    estimate_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    period_start TIMESTAMP_LTZ,
    period_end TIMESTAMP_LTZ,
    estimated_bytes NUMBER,
    estimated_cost NUMBER,
    currency STRING,
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.INFERENCE_PROVENANCE (
    PROV_ID STRING PRIMARY KEY,
    REQUEST_ID STRING,
    MODEL_ID STRING,
    INPUT VARIANT,
    OUTPUT VARIANT,
    TOKENS NUMBER,
    CONFIDENCE NUMBER,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ingest_backfill_jobs (
    backfill_job_id STRING PRIMARY KEY,
    org_id STRING,
    initiated_by STRING,
    rows_expected NUMBER,
    rows_processed NUMBER DEFAULT 0,
    status STRING DEFAULT 'QUEUED',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ingest_checkpoint (
    checkpoint_id STRING PRIMARY KEY,
    pipeline_name STRING,
    last_processed_cursor VARIANT,
    last_updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ingest_errors (
    error_id STRING PRIMARY KEY,
    pipeline_name STRING,
    record_key STRING,
    error_type STRING,
    error_details VARIANT,
    first_seen TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  last_seen TIMESTAMP_LTZ,  occurrences NUMBER DEFAULT 1);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ingest_error_summary (
    summary_id STRING PRIMARY KEY,
    pipeline_name STRING,
    error_type STRING,
    occurrences NUMBER,
    first_seen TIMESTAMP_LTZ,
    last_seen TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ingest_monitoring_checks (
    check_id STRING PRIMARY KEY,
    pipeline_name STRING,
    last_success TIMESTAMP_LTZ,
    last_error_ts TIMESTAMP_LTZ,
    status STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.INVOICE_ARCHIVE (
    invoice_id STRING PRIMARY KEY,
    account_id STRING,
    invoice_payload VARIANT,
    subtotal NUMBER,
    markup NUMBER,
    tax NUMBER,
    total NUMBER,
    currency STRING,
    archived_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.invoice_dryrun_cache (
    dryrun_id STRING PRIMARY KEY,
    org_id STRING,
    period_start TIMESTAMP_LTZ,
    period_end TIMESTAMP_LTZ,
    invoice_payload VARIANT,
    invoice_hash STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.JOB_AUDIT_LOG (
    LOG_ID STRING PRIMARY KEY,
    JOB_NAME STRING,
    START_TIME TIMESTAMP_LTZ,
    STATUS STRING,
    DETAILS VARIANT,
    RUN_BY STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.key_rotation_history (
    history_id STRING PRIMARY KEY,
    key_id STRING,
    rotation_id STRING,
    rotated_at TIMESTAMP_LTZ,
    rotated_by STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.llm_prompt_audit (
    prompt_id STRING PRIMARY KEY,
    org_id STRING,
    model_id STRING,
    prompt_hash STRING,
    prompt_length INT,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.llm_response_audit (
    response_id STRING PRIMARY KEY,
    prompt_id STRING,
    response_hash STRING,
    model_confidence VARIANT,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.MODEL_DRIFT_METRICS (
    drift_id STRING,
    feature_key STRING,
    model_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    drift_score NUMBER,
    check_timestamp TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.model_inference_costs (
    cost_id STRING PRIMARY KEY,
    model_id STRING,
    org_id STRING,
    request_id STRING,
    provider STRING,
    cost_amount FLOAT,
    cost_currency STRING,
    tokens_consumed NUMBER,
    incurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    metadata VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.model_metric_agg (
    agg_id STRING PRIMARY KEY,
    model_id STRING,
    org_id STRING,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    avg_latency_ms FLOAT,
    avg_cost FLOAT,
    requests_count NUMBER,
    metrics VARIANT,
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.model_performance_history (
    perf_id STRING PRIMARY KEY,
    model_id STRING,
    org_id STRING,
    evaluation_date TIMESTAMP_LTZ,
    metric_name STRING,
    metric_value FLOAT,
    dataset_name STRING,
    details VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.MODEL_REGISTRY (
    model_id VARCHAR PRIMARY KEY,
    model_name VARCHAR,
    version VARCHAR,
    stage_path VARCHAR,
    algorithm VARCHAR,
    metrics VARIANT,
    trained_at TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.model_registry_versions (
    record_id STRING PRIMARY KEY,
    model_id STRING,
    provider STRING,
    model_name STRING,
    model_version STRING,
    action STRING,
    -- REGISTER/DEPRECATE changed_by STRING,
    change_reason STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.MODEL_TELEMETRY (
    TELEMETRY_ID STRING PRIMARY KEY,
    ACCOUNT_ID STRING,
    MODEL_ID STRING,
    LATENCY_MS NUMBER,
    TOKENS_IN NUMBER,
    TOKENS_OUT NUMBER,
    COST_ESTIMATE NUMBER,
    METADATA VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ops_maintenance_log (
    maintenance_id STRING PRIMARY KEY,
    operator STRING,
    action STRING,
    notes STRING,
    started_at TIMESTAMPLTZ,
    completed_at TIMESTAMPLTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.pdf_artifact_metadata (
    artifact_id STRING PRIMARY KEY,
    org_id STRING,
    archive_id STRING,
    ocr_text VARIANT,
    page_count INT,
    language STRING,
    extracted_entities VARIANT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.postmortem_action_assignments (
    assignment_id STRING PRIMARY KEY,
    action_id STRING NOT NULL,
    assigned_to STRING,
    assigned_by STRING,
    assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  COMMENT STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.postmortem_action_status (
    status_id STRING PRIMARY KEY,
    action_id STRING NOT NULL,
    old_status STRING,
    new_status STRING,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  COMMENT STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.preview_cache_cleanup (
    cleanup_run_id STRING PRIMARY KEY,
    org_id STRING,
    rows_examined NUMBER,
    rows_deleted NUMBER,
    run_status STRING,
    run_started_at TIMESTAMP_LTZ,
    run_finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.preview_cache_index (
    cache_key STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    preview_path STRING,
    expires_at TIMESTAMP_LTZ,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.preview_cache_invalidation (
    invalidation_id STRING PRIMARY KEY,
    org_id STRING,
    cache_key STRING,
    reason STRING,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.PROCESSING_JOB_AUDIT (
    log_id STRING PRIMARY KEY,
    job_name STRING,
    start_time TIMESTAMP_LTZ,
    end_time TIMESTAMP_LTZ,
    status STRING,
    details VARIANT,
    run_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.producer_backlog (
    backlog_id STRING PRIMARY KEY,
    org_id STRING,
    pending_files NUMBER,
    last_reported_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.producer_config (
    producer_id STRING PRIMARY KEY,
    org_id STRING,
    embedding_model_id STRING,
    batch_size NUMBER,
    last_updated TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.PROMPT_LOG (
    PROMPT_ID STRING PRIMARY KEY,
    ORG_ID STRING,
    USER_ID STRING,
    MODEL_ID STRING,
    PROMPT_TEXT STRING,
    RESPONSE_TEXT STRING,
    TOKENS_USED NUMBER,
    COST_ESTIMATE NUMBER,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.prompt_template_hashmap (
    template_id STRING PRIMARY KEY,
    prompt_hash STRING,
    model_binding STRING,
    safe_mode BOOLEAN,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.PROVENANCE (
    PROV_ID STRING PRIMARY KEY,
    ASSEMBLY_RUN_ID STRING,
    DOCUMENT_ID STRING,
    MODEL_ID STRING,
    PROMPT_HASH STRING,
    EXPLAINABILITY VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.purge_log (
    purge_id STRING PRIMARY KEY,
    org_id STRING,
    table_name STRING,
    rows_deleted NUMBER,
    purge_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  initiated_by STRING,  justification STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.query_cost_hist (
    cost_record_id STRING PRIMARY KEY,
    org_id STRING,
    query_hash STRING,
    cost_estimate FLOAT,
    actual_cost FLOAT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.query_provenance_link (
    link_id STRING PRIMARY KEY,
    query_id STRING,
    provenance_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_CARD (
    RATE_ID STRING PRIMARY KEY,
    FEATURE_KEY STRING,
    BASE_UNIT_PRICE NUMBER,
    UNIT STRING,
    MIN_FEE NUMBER DEFAULT 0,
    CAP_FEE NUMBER,
    EFFECTIVE_FROM TIMESTAMP_LTZ,
    EFFECTIVE_TO TIMESTAMP_LTZ,
    UPDATED_BY STRING,
    UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_CARD_TIERS (
    tier_id STRING PRIMARY KEY,
    feature_key STRING,
    min_units NUMBER,
    max_units NUMBER,
    unit_price NUMBER,
    effective_from TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES (
    RULE_ID STRING PRIMARY KEY,
    FEATURE_KEY STRING NOT NULL,
    RULE_TYPE STRING NOT NULL,
    CONFIG VARIANT NOT NULL,
    PRIORITY NUMBER DEFAULT 100,
    EFFECTIVE_FROM TIMESTAMP_LTZ,
    EFFECTIVE_TO TIMESTAMP_LTZ,
    ACTIVE BOOLEAN DEFAULT TRUE,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_ALERTS (
    alert_id STRING PRIMARY KEY,
    rule_id STRING,
    alert_type STRING,
    message STRING,
    severity STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , acknowledged BOOLEAN DEFAULT FALSE, acknowledged_by STRING, acknowledged_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_APPLY_QUEUE (
    queue_id STRING PRIMARY KEY,
    staging_id STRING,
    rule_id STRING,
    scheduled_for TIMESTAMP_LTZ,
    attempted BOOLEAN DEFAULT FALSE,
    attempt_count INT DEFAULT 0,
    last_attempt TIMESTAMP_LTZ,
    result VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_APPROVAL_AUDIT (
    audit_id STRING PRIMARY KEY,
    staging_id STRING,
    action STRING,
    actor STRING,
    action_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_AUDIT_LOG (
    audit_id STRING PRIMARY KEY,
    rule_id STRING,
    action STRING,
    actor STRING,
    action_payload VARIANT,
    action_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_CHANGE_REQUESTS (
    request_id STRING PRIMARY KEY,
    rule_id STRING,
    requester STRING,
    request_payload VARIANT,
    reason STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , review_required BOOLEAN DEFAULT TRUE, review_status STRING, reviewed_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_CONDITION_LIBRARY (
    condition_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    condition_payload VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_DEPENDENCIES (
    dependency_id STRING PRIMARY KEY,
    rule_id STRING,
    depends_on_rule_id STRING,
    relation_type STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_DEPLOYMENTS (
    deployment_id STRING PRIMARY KEY,
    rule_id STRING,
    deployed_by STRING,
    deployed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , environment STRING, deployment_payload VARIANT, status STRING, notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_DOCUMENTATION (
    doc_id STRING PRIMARY KEY,
    rule_id STRING,
    title STRING,
    content VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , updated_by STRING, updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_EVALUATION_CACHE (
    cache_id STRING PRIMARY KEY,
    rule_id STRING,
    cache_key STRING,
    evaluation_result VARIANT,
    ttl_seconds INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , expires_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_EXPORTS (
    export_id STRING PRIMARY KEY,
    rule_id STRING,
    exported_by STRING,
    export_format STRING,
    export_payload VARIANT,
    exported_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_FEATURE_MAPPING (
    mapping_id STRING PRIMARY KEY,
    rule_id STRING,
    feature_key STRING,
    mapping_payload VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_IMPORT_LOG (
    import_id STRING PRIMARY KEY,
    source STRING,
    imported_by STRING,
    import_payload VARIANT,
    imported_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING, errors VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_METADATA (
    meta_id STRING PRIMARY KEY,
    rule_id STRING,
    key STRING,
    value VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_METRICS (
    metric_id STRING PRIMARY KEY,
    rule_id STRING,
    metric_name STRING,
    metric_value NUMBER,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_PERMISSIONS (
    permission_id STRING PRIMARY KEY,
    rule_id STRING,
    principal STRING,
    role STRING,
    granted_by STRING,
    granted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_SANDBOX_PREVIEWS (
    preview_id STRING PRIMARY KEY,
    rule_id STRING,
    previewed_by STRING,
    preview_payload VARIANT,
    preview_result VARIANT,
    previewed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_SCHEDULES (
    schedule_id STRING PRIMARY KEY,
    rule_id STRING,
    schedule_cron STRING,
    timezone STRING,
    next_run_at TIMESTAMP_LTZ,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.rate_rules_staging (
    staging_id STRING PRIMARY KEY,
    feature_key STRING,
    rule_type STRING,
    config VARIANT,
    priority INT,
    submitted_by STRING,
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , approved BOOLEAN DEFAULT FALSE, approved_by STRING, approved_at TIMESTAMP_LTZ, rejected BOOLEAN DEFAULT FALSE, reject_reason STRING );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_TAGS (
    tag_id STRING PRIMARY KEY,
    rule_id STRING,
    tag_key STRING,
    tag_value STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_TEST_CASES (
    test_id STRING PRIMARY KEY,
    rule_id STRING,
    test_input VARIANT,
    expected_output VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , last_run_at TIMESTAMP_LTZ, last_run_result STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULES_VERSION_HISTORY (
    version_id STRING PRIMARY KEY,
    rule_id STRING,
    version_number INT,
    payload VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , change_notes STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULE_TEMPLATES (
    TEMPLATE_ID STRING PRIMARY KEY,
    NAME STRING,
    DESCRIPTION STRING,
    CONFIG_SAMPLE VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULE_TEMPLATE_AUDIT (
    audit_id STRING PRIMARY KEY,
    template_id STRING,
    change_type STRING,
    -- CREATE / UPDATE / DELETE changed_by STRING,
    change_payload VARIANT,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.recipe_execution_audit (
    audit_id STRING PRIMARY KEY,
    execution_id STRING NOT NULL,
    recipe_id STRING,
    org_id STRING,
    event_type STRING,
    -- STARTED,
    STEP_COMPLETED,
    FAILED,
    COMPLETED event_payload VARIANT,
    actor STRING,
    occurred_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.recipe_execution_log (
    log_id STRING PRIMARY KEY,
    execution_id STRING,
    step_index INT,
    step_name STRING,
    status STRING,
    output VARIANT,
    error VARIANT,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.recipe_execution_queue (
    execution_id STRING PRIMARY KEY,
    recipe_id STRING NOT NULL,
    org_id STRING,
    payload VARIANT,
    status STRING DEFAULT 'QUEUED',
    priority INT DEFAULT 100,
    idempotency_key STRING,
    scheduled_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.recipe_run_metrics (
    metric_id STRING PRIMARY KEY,
    execution_id STRING NOT NULL,
    org_id STRING,
    metric_key STRING,
    metric_value NUMBER,
    metric_meta VARIANT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.recipe_template_library (
    recipe_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    description STRING,
    steps VARIANT,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.recipe_template_locks (
    lock_id STRING PRIMARY KEY,
    recipe_id STRING NOT NULL,
    org_id STRING,
    locked_by STRING,
    locked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  expires_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.recipe_template_versions (
    version_id STRING PRIMARY KEY,
    recipe_id STRING NOT NULL,
    org_id STRING,
    author STRING,
    version_number INT,
    steps VARIANT,
    changelog STRING,
    is_active BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RECONCILIATION_AUDIT (
    AUDIT_ID STRING PRIMARY KEY,
    BILLING_RUN_ID STRING,
    RUN_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , MISMATCH_AMOUNT NUMBER(18,6), USAGE_SUM NUMBER(18,6), BILL_SUM NUMBER(18,6), DETAILS VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RECONCILIATION_JOBS (
    job_id STRING PRIMARY KEY,
    job_type STRING,
    -- USAGE_RECON / BILLING_RECON parameters VARIANT,
    scheduled_at TIMESTAMP_LTZ,
    started_at TIMESTAMP_LTZ,
    completed_at TIMESTAMP_LTZ,
    status STRING,
    result VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.reindex_request_queue (
    request_id STRING PRIMARY KEY,
    index_id STRING,
    requested_by STRING,
    priority INT DEFAULT 5,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  started_at TIMESTAMP_LTZ,  completed_at TIMESTAMP_LTZ,  status STRING DEFAULT 'QUEUED',  params VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.renderer_job_queue (
    job_id STRING PRIMARY KEY,
    org_id STRING,
    assembly_run_id STRING,
    html_payload VARIANT,
    options VARIANT,
    status STRING DEFAULT 'QUEUED',
    attempts INT DEFAULT 0,
    last_error STRING,
    enqueued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CLUSTER BY (org_id, status) AI_FEATURE_HUB.renderer_job_resultsCREATE OR REPLACE TABLE AI_FEATURE_HUB.renderer_job_results ( result_id STRING PRIMARY KEY, job_id STRING, org_id STRING, artifact_url STRING, sha256_hash STRING, render_time_ms FLOAT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.pdf_artifact_metadataCREATE OR REPLACE TABLE AI_FEATURE_HUB.pdf_artifact_metadata ( artifact_id STRING PRIMARY KEY, org_id STRING, archive_id STRING, ocr_text VARIANT, page_count INT, language STRING, extracted_entities VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.preview_cache_invalidationCREATE OR REPLACE TABLE AI_FEATURE_HUB.preview_cache_invalidation ( invalidation_id STRING PRIMARY KEY, org_id STRING, cache_key STRING, reason STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.preview_invalidation_workflowCREATE OR REPLACE TABLE AI_FEATURE_HUB.preview_invalidation_workflow ( workflow_id STRING PRIMARY KEY, payload VARIANT, processed BOOLEAN DEFAULT FALSE, enqueued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.template_change_auditCREATE OR REPLACE TABLE AI_FEATURE_HUB.template_change_audit ( audit_id STRING PRIMARY KEY, org_id STRING, template_id STRING, change_type STRING, changed_by STRING, change_payload VARIANT, changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.assembly_validation_rulesCREATE OR REPLACE TABLE AI_FEATURE_HUB.assembly_validation_rules ( rule_id STRING PRIMARY KEY, org_id STRING, rule_code STRING, description STRING, severity STRING, rule_body VARIANT, active BOOLEAN DEFAULT TRUE, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.validation_error_catalogCREATE OR REPLACE TABLE AI_FEATURE_HUB.validation_error_catalog ( error_code STRING PRIMARY KEY, severity STRING, user_message STRING, remediation_guidance STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.ACTIVATION_AUDITCREATE OR REPLACE TABLE AI_FEATURE_HUB.ACTIVATION_AUDIT ( ACTIVATION_ID STRING PRIMARY KEY, ACCOUNT_ID STRING, FEATURE_KEY STRING, ACTION STRING, ADMIN_USER STRING, REASON STRING, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.ALERT_HISTORYCREATE OR REPLACE TABLE AI_FEATURE_HUB.ALERT_HISTORY ( HISTORY_ID STRING PRIMARY KEY, ALERT_ID STRING, ORG_ID STRING, FIRED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), RESOLVED_AT TIMESTAMP_LTZ, PAYLOAD VARIANT) AI_FEATURE_HUB.INGEST_CHECKPOINTCREATE OR REPLACE TABLE AI_FEATURE_HUB.INGEST_CHECKPOINT ( CHECKPOINT_ID STRING PRIMARY KEY, PIPELINE_NAME STRING, LAST_PROCESSED_CURSOR VARIANT, LAST_UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.INGEST_ERROR_SUMMARYCREATE OR REPLACE TABLE AI_FEATURE_HUB.INGEST_ERROR_SUMMARY ( SUMMARY_ID STRING PRIMARY KEY, PIPELINE_NAME STRING, ERROR_TYPE STRING, OCCURRENCES NUMBER, FIRST_SEEN TIMESTAMP_LTZ, LAST_SEEN TIMESTAMP_LTZ) AI_FEATURE_HUB.DOCUMENT_INGEST_MANIFESTCREATE OR REPLACE TABLE AI_FEATURE_HUB.DOCUMENT_INGEST_MANIFEST ( MANIFEST_ID STRING PRIMARY KEY, ORG_ID STRING, PRODUCER_ID STRING, BATCH_TOKEN STRING, STATUS STRING DEFAULT 'PENDING', ROWS_EXPECTED NUMBER, ROWS_RECEIVED NUMBER DEFAULT 0, PROVENANCE VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.DOCUMENT_EMBEDDINGS_V2CREATE OR REPLACE TABLE AI_FEATURE_HUB.DOCUMENT_EMBEDDINGS_V2 ( EMBEDDING_ID STRING PRIMARY KEY, ORG_ID STRING, DOCUMENT_ID STRING, SECTION_ID STRING, VECTOR VARIANT, MODEL_ID STRING, PROVENANCE VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) CLUSTER BY (ORG_ID, DOCUMENT_ID) AI_FEATURE_HUB.VECTOR_STORE_SNAPSHOTSCREATE OR REPLACE TABLE AI_FEATURE_HUB.VECTOR_STORE_SNAPSHOTS ( SNAPSHOT_ID STRING PRIMARY KEY, INDEX_ID STRING, SNAPSHOT_PATH STRING, CREATED_BY STRING, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_4225featureinstancecustomercommstemplatesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4225featureinstancecustomercommstemplates ( TEMPLATE_ID STRING PRIMARY KEY, INSTANCE_REF STRING, FEATURE_KEY STRING, ORG_ID STRING, NAME STRING, TEMPLATE VARIANT, UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_4227featureinstancecustomercommsdispatchqueueCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4227featureinstancecustomercommsdispatchqueue ( DISPATCH_ID STRING PRIMARY KEY, TEMPLATE_ID STRING, INSTANCE_REF STRING, FEATURE_KEY STRING, ORG_ID STRING, RECIPIENTS ARRAY, SCHEDULED_AT TIMESTAMP_LTZ, STATUS STRING DEFAULT 'QUEUED', ATTEMPTS INT DEFAULT 0, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_4229featureinstancecustomercommsdeliverylogCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4229featureinstancecustomercommsdeliverylog ( DELIVERY_ID STRING PRIMARY KEY, DISPATCH_ID STRING, INSTANCE_REF STRING, FEATURE_KEY STRING, ORG_ID STRING, RECIPIENT STRING, STATUS STRING, ATTEMPTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), DETAILS VARIANT) AI_FEATURE_HUB.docgen_4231featureinstanceapiusagequotasCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_4231featureinstanceapiusagequotas ( QUOTA_ID STRING PRIMARY KEY, INSTANCE_REF STRING, FEATURE_KEY STRING, ORG_ID STRING, LIMIT_PER_MINUTE INT, LIMIT_PER_HOUR INT, LIMIT_PER_DAY INT, ENFORCED BOOLEAN DEFAULT TRUE, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_architecture_changesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_architecture_changes (id STRING PRIMARY KEY,parent_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,payload VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_testing_plansCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_testing_plans (id STRING PRIMARY KEY,parent_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,payload VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_testing_runsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_testing_runs (id STRING PRIMARY KEY,parent_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,payload VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_test_run_resultsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_test_run_results (id STRING PRIMARY KEY,parent_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,payload VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_continuous_validation_configsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_continuous_validation_configs (id STRING PRIMARY KEY,parent_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,payload VARIANT,schedule_cron STRING,enabled BOOLEAN DEFAULT TRUE,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_continuous_validation_runsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_continuous_validation_runs (id STRING PRIMARY KEY,validation_config_id STRING,parent_id STRING,incident_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,payload VARIANT,result VARIANT,started_at TIMESTAMP_LTZ,completed_at TIMESTAMP_LTZ,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_comms_templatesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_comms_templates (template_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,name STRING,template VARIANT,updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_comms_template_usagesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_comms_template_usages (usage_id STRING PRIMARY KEY,template_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,invoked_by STRING,invocation_payload VARIANT,invoked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_api_quota_violationsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_api_quota_violations (violation_id STRING PRIMARY KEY,quota_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,offender_identity STRING,count_over INT,window_start TIMESTAMP_LTZ,window_end TIMESTAMP_LTZ,recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_feature_flagsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_feature_flags (flag_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,name STRING,enabled BOOLEAN,criteria VARIANT,created_by STRING,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),updated_at TIMESTAMP_LTZ) AI_FEATURE_HUB.docgen_feature_instance_flag_evaluation_logsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_flag_evaluation_logs (eval_id STRING PRIMARY KEY,flag_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,subject_id STRING,context VARIANT,result BOOLEAN,evaluated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_runtime_metadataCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_runtime_metadata (meta_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,metadata VARIANT,effective_from TIMESTAMP_LTZ,effective_to TIMESTAMP_LTZ,recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_cost_reallocation_requestsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_cost_reallocation_requests (request_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,requested_by STRING,from_cost_center STRING,to_cost_center STRING,amount NUMBER,reason VARIANT,status STRING DEFAULT 'PENDING',requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),processed_at TIMESTAMP_LTZ) AI_FEATURE_HUB.docgen_feature_instance_cost_reallocation_auditCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_cost_reallocation_audit (audit_id STRING PRIMARY KEY,request_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,processed_by STRING,action STRING,details VARIANT,processed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_alert_annotationCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_annotation (annotation_id STRING PRIMARY KEY,alert_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,author STRING,note STRING,metadata VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_retentionCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_retention (policy_id STRING PRIMARY KEY,instance_ref STRING,feature_key STRING,org_id STRING,retention_days INT,created_by STRING,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_purge_jobsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_purge_jobs (job_id STRING PRIMARY KEY,policy_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,scheduled_at TIMESTAMP_LTZ,status STRING DEFAULT 'QUEUED',details VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_purge_historyCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_attachment_purge_history (history_id STRING PRIMARY KEY,job_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,file_ref STRING,purged_at TIMESTAMP_LTZ,outcome VARIANT,recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_customer_comms_dispatch_queueCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_comms_dispatch_queue (dispatch_id STRING PRIMARY KEY,template_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,recipients ARRAY,scheduled_at TIMESTAMP_LTZ,status STRING DEFAULT 'QUEUED',attempts INT DEFAULT 0,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) AI_FEATURE_HUB.docgen_feature_instance_customer_comms_delivery_logCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_customer_comms_delivery_log (delivery_id STRING PRIMARY KEY,dispatch_id STRING,instance_ref STRING,feature_key STRING,org_id STRING,recipient STRING,status STRING,attempted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),details VARIANT) AI_FEATURE_HUB.docgen_feature_instance_root_cause_tagsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_root_cause_tags ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, tags ARRAY, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_playbook_usageCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_playbook_usage ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, playbook_ref STRING, usage_payload VARIANT, invoked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_maintenance_kpisCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_maintenance_kpis ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, kpi_payload VARIANT, measured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_integration_healthCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_integration_health ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, integration_name STRING, status STRING, details VARIANT, checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_notification_preferencesCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_notification_preferences ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, preferences VARIANT, updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_postmortem_linksCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_links ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, link_type STRING, link_url STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.DOCUMENT_EMBEDDINGS_V2CREATE OR REPLACE TABLE AI_FEATURE_HUB.DOCUMENT_EMBEDDINGS_V2 ( EMBEDDING_ID STRING PRIMARY KEY, ORG_ID STRING, DOCUMENT_ID STRING, SECTION_ID STRING, VECTOR VARIANT, MODEL_ID STRING, PROVENANCE VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CLUSTER BY (ORG_ID, DOCUMENT_ID
) AI_FEATURE_HUB.RATE_RULE_TEMPLATESCREATE OR REPLACE TABLE AI_FEATURE_HUB.RATE_RULE_TEMPLATES (template_id STRING PRIMARY KEY,name STRING,description STRING,config_sample VARIANT,created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AI_FEATURE_HUB.renderer_job_results (
    result_id STRING PRIMARY KEY,
    job_id STRING,
    org_id STRING,
    artifact_url STRING,
    sha256_hash STRING,
    render_time_ms FLOAT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retention_hold_cases (
    hold_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    reason STRING,
    initiated_by STRING,
    hold_until TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.RETENTION_POLICIES (
    policy_id STRING PRIMARY KEY,
    name STRING,
    description STRING,
    apply_to STRING,
    -- table / schema / object type retention_days NUMBER,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  updated_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retention_policy_audit (
    audit_id STRING PRIMARY KEY,
    org_id STRING,
    previous_policy VARIANT,
    new_policy VARIANT,
    changed_by STRING,
    changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retention_purge_jobs (
    job_id STRING PRIMARY KEY,
    org_id STRING NOT NULL,
    object_scope STRING,
    status STRING DEFAULT 'SCHEDULED',
    candidate_count NUMBER DEFAULT 0,
    processed_count NUMBER DEFAULT 0,
    checkpoint VARIANT,
    scheduled_at TIMESTAMP_LTZ,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retention_purge_log (
    purge_id STRING PRIMARY KEY,
    org_id STRING,
    table_name STRING,
    deleted_rows NUMBER,
    purge_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    initiated_by STRING,
    justification STRING,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_cache_metrics (
    metric_id STRING PRIMARY KEY,
    org_id STRING,
    query_hash STRING,
    topk_results VARIANT,
    p95_latency_ms FLOAT,
    cost_estimate FLOAT,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_explainability_traces (
    trace_id STRING PRIMARY KEY,
    query_id STRING,
    index_id STRING,
    org_id STRING,
    trace_payload VARIANT,
    generated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_latency_alerts (
    alert_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    threshold_ms FLOAT,
    observed_ms FLOAT,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , acknowledged BOOLEAN DEFAULT FALSE, ack_by STRING, ack_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_latency_hist (
    record_id STRING PRIMARY KEY,
    org_id STRING,
    query_hash STRING,
    topk INT,
    latency_ms FLOAT,
    backend STRING,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_metrics_summary (
    summary_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    total_queries NUMBER,
    avg_latency_ms FLOAT,
    p50_latency_ms FLOAT,
    p95_latency_ms FLOAT,
    error_count NUMBER,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_performance_baselines (
    baseline_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    baseline_window_start TIMESTAMP_LTZ,
    baseline_window_end TIMESTAMP_LTZ,
    avg_latency_ms FLOAT,
    p95_latency_ms FLOAT,
    throughput_qps FLOAT,
    computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_privacy_mask_requests (
    mask_request_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    embedding_id STRING,
    requested_by STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , status STRING DEFAULT 'PENDING', processed_at TIMESTAMP_LTZ, notes VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_quality_scorecard (
    scorecard_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    evaluation_date TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , precision_at_k FLOAT, recall_at_k FLOAT, ndcg FLOAT, sample_count INT, notes VARIANT, computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_query_cache (
    cache_key STRING PRIMARY KEY,
    org_id STRING,
    query_hash STRING,
    query_vector VARIANT,
    top_k INT,
    results VARIANT,
    ttl_seconds INT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  last_accessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_query_patterns (
    pattern_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    sample_query_hash STRING,
    pattern_description STRING,
    observed_count INT,
    first_seen TIMESTAMP_LTZ,
    last_seen TIMESTAMP_LTZ,
    metadata VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_session_tokens (
    token STRING PRIMARY KEY,
    org_id STRING,
    session_id STRING,
    index_id STRING,
    scopes ARRAY,
    issued_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  expires_at TIMESTAMP_LTZ,  last_used_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_user_feedback (
    feedback_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    user_id STRING,
    query_hash STRING,
    relevance_score INT,
    comment STRING,
    submitted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.reviewer_queue (
    review_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    section_id STRING,
    reason STRING,
    assigned_to STRING,
    status STRING DEFAULT 'OPEN',
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.ROLE_ACCOUNT_MAPPING (
    MAPPING_ID STRING PRIMARY KEY,
    ROLE_NAME STRING,
    ORG_ID STRING,
    EFFECTIVE_FROM TIMESTAMP_LTZ,
    EFFECTIVE_TO TIMESTAMP_LTZ,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.SCHEMA_VERSIONS (
    VERSION_ID INT AUTOINCREMENT START 1 INCREMENT 1,
    SCHEMA_VERSION STRING,
    SCRIPT_NAME STRING,
    APPLIED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,STATUS STRING,PRIMARY KEY(VERSION_ID));


CREATE OR REPLACE TABLE AI_FEATURE_HUB.SECTION_EMBEDDINGS (
    embedding_id STRING PRIMARY KEY,
    ORG_ID STRING,
    document_id STRING,
    section_id STRING,
    model_id STRING,
    embedding VARIANT,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ) CLUSTER BY (ORG_ID, document_id);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.section_quality_scores (
    score_id STRING PRIMARY KEY,
    org_id STRING,
    document_id STRING,
    section_id STRING,
    coverage FLOAT,
    cleanliness FLOAT,
    confidence FLOAT,
    assessed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_cache_eviction_log (
    evict_id STRING PRIMARY KEY,
    cache_key STRING,
    org_id STRING,
    reason STRING,
    evicted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_cache_metrics (
    metric_id STRING PRIMARY KEY,
    cache_key STRING,
    org_id STRING,
    hit BOOLEAN,
    access_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_access_logs (
    access_id STRING PRIMARY KEY,
    index_id STRING,
    principal STRING,
    principal_type STRING,
    action STRING,
    action_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , client_ip STRING, user_agent STRING, details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_emergency_lock (
    lock_id STRING PRIMARY KEY,
    index_id STRING,
    locked_by STRING,
    locked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , expires_at TIMESTAMP_LTZ, reason STRING, metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_export_jobs (
    export_job_id STRING PRIMARY KEY,
    index_id STRING,
    export_format STRING,
    destination_uri STRING,
    requested_by STRING,
    requested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  completed_at TIMESTAMP_LTZ,  status STRING DEFAULT 'PENDING',  manifest VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_health (
    check_id STRING PRIMARY KEY,
    index_id STRING,
    org_id STRING,
    recall FLOAT,
    precision FLOAT,
    last_check TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_maintenance_logs (
    maintenance_id STRING PRIMARY KEY,
    index_id STRING,
    action STRING,
    actor STRING,
    details VARIANT,
    performed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_rebuild_history (
    rebuild_id STRING PRIMARY KEY,
    index_id STRING,
    initiated_by STRING,
    reason STRING,
    parameters VARIANT,
    started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  completed_at TIMESTAMP_LTZ,  status STRING DEFAULT 'QUEUED',  result VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_stats_hist LIKE AI_FEATURE_HUB.semantic_index_stats;


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_usage_by_org (
    usage_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    period_start TIMESTAMP_LTZ,
    period_end TIMESTAMP_LTZ,
    queries NUMBER,
    unique_users NUMBER,
    bytes_read NUMBER,
    recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.SEMANTIC_QUERY_LOGS (
    log_id STRING PRIMARY KEY,
    ORG_ID STRING,
    query_hash STRING,
    query_params VARIANT,
    latency_ms FLOAT,
    topk_results VARIANT,
    cost_estimate FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_retrieval_blacklist (
    blacklist_id STRING PRIMARY KEY,
    org_id STRING,
    term STRING,
    reason STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_retrieval_cache (
    cache_id STRING PRIMARY KEY,
    query_hash STRING,
    model_context VARIANT,
    retrieval_result VARIANT,
    ttl_seconds INT DEFAULT 600,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_retrieval_gc (
    gc_run_id STRING PRIMARY KEY,
    org_id STRING,
    rows_examined NUMBER,
    rows_deleted NUMBER,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.SEMANTIC_SEARCH_COST_ESTIMATE (
    ESTIMATE_ID STRING PRIMARY KEY,
    ORG_ID STRING,
    QUERY_PATTERN STRING,
    AVG_COST FLOAT,
    AVG_LATENCY_MS FLOAT,
    RECORDED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_search_telemetry (
    telemetry_id STRING PRIMARY KEY,
    org_id STRING,
    query_text STRING,
    query_hash STRING,
    model_id STRING,
    top_k INT,
    latency_ms FLOAT,
    results_count INT,
    user_context VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.shard_cleanup_requests (
    request_id STRING PRIMARY KEY,
    shard_id STRING,
    index_id STRING,
    requested_by STRING,
    request_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , processed_ts TIMESTAMP_LTZ, status STRING DEFAULT 'REQUESTED', details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.Signature_Record (
    signature_id STRING PRIMARY KEY,
    document_id STRING,
    signer_id STRING,
    provider STRING,
    provider_envelope_id STRING,
    signed_at TIMESTAMP_LTZ,
    verification_result VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_index_access_control (
    acl_id STRING PRIMARY KEY,
    index_id STRING,
    principal_type STRING,
    -- 'ROLE' | 'USER' | 'SERVICE' principal STRING,
    permission STRING,
    -- 'READ' | 'WRITE' | 'ADMIN' granted_by STRING,
    granted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  expires_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_model_aliases (
    alias_id STRING PRIMARY KEY,
    alias STRING,
    model_id STRING,
    model_version STRING,
    org_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , created_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_model_monitoring_metrics (
    metric_id STRING PRIMARY KEY,
    model_id STRING,
    model_version STRING,
    org_id STRING,
    metric_name STRING,
    metric_value FLOAT,
    metric_ts TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  context VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_query_billing_events (
    billing_event_id STRING PRIMARY KEY,
    query_id STRING,
    org_id STRING,
    index_id STRING,
    items_charged NUMBER,
    cost_amount NUMBER,
    currency STRING,
    billed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , details VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_query_cost_profiles (
    profile_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    cost_per_query NUMBER,
    cost_currency STRING,
    billing_granularity STRING,
    effective_from TIMESTAMP_LTZ,
    effective_to TIMESTAMP_LTZ,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  created_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_query_logs (
    query_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    query_vector VARIANT,
    top_k NUMBER,
    returned_count NUMBER,
    latency_ms FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_query_throttles (
    throttle_id STRING PRIMARY KEY,
    org_id STRING,
    index_id STRING,
    period_seconds INT,
    max_queries INT,
    window_start TIMESTAMP_LTZ,
    window_end TIMESTAMP_LTZ,
    enforced BOOLEAN DEFAULT TRUE,
    updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_results (
    query_id STRING PRIMARY KEY,
    org_id STRING,
    model_id STRING,
    query_text STRING,
    retrieved ARRAY,
    scores ARRAY,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_retry_policy (
    policy_id STRING PRIMARY KEY,
    org_id STRING,
    max_retries INT,
    base_backoff_seconds INT,
    max_backoff_seconds INT,
    jitter BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.similarity_service_config (
    config_id STRING PRIMARY KEY,
    org_id STRING,
    service_endpoint STRING,
    auth VARIANT,
    timeout_ms INT DEFAULT 30000,
    retry_policy_id STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.snapshot_defragmentation_jobs (
    job_id STRING PRIMARY KEY,
    snapshot_id STRING,
    index_id STRING,
    initiated_by STRING,
    scheduled_at TIMESTAMP_LTZ,
    started_at TIMESTAMP_LTZ,
    finished_at TIMESTAMP_LTZ,
    reclaimed_bytes NUMBER,
    status STRING DEFAULT 'SCHEDULED',
    log VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.STAGED_EMBEDDINGS (
    file_name STRING,
    row_number_in_file NUMBER,
    document_id STRING,
    idempotency_key STRING,
    embedding VARIANT,
    metadata VARIANT,
    file_ingested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.STAGED_USAGE (
    file_name STRING,
    row_number_in_file NUMBER,
    event_id STRING,
    org_id STRING,
    feature_code STRING,
    units NUMBER,
    model_id STRING,
    payload VARIANT,
    file_ingested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.SUBSCRIPTION_INVOICES (
    INVOICE_ID STRING PRIMARY KEY,
    ORG_ID STRING,
    ACCOUNT_ID STRING,
    CURRENCY STRING,
    SUBTOTAL NUMBER,
    MARKUP NUMBER,
    TAX NUMBER,
    TOTAL NUMBER,
    LINE_ITEMS VARIANT,
    /* array/object of line item detail */CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.tamper_alerts (
    alert_id STRING PRIMARY KEY,
    org_id STRING,
    archive_id STRING,
    detected_via STRING,
    details VARIANT,
    severity STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.tenants (
    tenant_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    plan STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  metadata VARIANT);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.TENANT_CONFIGURATION (
    CONFIG_ID STRING PRIMARY KEY,
    ACCOUNT_ID STRING,
    ORG_ID STRING,
    CONFIG_KEY STRING,
    CONFIG_VALUE VARIANT,
    UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.tenant_feature_pricing (
    id STRING PRIMARY KEY,
    org_id STRING,
    feature_code STRING,
    unit_price NUMBER,
    currency STRING,
    markup_json VARIANT,
    effective_from TIMESTAMP_LTZ,
    effective_to TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.TENANT_FEATURE_USAGE (
    USAGE_ID STRING PRIMARY KEY,
    ORG_ID STRING,
    ACCOUNT_ID STRING,
    FEATURE_KEY STRING,
    MODEL_ID STRING,
    UNITS NUMBER(18,6
) , UNIT_PRICE NUMBER(18,6), USAGE_TIMESTAMP TIMESTAMP_LTZ, METADATA VARIANT, CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CLUSTER BY (ORG_ID, USAGE_TIMESTAMP);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.TENANT_FEATURE_USAGE_DAILY (
    usage_id STRING PRIMARY KEY,
    org_id STRING,
    feature_key STRING,
    usage_date DATE,
    units NUMBER,
    model_id STRING,
    cost_estimate NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_AGGREGATES_DAILY (
    agg_id STRING PRIMARY KEY,
    account_id STRING,
    feature_code STRING,
    usage_date DATE,
    total_units NUMBER,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.usage_aggregation_daily (
    agg_id STRING PRIMARY KEY,
    org_id STRING,
    feature_code STRING,
    day DATE,
    total_units NUMBER,
    total_cost FLOAT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CLUSTER BY (org_id, created_at) AI_FEATURE_HUB.invoice_dryrun_cacheDescription: Dry-run invoice snapshots for previews and reconciliation.CREATE OR REPLACE TABLE AI_FEATURE_HUB.invoice_dryrun_cache ( dryrun_id STRING PRIMARY KEY, org_id STRING, period_start TIMESTAMP_LTZ, period_end TIMESTAMP_LTZ, invoice_payload VARIANT, invoice_hash STRING, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.retention_hold_casesDescription: Legal/compliance retention hold cases preventing purge.CREATE OR REPLACE TABLE AI_FEATURE_HUB.retention_hold_cases ( case_id STRING PRIMARY KEY, org_id STRING, case_reason STRING, affected_document_ids ARRAY, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), expires_at TIMESTAMP_LTZ ) AI_FEATURE_HUB.ingest_checkpointDescription: Checkpoint state for resumable ingestion pipelines.CREATE OR REPLACE TABLE AI_FEATURE_HUB.ingest_checkpoint ( checkpoint_id STRING PRIMARY KEY, pipeline_name STRING, last_processed_cursor VARIANT, last_updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.ingest_error_summaryDescription: Aggregated ingest error categories for ops dashboards.CREATE OR REPLACE TABLE AI_FEATURE_HUB.ingest_error_summary ( summary_id STRING PRIMARY KEY, pipeline_name STRING, error_type STRING, occurrences NUMBER, first_seen TIMESTAMP_LTZ, last_seen TIMESTAMP_LTZ ) AI_FEATURE_HUB.document_ingest_manifestDescription: Tracks document ingest batches,
    provenance and offsets.CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_ingest_manifest ( manifest_id STRING PRIMARY KEY, org_id STRING, producer_id STRING, batch_token STRING, status STRING DEFAULT 'PENDING', rows_expected NUMBER, rows_received NUMBER DEFAULT 0, provenance VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.document_embeddings_v2Description: Document embeddings with flexible vector/provenance storage.CREATE OR REPLACE TABLE AI_FEATURE_HUB.document_embeddings_v2 ( embedding_id STRING PRIMARY KEY, org_id STRING, document_id STRING, section_id STRING, vector VARIANT, model_id STRING, provenance VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) CLUSTER BY (org_id, document_id) AI_FEATURE_HUB.vector_store_snapshotsDescription: Snapshot registry for vector/FAISS/ANN indexes.CREATE OR REPLACE TABLE AI_FEATURE_HUB.vector_store_snapshots ( snapshot_id STRING PRIMARY KEY, index_id STRING, snapshot_path STRING, created_by STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.ann_index_metadataDescription: Metadata describing ANN indexes (engine, metric, dims, shards).CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_metadata ( index_id STRING PRIMARY KEY, org_id STRING, engine STRING, metric STRING, dims INT, shard_count INT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.ann_index_shardsDescription: Shard-level information for ANN indexes (path, host hints).CREATE OR REPLACE TABLE AI_FEATURE_HUB.ann_index_shards ( shard_id STRING PRIMARY KEY, index_id STRING, shard_path STRING, host_hint STRING, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.retrieval_cache_metricsDescription: Retrieval/RAG cache metrics (latency, top-k quality, cost).CREATE OR REPLACE TABLE AI_FEATURE_HUB.retrieval_cache_metrics ( metric_id STRING PRIMARY KEY, org_id STRING, query_hash STRING, topk_results VARIANT, p95_latency_ms FLOAT, cost_estimate FLOAT, recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.model_registry_versionsDescription: Historical model registry events for governance/audit.CREATE OR REPLACE TABLE AI_FEATURE_HUB.model_registry_versions ( record_id STRING PRIMARY KEY, model_id STRING, provider STRING, model_name STRING, model_version STRING, action STRING, changed_by STRING, change_reason STRING, changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.prompt_template_hashmapDescription: Mapping of prompt templates to hashes for rotation/revocation.CREATE OR REPLACE TABLE AI_FEATURE_HUB.prompt_template_hashmap ( template_id STRING PRIMARY KEY, prompt_hash STRING, model_binding STRING, safe_mode BOOLEAN, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.semantic_index_healthDescription: Periodic health metrics for semantic indices (recall/precision).CREATE OR REPLACE TABLE AI_FEATURE_HUB.semantic_index_health ( check_id STRING PRIMARY KEY, index_id STRING, org_id STRING, recall FLOAT, precision FLOAT, last_check TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_timelinesDescription: Incident/feature-instance timelines (consolidated docgen artifact).CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_timelines ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, payload VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_postmortem_metricsDescription: Postmortem metrics stored per incident/instance.CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_metrics ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, payload VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_operational_metricsDescription: Operational metrics (ongoing telemetry tied to incidents/instances).CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_operational_metrics ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, payload VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AI_FEATURE_HUB.docgen_feature_instance_alert_correlationDescription: Correlated alert records for incident triage/analysis.CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_alert_correlation ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, payload VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP() ) AIFEATUREHUB.docgen4201featureinstanceservicetokensDescription: Service tokens issued to feature instances (from AIFEATUREHUB tranche).CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4201featureinstanceservicetokens ( tokenid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, tokenref STRING, issuedto STRING, scopes ARRAY, expiresat TIMESTAMPLTZ, issuedat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() ) AIFEATUREHUB.docgen4203featureinstanceservicetokenauditDescription: Audit log for instance service token actions (AIFEATUREHUB tranche).CREATE OR REPLACE TABLE AIFEATUREHUB.docgen4203featureinstanceservicetokenaudit ( auditid STRING PRIMARY KEY, tokenid STRING, instanceref STRING, featurekey STRING, orgid STRING, action STRING, actor STRING, notes VARIANT, actedat TIMESTAMPLTZ DEFAULT CURRENTTIMESTAMP()
) AIFEATUREHUB.docgen4205featureinstancecheduledhealthchecksCREATE OR REPLACE TABLE AIFEATUREHUB.docgen4205featureinstancecheduledhealthchecks ( scheduleid STRING PRIMARY KEY, instanceref STRING, featurekey STRING, orgid STRING, checkid STRING, nextrunat TIMESTAMPLTZ, cadenceseconds INT, enabled BOOLEAN DEFAULT TRUE, createdat TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP() );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_ANOMALIES (
    anomaly_id STRING PRIMARY KEY,
    account_id STRING,
    feature_key STRING,
    detected_at TIMESTAMP_LTZ,
    anomaly_score FLOAT,
    details VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.usage_events (
    event_id STRING PRIMARY KEY,
    tenant_id STRING,
    feature_key STRING,
    event_type STRING,
    units NUMBER,
    event_time TIMESTAMP_LTZ,
    payload VARIANT,
    ingested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_EVENTS_DETAILED (
    usage_id STRING PRIMARY KEY,
    ORG_ID STRING,
    feature_code STRING,
    model_id STRING,
    tokens NUMBER,
    cost FLOAT,
    event_time TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , meta VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_INGEST_CHECKPOINT (
    checkpoint_id STRING PRIMARY KEY,
    last_processed_offset STRING,
    source STRING,
    last_updated TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.usage_quota_definitions (
    quota_id STRING PRIMARY KEY,
    org_id STRING,
    feature_code STRING,
    monthly_quota NUMBER,
    overage_allowed BOOLEAN,
    overage_rate FLOAT,
    created_at TIMESTAMPLTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_RAW_STAGE (
    record_id STRING PRIMARY KEY,
    raw_event VARIANT,
    source_file STRING,
    ingested_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,  processed BOOLEAN DEFAULT FALSE,  processed_at TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.USAGE_RESERVATIONS (
    reservation_id STRING PRIMARY KEY,
    ORG_ID STRING,
    feature_code STRING,
    units_reserved NUMBER(18,6
) , reserved_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(), ttl_seconds INT DEFAULT 300, status STRING DEFAULT 'ACTIVE', metadata VARIANT );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.validation_error_catalog (
    error_code STRING PRIMARY KEY,
    severity STRING,
    user_message STRING,
    remediation STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.VECTORSTORE (
    index_id STRING PRIMARY KEY,
    org_id STRING,
    name STRING,
    description STRING,
    metadata VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.vectorstore_metadata (
    index_id STRING PRIMARY KEY,
    org_id STRING,
    index_name STRING,
    algorithm STRING,
    dimension INT,
    metric STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    last_snapshot_id STRING,
    config VARIANT
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.vector_archive_manifest (
    archive_id STRING PRIMARY KEY,
    index_id STRING,
    snapshot_id STRING,
    storage_uri STRING,
    object_count NUMBER,
    total_bytes NUMBER,
    checksum STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) , created_by STRING);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.vector_chunk_manifest (
    chunk_id STRING PRIMARY KEY,
    snapshot_id STRING,
    index_id STRING,
    shard_id STRING,
    path STRING,
    size_bytes NUMBER,
    checksum STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.vector_ingest_dlq (
    dlq_id STRING PRIMARY KEY,
    stage_id STRING,
    org_id STRING,
    payload VARIANT,
    error_message STRING,
    inserted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.vector_ingest_stage (
    stage_id STRING PRIMARY KEY,
    org_id STRING,
    source STRING,
    payload VARIANT,
    status STRING DEFAULT 'NEW',
    error_message STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.vector_store_snapshots (
    snapshot_id STRING PRIMARY KEY,
    index_id STRING,
    snapshot_path STRING,
    created_by STRING,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.WAREHOUSE_CONFIGS (
    config_name VARCHAR,
    warehouse_size VARCHAR,
    auto_suspend_mins NUMBER,
    min_clusters NUMBER,
    max_clusters NUMBER
);


CREATE OR REPLACE TABLE AI_FEATURE_HUB.WEBHOOK_QUEUE (
    WEBHOOK_ID STRING PRIMARY KEY,
    TARGET_URL STRING,
    PAYLOAD VARIANT,
    ATTEMPTS INT DEFAULT 0,
    NEXT_ATTEMPT_AT TIMESTAMP_LTZ,
    STATUS STRING DEFAULT 'QUEUED',
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE AI_FEATURE_HUB.workflow_audit_trail (
    audit_id STRING PRIMARY KEY,
    org_id STRING,
    workflow_id STRING,
    step_name STRING,
    step_status STRING,
    actor STRING,
    details VARIANT,
    created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.AIANNOTATIONINDEX6043 (
    ANNOTID STRING PRIMARY KEY,
    DOCUMENTID STRING,
    ANNOTJSON VARIANT,
    CREATEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.ANCHOR_NOTARIES (
    NOTARY_ID STRING PRIMARY KEY,
    ANCHOR_ID STRING,
    NOTARY_NAME STRING,
    NOTARY_SIG VARIANT,
    NOTARIZED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.ANNOTATIONREVIEWLOGS6045 (
    LOGID STRING PRIMARY KEY,
    QUEUEID STRING,
    ENTRY VARIANT,
    LOGGEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.ANNOTATIONREVIEWQUEUE6044 (
    QUEUEID STRING PRIMARY KEY,
    ANNOTID STRING,
    STATUS STRING DEFAULT 'PENDING',
    ENQUEUEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.DOCUMENTTRANSLATIONINDEX6046 (
    TRANSID STRING PRIMARY KEY,
    DOCUMENTID STRING,
    LANGCODE STRING,
    TRANSLJSON VARIANT,
    TRANSLATEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.EVIDENCE_TRANSFERS (
    TRANSFER_ID STRING PRIMARY KEY,
    BUNDLE_ID STRING,
    FROM_ENV STRING,
    TO_ENV STRING,
    TRANSFER_PAYLOAD VARIANT,
    TRANSFERRED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_CHANGELOG (
    CHANGE_ID STRING PRIMARY KEY,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    CHANGE_TYPE STRING,
    DETAILS VARIANT,
    CHANGED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_CHANGE_APPROVALS (
    APPROVAL_ID STRING PRIMARY KEY,
    REQUEST_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    REQUEST_PAYLOAD VARIANT,
    REQUESTED_BY STRING,
    STATUS STRING DEFAULT 'PENDING',
    REVIEWED_BY STRING,
    REVIEWED_AT TIMESTAMP_LTZ,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_CHANGE_APPROVAL_DECISIONSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_CHANGE_APPROVAL_DECISIONS (DECISION_ID STRING PRIMARY KEY,APPROVAL_ID STRING,DECISION STRING, -- 'APPROVE' | 'REJECT'DECISION_REASON STRING,DECISION_BY STRING,DECISION_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),DETAILS VARIANT) DOCGEN.FEATURE_INSTANCE_CHANGE_APPROVAL_AUDITCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_CHANGE_APPROVAL_AUDIT (AUDIT_ID STRING PRIMARY KEY,APPROVAL_ID STRING,ACTION STRING, -- 'SUBMIT' | 'UPDATE' | 'DECIDE' | 'CANCEL'ACTOR STRING,ACTION_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),PAYLOAD VARIANT) DOCGEN.FEATURE_INSTANCE_RELEASE_POSTMORTEM_ACTIONSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_RELEASE_POSTMORTEM_ACTIONS (ACTION_ID STRING PRIMARY KEY,POSTMORTEM_ID STRING,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,ACTION_DESC STRING,OWNER STRING,STATUS STRING DEFAULT 'OPEN',TARGET_BY TIMESTAMP_LTZ,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),METADATA VARIANT) DOCGEN.FEATURE_INSTANCE_RELEASE_POSTMORTEM_ACTION_UPDATESCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_RELEASE_POSTMORTEM_ACTION_UPDATES (UPDATE_ID STRING PRIMARY KEY,ACTION_ID STRING,UPDATE_TEXT STRING,UPDATED_BY STRING,UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),UPDATE_PAYLOAD VARIANT) DOCGEN.FEATURE_INSTANCE_TELEMETRY_MAPPING_CONFIGSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_TELEMETRY_MAPPING_CONFIGS (CONFIG_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,MAPPING_NAME STRING,MAPPING_SPEC VARIANT,VERSION NUMBER DEFAULT 1,ACTIVE BOOLEAN DEFAULT TRUE,CREATED_BY STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_TELEMETRY_MAPPING_HISTCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_TELEMETRY_MAPPING_HIST (HIST_ID STRING PRIMARY KEY,CONFIG_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,MAPPING_SPEC VARIANT,EFFECTIVE_FROM TIMESTAMP_LTZ,EFFECTIVE_TO TIMESTAMP_LTZ,CHANGED_BY STRING,CHANGED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
) DOCGEN.FEATURE_INSTANCE_KPI_THRESHOLDSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_KPI_THRESHOLDS (THRESHOLD_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,KPI_NAME STRING,OPERATOR STRING, -- '&gt;


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_COMPLIANCE_RECORDS (
    RECORD_ID STRING PRIMARY KEY,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    RULE_ID STRING,
    STATUS STRING,
    EVIDENCE VARIANT,
    RECORDED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_ESCALATION_LOG (
    ESCALATION_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    ESCALATED_TO STRING,
    REASON VARIANT,
    ESCALATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_ACTIONS (
    ACTION_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    ACTION_TYPE STRING,
    DETAILS VARIANT,
    EXECUTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_ATTACHMENTS (
    ATTACHMENT_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    FILE_URL STRING,
    META VARIANT,
    UPLOADED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_FOLLOWUPS (
    FOLLOWUP_ID STRING PRIMARY KEY,
    PARENT_ID STRING,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    PAYLOAD VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_FOLLOWUPS_5941 (
    FOLLOWUP_ID STRING PRIMARY KEY,
    PARENT_ID STRING,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    PAYLOAD VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_METRICS (
    METRIC_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    METRIC_NAME STRING,
    METRIC_VALUE NUMBER,
    RECORDED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_NOTES (
    NOTE_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    AUTHOR STRING,
    NOTE VARIANT,
    NOTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_STATUS_HISTORY (
    STATUS_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    FROM_STATUS STRING,
    TO_STATUS STRING,
    CHANGED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_TAGS (
    TAG_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    TAG STRING,
    TAGGED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_KB_REFERENCES (
    KBREF_ID STRING PRIMARY KEY,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    KB_URL STRING,
    TITLE STRING,
    ADDED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_KPI_BREACH_EVENTS (
    BREACH_ID STRING PRIMARY KEY,
    THRESHOLD_ID STRING,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    KPI_NAME STRING,
    ACTUAL_VALUE NUMBER,
    EXPECTED_VALUE NUMBER,
    BREACHED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    CONTEXT VARIANT) DOCGEN.FEATURE_INSTANCE_VISIBILITY_VIEWSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_VISIBILITY_VIEWS (VIEW_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,VIEW_NAME STRING,VIEW_SPEC VARIANT,OWNER STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),IS_PUBLIC BOOLEAN DEFAULT FALSE) DOCGEN.FEATURE_INSTANCE_VISIBILITY_VIEW_ACCESS_LOGSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_VISIBILITY_VIEW_ACCESS_LOGS (ACCESS_ID STRING PRIMARY KEY,VIEW_ID STRING,USER_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,ACCESS_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),ACCESS_CONTEXT VARIANT) DOCGEN.FEATURE_INSTANCE_SYNTHETIC_TESTSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_SYNTHETIC_TESTS (TEST_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,TEST_NAME STRING,TEST_SPEC VARIANT,SCHEDULE_CRON STRING,ENABLED BOOLEAN DEFAULT TRUE,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_AUDIT_LOG_EXPORTSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_AUDIT_LOG_EXPORTS (EXPORT_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,REQUESTED_BY STRING,EXPORT_QUERY STRING,TARGET_STAGE STRING,STATUS STRING DEFAULT 'PENDING',REQUESTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),COMPLETED_AT TIMESTAMP_LTZ,METADATA VARIANT) DOCGEN.FEATURE_INSTANCE_AUDIT_LOG_EXPORT_PARTSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_AUDIT_LOG_EXPORT_PARTS (PART_ID STRING PRIMARY KEY,EXPORT_ID STRING,PART_INDEX NUMBER,PART_URL STRING,PART_SIZE_BYTES NUMBER,UPLOADED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_EVENT_REPLAY_JOBSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_EVENT_REPLAY_JOBS (REPLAY_JOB_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,REPLAY_SPEC VARIANT,REQUESTED_BY STRING,STATUS STRING DEFAULT 'QUEUED',REQUESTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),STARTED_AT TIMESTAMP_LTZ,FINISHED_AT TIMESTAMP_LTZ,RESULT VARIANT) DOCGEN.FEATURE_INSTANCE_EVENT_REPLAY_JOB_PARTSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_EVENT_REPLAY_JOB_PARTS (PART_ID STRING PRIMARY KEY,REPLAY_JOB_ID STRING,PART_INDEX NUMBER,PART_PAYLOAD VARIANT,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_SERVICE_LEVEL_REPORTSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_SERVICE_LEVEL_REPORTS (REPORT_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,REPORT_NAME STRING,REPORT_SPEC VARIANT,GENERATED_AT TIMESTAMP_LTZ,STATUS STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_SERVICE_LEVEL_REPORT_SUBSCRIBERSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_SERVICE_LEVEL_REPORT_SUBSCRIBERS (SUBSCRIBER_ID STRING PRIMARY KEY,REPORT_ID STRING,USER_ID STRING,DELIVERY_CHANNEL STRING, -- 'EMAIL','WEBHOOK', etc.CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),PREFERENCES VARIANT) DOCGEN.FEATURE_INSTANCE_OPERATIONAL_RUNBOOKSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_OPERATIONAL_RUNBOOKS (RUNBOOK_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,TITLE STRING,RUNBOOK_BODY VARIANT,VERSION NUMBER DEFAULT 1,CREATED_BY STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_RUNBOOK_EXECUTIONSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_RUNBOOK_EXECUTIONS (EXECUTION_ID STRING PRIMARY KEY,RUNBOOK_ID STRING,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,TRIGGERED_BY STRING,STARTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),FINISHED_AT TIMESTAMP_LTZ,STATUS STRING,OUTPUT VARIANT) DOCGEN.FEATURE_INSTANCE_SERVICE_LEVEL_REPORT_SUBSCRIBERSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_SERVICE_LEVEL_REPORT_SUBSCRIBERS (SUBSCRIBER_ID STRING PRIMARY KEY,REPORT_ID STRING,USER_ID STRING,DELIVERY_CHANNEL STRING, -- 'EMAIL','WEBHOOK', etc.CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),PREFERENCES VARIANT) DOCGEN.FEATURE_INSTANCE_OPERATIONAL_RUNBOOKSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_OPERATIONAL_RUNBOOKS (RUNBOOK_ID STRING PRIMARY KEY,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,TITLE STRING,RUNBOOK_BODY VARIANT,VERSION NUMBER DEFAULT 1,CREATED_BY STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_RUNBOOK_CHANGE_REQUESTSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_RUNBOOK_CHANGE_REQUESTS (REQUEST_ID STRING PRIMARY KEY,RUNBOOK_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,REQUEST_PAYLOAD VARIANT,REQUESTED_BY STRING,REQUESTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),STATUS STRING DEFAULT 'PENDING') DOCGEN.FEATURE_INSTANCE_RUNBOOK_CHANGE_DECISIONSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_RUNBOOK_CHANGE_DECISIONS (DECISION_ID STRING PRIMARY KEY,REQUEST_ID STRING,DECISION STRING, -- 'APPROVE' | 'REJECT'DECISION_REASON STRING,DECISION_BY STRING,DECISION_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),DETAILS VARIANT) DOCGEN.FEATURE_INSTANCE_RUNBOOK_CHANGE_AUDITCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_RUNBOOK_CHANGE_AUDIT (AUDIT_ID STRING PRIMARY KEY,REQUEST_ID STRING,ACTION STRING, -- 'SUBMIT' | 'UPDATE' | 'DECIDE' | 'CANCEL'ACTOR STRING,ACTION_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),PAYLOAD VARIANT) DOCGEN.FEATURE_INSTANCE_INCIDENT_ROOT_CAUSE_TEMPLATESCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_ROOT_CAUSE_TEMPLATES (TEMPLATE_ID STRING PRIMARY KEY,ORG_ID STRING,NAME STRING,TEMPLATE_BODY VARIANT,CREATED_BY STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_INCIDENT_FOLLOWUPSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_FOLLOWUPS (FOLLOWUP_ID STRING PRIMARY KEY,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,FOLLOWUP_BODY VARIANT,SCHEDULED_AT TIMESTAMP_LTZ,CREATED_BY STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),STATUS STRING DEFAULT 'OPEN') DOCGEN.FEATURE_INSTANCE_POSTMORTEM_PARTICIPANTSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_POSTMORTEM_PARTICIPANTS (PARTICIPANT_ID STRING PRIMARY KEY,POSTMORTEM_ID STRING,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,USER_ID STRING,ROLE STRING,ADDED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_INCIDENT_METRICS_DEFINITIONSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_METRICS_DEFINITIONS (METRIC_DEF_ID STRING PRIMARY KEY,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,METRIC_NAME STRING,METRIC_SPEC VARIANT,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_INCIDENT_METRIC_SAMPLESCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_METRIC_SAMPLES (SAMPLE_ID STRING PRIMARY KEY,METRIC_DEF_ID STRING,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,SAMPLE_TS TIMESTAMP_LTZ,SAMPLE_VALUE NUMBER,SAMPLE_CONTEXT VARIANT,INGESTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_POSTMORTEM_ACTION_PRIORITIESCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_POSTMORTEM_ACTION_PRIORITIES (PRIORITY_ID STRING PRIMARY KEY,POSTMORTEM_ID STRING,ACTION_ID STRING,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,PRIORITY_LEVEL STRING, -- e.g., 'P0','P1','P2'NOTES VARIANT,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_ROOT_CAUSE_ANALYSIS_NOTESCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_ROOT_CAUSE_ANALYSIS_NOTES (NOTE_ID STRING PRIMARY KEY,POSTMORTEM_ID STRING,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,AUTHOR STRING,NOTE_TEXT STRING,ATTACHMENTS VARIANT,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_INCIDENT_RELATED_SERVICESCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_RELATED_SERVICES (REL_SERVICE_ID STRING PRIMARY KEY,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,SERVICE_NAME STRING,SERVICE_REF STRING,CONTEXT VARIANT,ADDED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_POSTMORTEM_TIMELINE_EVENTSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_POSTMORTEM_TIMELINE_EVENTS (TIMELINE_EVENT_ID STRING PRIMARY KEY,POSTMORTEM_ID STRING,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,EVENT_TS TIMESTAMP_LTZ,TITLE STRING,DESCRIPTION VARIANT,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_MAJOR_INCIDENT_DECLARATIONSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_MAJOR_INCIDENT_DECLARATIONS (DECLARATION_ID STRING PRIMARY KEY,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,DECLARED_BY STRING,DECLARED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),SEVERITY STRING,DETAILS VARIANT) DOCGEN.FEATURE_INSTANCE_MAJOR_INCIDENT_COMMUNICATIONSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_MAJOR_INCIDENT_COMMUNICATIONS (COMM_ID STRING PRIMARY KEY,DECLARATION_ID STRING,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,CHANNEL STRING, -- 'EMAIL','SLACK','STATUS_PAGE'PAYLOAD VARIANT,SENT_AT TIMESTAMP_LTZ,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.FEATURE_INSTANCE_INCIDENT_COST_ESTIMATESCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_INCIDENT_COST_ESTIMATES (ESTIMATE_ID STRING PRIMARY KEY,INCIDENT_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,ESTIMATED_COST NUMBER(18,6),CURRENCY STRING DEFAULT 'USD',ESTIMATED_BY STRING,ESTIMATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),DETAILS VARIANT) DOCGEN.FEATURE_INSTANCE_SUPPORT_TICKET_LINKSCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_SUPPORT_TICKET_LINKS (LINK_ID STRING PRIMARY KEY,INCIDENT_ID STRING,SUPPORT_TICKET_ID STRING,INSTANCE_REF STRING,FEATURE_KEY STRING,ORG_ID STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),METADATA VARIANT) DOCGEN.FEATURE_INSTANCE_POSTMORTEM_TEMPLATESCREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_POSTMORTEM_TEMPLATES (TEMPLATE_ID STRING PRIMARY KEY,ORG_ID STRING,NAME STRING,TEMPLATE_BODY VARIANT,CREATED_BY STRING,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()) DOCGEN.RATE_RULE_TEMPLATESCREATE OR REPLACE TABLE DOCGEN.RATE_RULE_TEMPLATES (TEMPLATE_ID STRING PRIMARY KEY,NAME STRING,DESCRIPTION STRING,CONFIG_SAMPLE VARIANT,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
) Below are the first 20 consolidated CREATE OR REPLACE TABLE artifacts (numbered 100–119) merged from the provided documents. Each artifact below is the consolidated TABLE DDL AS extracted from the materials;


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_POSTMORTEMS (
    POSTMORTEM_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    SUMMARY VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_REMEDIATION_PLANS (
    PLAN_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    PLAN VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_SECURITY_FINDINGS (
    FINDING_ID STRING PRIMARY KEY,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    SEVERITY STRING,
    DETAILS VARIANT,
    DETECTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.FEATURE_INSTANCE_SLA_VIOLATIONS (
    VIOLATION_ID STRING PRIMARY KEY,
    INCIDENT_ID STRING,
    INSTANCE_REF STRING,
    FEATURE_KEY STRING,
    ORG_ID STRING,
    SLA_KEY STRING,
    DETAILS VARIANT,
    VIOLATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.OCREXTRACTIONINDEX6041 (
    EXID STRING PRIMARY KEY,
    DOCUMENTID STRING,
    OCRJSON VARIANT,
    EXTRACTEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.OCRLOGS6042 (
    LOGID STRING PRIMARY KEY,
    EXID STRING,
    ENTRY VARIANT,
    LOGGEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.OCSP_RESPONSES (
    OCSP_ID STRING PRIMARY KEY,
    CERT_ID STRING,
    CERT_FINGERPRINT STRING,
    BUNDLE_ID STRING,
    REQUEST_ID STRING,
    OCSP_RAW VARIANT,
    OCSP_STATUS STRING,
    CHECKED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PDFASSEMBLYREGISTRY6040 (
    ASSEMBLYID STRING PRIMARY KEY,
    DOCUMENTID STRING,
    LOCATION STRING,
    CREATEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PREVIEWCACHELOGS6036 (
    LOGID STRING PRIMARY KEY,
    CACHEID STRING,
    ENTRY VARIANT,
    LOGGEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PROVENANCE_ANCHORS (
    ANCHOR_ID STRING PRIMARY KEY,
    BUNDLE_ID STRING,
    ANCHOR_PROVIDER STRING,
    ANCHOR_PROOF VARIANT,
    ANCHORED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PROVENANCE_AUDIT (
    AUDIT_ID STRING PRIMARY KEY,
    PROV_ID STRING,
    ACTION STRING,
    ACTOR STRING,
    DETAILS VARIANT,
    ACTION_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PROVENANCE_CHAIN (
    PROV_ID STRING PRIMARY KEY,
    BUNDLE_ID STRING,
    PREV_HASH STRING,
    ANCHOR_TXID STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PROVENANCE_EDGES (
    EDGE_ID STRING PRIMARY KEY,
    FROM_NODE STRING,
    TO_NODE STRING,
    RELATION STRING,
    METADATA VARIANT,
    RECORDED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PROVENANCE_NODES (
    NODE_ID STRING PRIMARY KEY,
    ENTITY_TYPE STRING,
    ENTITY_REF STRING,
    METADATA VARIANT,
    RECORDED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PROVIDER_CONFIGURATION (
    CONFIG_ID STRING PRIMARY KEY,
    PROVIDER_NAME STRING,
    REGION STRING,
    ENDPOINT_URL STRING,
    AUTH_METHOD STRING,
    CONFIG VARIANT,
    UPDATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.PROVIDER_CREDENTIALS (
    CRED_ID STRING PRIMARY KEY,
    PROVIDER_NAME STRING,
    PROVIDER_TYPE STRING,
    CONFIG VARIANT,
    EXTERNAL_SECRET_REF STRING,
    LAST_ROTATED_AT TIMESTAMP_LTZ,
    ACTIVE BOOLEAN DEFAULT TRUE,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.RENDERERRORLOGS6039 (
    LOGID STRING PRIMARY KEY,
    REQID STRING,
    ERRORJSON VARIANT,
    LOGGEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.RENDERREQUESTQUEUE6037 (
    REQID STRING PRIMARY KEY,
    DOCUMENTID STRING,
    STATUS STRING DEFAULT 'PENDING',
    ENQUEUEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.RENDERRESULTINDEX6038 (
    RESID STRING PRIMARY KEY,
    REQID STRING,
    RENDERJSON VARIANT,
    RENDEREDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.SIGNATURE_CERTIFICATES (
    CERT_ID STRING PRIMARY KEY,
    BUNDLE_ID STRING,
    REQUEST_ID STRING,
    SIGNER_ID STRING,
    CERT_PEM CLOB,
    CERT_FINGERPRINT STRING,
    SUBJECT VARIANT,
    ISSUER VARIANT,
    SERIAL_NUMBER STRING,
    NOT_BEFORE TIMESTAMP_LTZ,
    NOT_AFTER TIMESTAMP_LTZ,
    RAW_CHAIN VARIANT,
    STORED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.SIGNATURE_EVENTS (
    EVENT_ID STRING PRIMARY KEY,
    REQUEST_ID STRING,
    BUNDLE_ID STRING,
    DOCUMENT_ID STRING,
    SIGNER_ID STRING,
    ACCOUNT_ID STRING,
    EVENT_TYPE STRING,
    EVENT_PAYLOAD VARIANT,
    EVENT_TS TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,DEVICE_INFO VARIANT,IP_ADDR STRING,USER_AGENT STRING,INSERTED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE DOCGEN.SIGNATURE_EVIDENCE_BUNDLE (
    BUNDLE_ID STRING PRIMARY KEY,
    REQUEST_ID STRING,
    DOCUMENT_ID STRING,
    ACCOUNT_ID STRING,
    ARCHIVE_URL STRING,
    BUNDLE_URL STRING,
    MANIFEST VARIANT,
    META VARIANT,
    CERT_CHAIN VARIANT,
    OCSP_SNAPSHOTS VARIANT,
    PROVENANCE_HASH STRING,
    PROVENANCE_MANIFEST VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.SIGNATURE_HASHES (
    HASH_ID STRING PRIMARY KEY,
    BUNDLE_ID STRING,
    HASH_VALUE STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.SIGNATURE_IMAGES (
    IMAGE_ID STRING PRIMARY KEY,
    BUNDLE_ID STRING,
    REQUEST_ID STRING,
    SIGNER_ID STRING,
    IMAGE_URL STRING,
    THUMBNAIL_URL STRING,
    MIME_TYPE STRING,
    SIZE_BYTES NUMBER,
    METADATA VARIANT,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.SIGNATURE_REQUESTS (
    REQUEST_ID STRING PRIMARY KEY,
    ACCOUNT_ID STRING,
    DOCUMENT_ID STRING,
    TEMPLATE_ID STRING,
    CREATED_BY STRING,
    STATUS STRING,
    REQUIRED_AUTH_LEVEL STRING,
    POLICY_ID STRING,
    REQUEST_HASH STRING,
    METADATA VARIANT,
    EXPIRES_AT TIMESTAMP_LTZ,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,UPDATED_AT TIMESTAMP_LTZ);


CREATE OR REPLACE TABLE DOCGEN.SIGNATURE_VERIFICATIONS (
    VERIFY_ID STRING PRIMARY KEY,
    REQUEST_ID STRING,
    BUNDLE_ID STRING,
    SIGNER_ID STRING,
    VERIFIED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,METHOD STRING,RESULT STRING,VERIFICATION_HASH STRING,DETAILS VARIANT,OCSP_STATUS VARIANT,CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP());


CREATE OR REPLACE TABLE DOCGEN.SIGNERS (
    SIGNER_ID STRING PRIMARY KEY,
    REQUEST_ID STRING,
    ACCOUNT_ID STRING,
    SIGNER_EMAIL STRING,
    SIGNER_NAME STRING,
    SIGNER_ORDER NUMBER,
    AUTH_METHOD STRING,
    ROLE STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) ,META VARIANT);


CREATE OR REPLACE TABLE DOCGEN.SIGNER_SESSIONS (
    SESSION_ID STRING PRIMARY KEY,
    SIGNER_ID STRING,
    REQUEST_ID STRING,
    SESSION_TOKEN STRING,
    CONTEXT VARIANT,
    META VARIANT,
    STARTED_AT TIMESTAMP_LTZ,
    ENDED_AT TIMESTAMP_LTZ,
    EXPIRES_AT TIMESTAMP_LTZ,
    IP_ADDRESS STRING,
    USER_AGENT STRING,
    CREATED_AT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.TEMPLATEEDITAUDIT6034 (
    AUDITID STRING PRIMARY KEY,
    TEMPLATEID STRING,
    EDITOR STRING,
    CHANGES VARIANT,
    EDITEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.TEMPLATEPREVIEWCACHE6035 (
    CACHEID STRING PRIMARY KEY,
    TEMPLATEID STRING,
    PREVIEWURL STRING,
    CREATEDAT TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );


CREATE OR REPLACE TABLE DOCGEN.TRANSLATIONJOBS6047 (
    JOBID STRING PRIMARY KEY,
    DOCUMENTID STRING,
    TARGETLANG STRING,
    STATUS STRING,
    STARTEDAT TIMESTAMP_LTZ,
    ENDEDAT TIMESTAMP_LTZ
);


CREATE OR REPLACE TABLE statements. Each artifact includes the original citation (
    s) from the intermediate analyses that contributed to that consolidated version. I will proceed in groups of 20 as requested. AI_FEATURE_HUB.docgen_feature_instance_postmortem_notificationsCREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_feature_instance_postmortem_notifications ( id STRING PRIMARY KEY, parent_id STRING, incident_id STRING, instance_ref STRING, feature_key STRING, org_id STRING, payload VARIANT, created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(
) );
