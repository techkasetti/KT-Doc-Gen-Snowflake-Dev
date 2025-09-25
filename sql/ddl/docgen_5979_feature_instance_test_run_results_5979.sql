CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5979_feature_instance_test_run_results_5979 (
  result_id STRING PRIMARY KEY,
  run_id STRING,
  test_case STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  outcome STRING,
  details VARIANT,
  recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);