CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6163_feature_instance_incident_retention_events_6163 (
  event_id STRING PRIMARY KEY,
  incident_id STRING,
  policy_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  action STRING,
  executed_by STRING,
  executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  details VARIANT
);