CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6037_feature_instance_incident_tag_template_usages_6037 (
  usage_id STRING PRIMARY KEY,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  used_by STRING,
  used_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);