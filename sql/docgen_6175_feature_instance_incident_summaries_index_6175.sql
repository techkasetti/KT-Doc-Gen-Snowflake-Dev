CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6175_feature_instance_incident_summaries_index_6175 (
  index_id STRING PRIMARY KEY,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  search_text STRING,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);