CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6107_feature_instance_incident_followup_task_updates_6107 (
  update_id STRING PRIMARY KEY,
  task_id STRING,
  followup_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  updated_by STRING,
  update_notes VARIANT,
  status STRING,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);