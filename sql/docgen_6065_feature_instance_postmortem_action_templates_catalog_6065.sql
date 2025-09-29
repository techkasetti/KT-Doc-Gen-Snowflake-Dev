CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6065_feature_instance_postmortem_action_templates_catalog_6065 (
  catalog_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  templates VARIANT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);