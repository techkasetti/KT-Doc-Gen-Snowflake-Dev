CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6153_feature_instance_incident_versions_6153 (
  version_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  snapshot VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);