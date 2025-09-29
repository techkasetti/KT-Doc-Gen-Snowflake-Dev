CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6087_feature_instance_incident_checklist_completions_6087 (
  completion_id STRING PRIMARY KEY,
  instance_id STRING,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  completed_by STRING,
  completed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  results VARIANT
);