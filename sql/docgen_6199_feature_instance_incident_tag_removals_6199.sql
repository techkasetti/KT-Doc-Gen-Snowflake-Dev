CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6199_feature_instance_incident_tag_removals_6199 (
  removal_id STRING PRIMARY KEY,
  ref_id STRING,
  incident_id STRING,
  tag STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  removed_by STRING,
  removed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);