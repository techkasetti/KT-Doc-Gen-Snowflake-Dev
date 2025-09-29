CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6191_feature_instance_issue_templates_6191 (
  template_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  template VARIANT,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);