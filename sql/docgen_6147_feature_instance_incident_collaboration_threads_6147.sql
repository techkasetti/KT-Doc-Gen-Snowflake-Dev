CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6147_feature_instance_incident_collaboration_threads_6147 (
  thread_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  subject STRING,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);