CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5947_feature_instance_incident_metric_samples_5947 (
  sample_id STRING PRIMARY KEY,
  metric_def_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  metric_key STRING,
  metric_value NUMBER,
  collected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);