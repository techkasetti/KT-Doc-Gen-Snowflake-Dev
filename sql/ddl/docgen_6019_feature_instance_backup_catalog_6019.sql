CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6019_feature_instance_backup_catalog_6019 (
  backup_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  backup_spec VARIANT,
  stored_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);