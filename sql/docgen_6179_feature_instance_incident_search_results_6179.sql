CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6179_feature_instance_incident_search_results_6179 (
  result_id STRING PRIMARY KEY,
  query_id STRING,
  user_ref STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  results VARIANT,
  returned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);