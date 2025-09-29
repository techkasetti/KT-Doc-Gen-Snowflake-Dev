CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6075_feature_instance_service_resilience_tests_6075 (
  test_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  test_spec VARIANT,
  frequency STRING,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);