CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5981_feature_instance_continuous_validation_configs_5981 (
  config_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  validation_spec VARIANT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);