CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5977_feature_instance_testing_runs_5977 (
  run_id STRING PRIMARY KEY,
  plan_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  run_payload VARIANT,
  started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  finished_at TIMESTAMP_LTZ,
  status STRING
);