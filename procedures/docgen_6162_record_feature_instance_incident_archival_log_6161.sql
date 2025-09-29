CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6162_record_feature_instance_incident_archival_log_6161(
  log_id STRING,
  job_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  message STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6161_feature_instance_incident_archival_logs_6161(log_id, job_id, incident_id, instance_ref, feature_key, org_id, message, logged_at)
VALUES(:log_id, :job_id, :incident_id, :instance_ref, :feature_key, :org_id, :message, CURRENT_TIMESTAMP());
RETURN :log_id;
$$;