CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6022_create_feature_instance_restore_job_6021(
  restore_job_id STRING,
  backup_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  initiated_by STRING,
  status STRING,
  finished_at TIMESTAMP_LTZ,
  details VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6021_feature_instance_restore_jobs_6021(restore_job_id, backup_id, instance_ref, feature_key, org_id, initiated_by, initiated_at, finished_at, status, details)
VALUES(:restore_job_id, :backup_id, :instance_ref, :feature_key, :org_id, :initiated_by, CURRENT_TIMESTAMP(), :finished_at, :status, :details);
RETURN :restore_job_id;
$$;