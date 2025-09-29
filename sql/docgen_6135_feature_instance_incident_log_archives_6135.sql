CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6135_feature_instance_incident_log_archives_6135 (
  archive_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  archive_url STRING,
  size_bytes NUMBER,
  archived_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);