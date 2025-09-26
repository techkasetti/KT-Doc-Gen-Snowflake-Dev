CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5985_feature_instance_comms_templates_5985 (
  template_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  template VARIANT,
  channel STRING,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);