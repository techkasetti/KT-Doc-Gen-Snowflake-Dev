CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6009_feature_instance_model_rollback_policies_6009 (
  policy_id STRING PRIMARY KEY,
  model_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  policy_spec VARIANT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);