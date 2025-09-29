CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6079_feature_instance_resilience_test_alerts_6079 (
  alert_id STRING PRIMARY KEY,
  run_id STRING,
  test_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  alert_spec VARIANT,
  triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);