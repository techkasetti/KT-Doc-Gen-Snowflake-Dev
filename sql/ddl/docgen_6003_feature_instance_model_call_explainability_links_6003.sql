CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6003_feature_instance_model_call_explainability_links_6003 (
  link_id STRING PRIMARY KEY,
  trace_id STRING,
  model_call_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  explainability_ref STRING,
  added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);