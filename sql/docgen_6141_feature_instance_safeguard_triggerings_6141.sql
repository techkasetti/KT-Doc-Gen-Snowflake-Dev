CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6141_feature_instance_safeguard_triggerings_6141 (
  trigger_id STRING PRIMARY KEY,
  rule_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  triggered_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  context VARIANT
);