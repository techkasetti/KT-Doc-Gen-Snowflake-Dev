CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5971_feature_instance_architecture_diagrams_5971 (
  diagram_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  diagram VARIANT,
  added_by STRING,
  added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);