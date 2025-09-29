CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6201_feature_instance_incident_tag_analytics_6201 (
  analytics_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  tag_metrics VARIANT,
  computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);