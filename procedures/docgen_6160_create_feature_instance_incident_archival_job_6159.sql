CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6160_create_feature_instance_incident_archival_job_6159(
  job_id STRING,
  policy_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  initiated_by STRING,
  status STRING,
  finished_at TIMESTAMP_LTZ,
  archive_url STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6159_feature_instance_incident_archival_jobs_6159(job_id, policy_id, incident_id, instance_ref, feature_key, org_id, initiated_by, initiated_at, finished_at, status, archive_url)
VALUES(:job_id, :policy_id, :incident_id, :instance_ref, :feature_key, :org_id, :initiated_by, CURRENT_TIMESTAMP(), :finished_at, :status, :archive_url);
RETURN :job_id;
$$;