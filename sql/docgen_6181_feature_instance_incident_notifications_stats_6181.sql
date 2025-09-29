CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6181_feature_instance_incident_notifications_stats_6181 (
  stat_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  sent_count INT,
  failure_count INT,
  computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);