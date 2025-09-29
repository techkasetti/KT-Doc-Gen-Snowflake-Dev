CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6069_feature_instance_sla_contracts_6069 (
  sla_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  sla_spec VARIANT,
  effective_from TIMESTAMP_LTZ,
  effective_to TIMESTAMP_LTZ,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);