CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6021_feature_instance_restore_jobs_6021 (
  restore_job_id STRING PRIMARY KEY,
  backup_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  initiated_by STRING,
  initiated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  finished_at TIMESTAMP_LTZ,
  status STRING,
  details VARIANT
); 