CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6057_feature_instance_postmortem_metrics_alerts_6057 (
  alert_id STRING PRIMARY KEY,
  metric_key STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  observed_value NUMBER,
  threshold NUMBER,
  severity STRING,
  detected_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  metadata VARIANT
);