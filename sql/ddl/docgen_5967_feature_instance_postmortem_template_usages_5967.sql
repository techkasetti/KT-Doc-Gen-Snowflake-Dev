CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5967_feature_instance_postmortem_template_usages_5967 (
  usage_id STRING PRIMARY KEY,
  template_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  used_by STRING,
  used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  context VARIANT
);