CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6121_feature_instance_incident_configuration_snapshots_6121 (
  snapshot_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  config_snapshot VARIANT,
  captured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);