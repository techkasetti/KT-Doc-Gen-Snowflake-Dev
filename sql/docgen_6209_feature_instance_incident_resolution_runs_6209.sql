CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6209_feature_instance_incident_resolution_runs_6209 (
  run_id STRING PRIMARY KEY,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  outcome VARIANT,
  status STRING
);