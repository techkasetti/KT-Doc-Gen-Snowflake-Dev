CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6157_feature_instance_incident_archival_policies_6157 (
  policy_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  policy_spec VARIANT,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);