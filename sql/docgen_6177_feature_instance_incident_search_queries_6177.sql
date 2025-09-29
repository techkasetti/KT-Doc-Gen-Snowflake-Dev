CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6177_feature_instance_incident_search_queries_6177 (
  query_id STRING PRIMARY KEY,
  user_ref STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  query_text STRING,
  executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);