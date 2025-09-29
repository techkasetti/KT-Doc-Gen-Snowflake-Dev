CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6114_record_feature_instance_incident_notification_send_6113(
  send_id STRING,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  recipients ARRAY,
  payload VARIANT,
  sent_by STRING,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6113_feature_instance_incident_notification_sends_6113(send_id, template_id, incident_id, instance_ref, feature_key, org_id, recipients, payload, sent_by, sent_at, status)
VALUES(:send_id, :template_id, :incident_id, :instance_ref, :feature_key, :org_id, :recipients, :payload, :sent_by, CURRENT_TIMESTAMP(), :status);
RETURN :send_id;
$$;