CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6093_feature_instance_incident_contributors_6093 (
  contributor_id STRING PRIMARY KEY,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  contributor STRING,
  role STRING,
  contributed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);