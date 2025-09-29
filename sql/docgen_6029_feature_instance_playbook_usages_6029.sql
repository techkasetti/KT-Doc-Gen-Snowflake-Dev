CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6029_feature_instance_playbook_usages_6029 (
  usage_id STRING PRIMARY KEY,
  playbook_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  executed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  context VARIANT,
  result VARIANT
);