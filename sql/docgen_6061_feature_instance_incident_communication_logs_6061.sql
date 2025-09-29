CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6061_feature_instance_incident_communication_logs_6061 (
  comm_log_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  channel STRING,
  recipients ARRAY,
  payload VARIANT,
  sent_by STRING,
  sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING
);