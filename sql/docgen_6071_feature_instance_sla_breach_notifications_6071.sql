CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6071_feature_instance_sla_breach_notifications_6071 (
  notif_id STRING PRIMARY KEY,
  sla_id STRING,
  breach_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  recipients ARRAY,
  payload VARIANT,
  sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING
);