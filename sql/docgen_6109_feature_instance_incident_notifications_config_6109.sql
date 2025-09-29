CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6109_feature_instance_incident_notifications_config_6109 (
  config_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  config VARIANT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);