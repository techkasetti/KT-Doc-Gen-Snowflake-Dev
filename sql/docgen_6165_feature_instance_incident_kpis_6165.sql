CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6165_feature_instance_incident_kpis_6165 (
  kpi_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  kpi_key STRING,
  kpi_value NUMBER,
  recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);