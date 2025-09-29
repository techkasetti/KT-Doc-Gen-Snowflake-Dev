CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6081_feature_instance_incident_documentation_refs_6081 (
  doc_ref_id STRING PRIMARY KEY,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  url STRING,
  description STRING,
  added_by STRING,
  added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);