CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6063_feature_instance_incident_visibility_controls_6063 (
  control_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  visibility_spec VARIANT,
  set_by STRING,
  set_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);