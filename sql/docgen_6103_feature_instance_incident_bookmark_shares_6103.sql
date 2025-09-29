CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6103_feature_instance_incident_bookmark_shares_6103 (
  share_id STRING PRIMARY KEY,
  bookmark_id STRING,
  incident_id STRING,
  shared_by STRING,
  shared_with ARRAY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  shared_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);