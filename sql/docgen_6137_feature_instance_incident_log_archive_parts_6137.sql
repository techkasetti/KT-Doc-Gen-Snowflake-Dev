CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6137_feature_instance_incident_log_archive_parts_6137 (
  part_id STRING PRIMARY KEY,
  archive_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  part_url STRING,
  size_bytes NUMBER,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);