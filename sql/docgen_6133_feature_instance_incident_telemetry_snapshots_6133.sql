CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6133_feature_instance_incident_telemetry_snapshots_6133 (
  snapshot_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  telemetry VARIANT,
  captured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);