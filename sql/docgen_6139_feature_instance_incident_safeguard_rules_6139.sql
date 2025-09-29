CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6139_feature_instance_incident_safeguard_rules_6139 (
  rule_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  rule_spec VARIANT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);