CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6183_feature_instance_incident_analytics_reports_6183 (
  report_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  report VARIANT,
  generated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);