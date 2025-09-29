CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6205_feature_instance_incident_oncall_notifications_6205 (
  notif_id STRING PRIMARY KEY,
  mapping_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  channel STRING,
  payload VARIANT,
  sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING
);