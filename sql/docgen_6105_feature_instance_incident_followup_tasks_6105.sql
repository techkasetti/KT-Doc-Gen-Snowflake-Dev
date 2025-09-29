CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6105_feature_instance_incident_followup_tasks_6105 (
  task_id STRING PRIMARY KEY,
  followup_id STRING,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  description STRING,
  owner STRING,
  due_date TIMESTAMP_LTZ,
  status STRING DEFAULT 'OPEN',
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);