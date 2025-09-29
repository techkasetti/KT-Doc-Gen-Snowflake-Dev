CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6097_feature_instance_postmortem_dashboards_6097 (
  dashboard_id STRING PRIMARY KEY,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  spec VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);