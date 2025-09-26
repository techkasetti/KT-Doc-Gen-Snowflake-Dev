CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5995_feature_instance_release_checklists_5995 (
  checklist_id STRING PRIMARY KEY,
  release_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  items VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);