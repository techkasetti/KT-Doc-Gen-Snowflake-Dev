CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6049_feature_instance_kpi_report_templates_6049 (
  template_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  spec VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);