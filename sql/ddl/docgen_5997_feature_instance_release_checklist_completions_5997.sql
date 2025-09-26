CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5997_feature_instance_release_checklist_completions_5997 (
  completion_id STRING PRIMARY KEY,
  checklist_id STRING,
  release_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  completed_by STRING,
  completed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  details VARIANT
);