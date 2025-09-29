CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6206_record_feature_instance_incident_oncall_notification_6205(
  notif_id STRING,
  mapping_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  channel STRING,
  payload VARIANT,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6205_feature_instance_incident_oncall_notifications_6205(notif_id, mapping_id, incident_id, instance_ref, feature_key, org_id, channel, payload, sent_at, status)
VALUES(:notif_id, :mapping_id, :incident_id, :instance_ref, :feature_key, :org_id, :channel, :payload, CURRENT_TIMESTAMP(), :status);
RETURN :notif_id;
$$;