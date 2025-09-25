CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5965_feature_instance_postmortem_templates_5965 (
  template_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  template VARIANT,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);