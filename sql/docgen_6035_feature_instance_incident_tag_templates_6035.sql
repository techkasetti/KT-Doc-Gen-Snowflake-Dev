CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6035_feature_instance_incident_tag_templates_6035 (
  template_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  tags ARRAY,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);