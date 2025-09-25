CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5973_feature_instance_architecture_changes_5973 (
  change_id STRING PRIMARY KEY,
  diagram_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  change_summary VARIANT,
  changed_by STRING,
  changed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);