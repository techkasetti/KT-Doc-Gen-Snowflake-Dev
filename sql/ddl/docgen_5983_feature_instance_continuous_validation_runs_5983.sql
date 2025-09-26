CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5983_feature_instance_continuous_validation_runs_5983 (
  run_id STRING PRIMARY KEY,
  config_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  run_result VARIANT,
  started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  finished_at TIMESTAMP_LTZ,
  status STRING
);