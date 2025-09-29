CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6161_feature_instance_incident_archival_logs_6161 (
  log_id STRING PRIMARY KEY,
  job_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  message STRING,
  logged_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);