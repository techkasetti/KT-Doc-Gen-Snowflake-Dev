CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6059_feature_instance_incident_ownership_hist_6059 (
  hist_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  owner STRING,
  assigned_by STRING,
  assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  notes VARIANT
);