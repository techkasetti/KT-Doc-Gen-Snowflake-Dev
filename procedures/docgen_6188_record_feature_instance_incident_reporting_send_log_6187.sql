CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6188_record_feature_instance_incident_reporting_send_log_6187(
  log_id STRING,
  report_id STRING,
  subscriber_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  payload VARIANT,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6187_feature_instance_incident_reporting_send_logs_6187(log_id, report_id, subscriber_id, instance_ref, feature_key, org_id, payload, sent_at, status)
VALUES(:log_id, :report_id, :subscriber_id, :instance_ref, :feature_key, :org_id, :payload, CURRENT_TIMESTAMP(), :status);
RETURN :log_id;
$$;