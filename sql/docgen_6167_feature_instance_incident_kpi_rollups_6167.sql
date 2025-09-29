CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6167_feature_instance_incident_kpi_rollups_6167 (
  rollup_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  rollup_spec VARIANT,
  rollup_result VARIANT,
  computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);