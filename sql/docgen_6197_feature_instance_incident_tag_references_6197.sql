CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6197_feature_instance_incident_tag_references_6197 (
  ref_id STRING PRIMARY KEY,
  incident_id STRING,
  tag STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  added_by STRING,
  added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);