CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6125_feature_instance_investigation_checklist_progress_6125 (
  progress_id STRING PRIMARY KEY,
  checklist_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  step_id STRING,
  completed BOOLEAN,
  completed_by STRING,
  completed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  notes VARIANT
);