CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6072_record_feature_instance_sla_breach_notification_6071(
  notif_id STRING,
  sla_id STRING,
  breach_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  recipients ARRAY,
  payload VARIANT,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6071_feature_instance_sla_breach_notifications_6071(notif_id, sla_id, breach_id, instance_ref, feature_key, org_id, recipients, payload, sent_at, status)
VALUES(:notif_id, :sla_id, :breach_id, :instance_ref, :feature_key, :org_id, :recipients, :payload, CURRENT_TIMESTAMP(), :status);
RETURN :notif_id;
$$;