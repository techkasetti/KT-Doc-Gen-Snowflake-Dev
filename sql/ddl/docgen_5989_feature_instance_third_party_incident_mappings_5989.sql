CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5989_feature_instance_third_party_incident_mappings_5989 (
  mapping_id STRING PRIMARY KEY,
  incident_id STRING,
  external_incident_id STRING,
  provider STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  mapped_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  details VARIANT
);