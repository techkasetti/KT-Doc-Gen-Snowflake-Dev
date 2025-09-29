CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6113_feature_instance_incident_notification_sends_6113 (
  send_id STRING PRIMARY KEY,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  recipients ARRAY,
  payload VARIANT,
  sent_by STRING,
  sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING
);