CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6187_feature_instance_incident_reporting_send_logs_6187 (
  log_id STRING PRIMARY KEY,
  report_id STRING,
  subscriber_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  payload VARIANT,
  sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING
);