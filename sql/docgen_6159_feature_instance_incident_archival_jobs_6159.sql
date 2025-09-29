CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6159_feature_instance_incident_archival_jobs_6159 (
  job_id STRING PRIMARY KEY,
  policy_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  initiated_by STRING,
  initiated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  finished_at TIMESTAMP_LTZ,
  status STRING,
  archive_url STRING
);