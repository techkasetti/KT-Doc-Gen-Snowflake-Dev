CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6033_feature_instance_incident_postmortem_integration_runs_6033 (
  run_id STRING PRIMARY KEY,
  integration_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  payload VARIANT,
  executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING,
  result VARIANT
);