CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6111_feature_instance_incident_notification_templates_6111 (
  template_id STRING PRIMARY KEY,
  config_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  channel STRING,
  template VARIANT,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);