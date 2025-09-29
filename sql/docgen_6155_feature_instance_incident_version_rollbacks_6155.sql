CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6155_feature_instance_incident_version_rollbacks_6155 (
  rollback_id STRING PRIMARY KEY,
  version_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  rolled_back_by STRING,
  rolled_back_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  notes VARIANT
);