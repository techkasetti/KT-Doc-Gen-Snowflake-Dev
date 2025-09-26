CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5987_feature_instance_comms_template_usages_5987 (
  usage_id STRING PRIMARY KEY,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  payload VARIANT,
  result VARIANT
);