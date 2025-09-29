CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6051_feature_instance_kpi_reports_6051 (
  report_id STRING PRIMARY KEY,
  template_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  report_payload VARIANT,
  generated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);