CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5945_feature_instance_incident_metrics_definitions_5945 (
  metric_def_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  metric_key STRING,
  metric_def VARIANT,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);