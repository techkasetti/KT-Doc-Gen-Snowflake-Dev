CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6077_feature_instance_resilience_test_runs_6077 (
  run_id STRING PRIMARY KEY,
  test_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  run_payload VARIANT,
  started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  finished_at TIMESTAMP_LTZ,
  status STRING,
  result VARIANT
);