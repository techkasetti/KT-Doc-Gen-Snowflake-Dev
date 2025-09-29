CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6055_feature_instance_incident_playbook_runs_6055 (
  run_id STRING PRIMARY KEY,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  payload VARIANT,
  result VARIANT
);