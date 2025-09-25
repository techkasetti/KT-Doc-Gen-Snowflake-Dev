CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5949_feature_instance_postmortem_action_priorities_5949 (
  priority_id STRING PRIMARY KEY,
  action_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  priority_level STRING,
  set_by STRING,
  set_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);