CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6047_feature_instance_dashboard_views_6047 (
  view_id STRING PRIMARY KEY,
  dashboard_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  viewer STRING,
  viewed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);