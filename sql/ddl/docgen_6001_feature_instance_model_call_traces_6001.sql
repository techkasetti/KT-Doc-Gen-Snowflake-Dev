CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6001_feature_instance_model_call_traces_6001 (
  trace_id STRING PRIMARY KEY,
  model_call_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  request VARIANT,
  response VARIANT,
  duration_ms NUMBER,
  called_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);