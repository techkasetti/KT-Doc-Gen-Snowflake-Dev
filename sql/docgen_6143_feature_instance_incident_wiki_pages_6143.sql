CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6143_feature_instance_incident_wiki_pages_6143 (
  page_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  content VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  updated_at TIMESTAMP_LTZ
);