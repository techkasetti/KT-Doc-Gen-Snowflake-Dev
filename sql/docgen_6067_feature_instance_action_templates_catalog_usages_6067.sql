CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6067_feature_instance_action_templates_catalog_usages_6067 (
  usage_id STRING PRIMARY KEY,
  catalog_id STRING,
  template_id STRING,
  action_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  used_by STRING,
  used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);