CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6045_feature_instance_service_health_dashboards_6045 (
  dashboard_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  spec VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);