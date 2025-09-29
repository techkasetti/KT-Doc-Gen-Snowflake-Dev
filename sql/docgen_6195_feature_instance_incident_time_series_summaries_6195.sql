CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6195_feature_instance_incident_time_series_summaries_6195 (
  summary_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  series VARIANT,
  computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);