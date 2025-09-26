CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6011_feature_instance_model_rollback_executions_6011 (
  execution_id STRING PRIMARY KEY,
  policy_id STRING,
  model_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  result VARIANT
);