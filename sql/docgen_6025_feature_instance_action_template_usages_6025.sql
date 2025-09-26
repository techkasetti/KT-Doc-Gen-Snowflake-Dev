CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6025_feature_instance_action_template_usages_6025 (
  usage_id STRING PRIMARY KEY,
  template_id STRING,
  action_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  used_by STRING,
  used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  context VARIANT
);