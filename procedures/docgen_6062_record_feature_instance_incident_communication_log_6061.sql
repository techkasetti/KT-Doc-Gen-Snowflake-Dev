CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6062_record_feature_instance_incident_communication_log_6061(
  comm_log_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  channel STRING,
  recipients ARRAY,
  payload VARIANT,
  sent_by STRING,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6061_feature_instance_incident_communication_logs_6061(comm_log_id, incident_id, instance_ref, feature_key, org_id, channel, recipients, payload, sent_by, sent_at, status)
VALUES(:comm_log_id, :incident_id, :instance_ref, :feature_key, :org_id, :channel, :recipients, :payload, :sent_by, CURRENT_TIMESTAMP(), :status);
RETURN :comm_log_id;
$$;