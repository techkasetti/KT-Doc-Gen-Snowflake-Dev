CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5993_feature_instance_incident_summary_views_5993 (
  view_id STRING PRIMARY KEY,
  summary_id STRING,
  viewer STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  viewed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);