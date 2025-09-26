CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6013_feature_instance_compliance_check_configs_6013 (
  check_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  check_spec VARIANT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);