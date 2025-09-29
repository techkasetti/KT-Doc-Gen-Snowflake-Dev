CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6131_feature_instance_incident_pixel_tracking_6131 (
  tracking_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  pixel_context VARIANT,
  recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);