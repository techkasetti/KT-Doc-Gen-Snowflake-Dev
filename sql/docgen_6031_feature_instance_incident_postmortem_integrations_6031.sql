CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6031_feature_instance_incident_postmortem_integrations_6031 (
  integration_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  provider STRING,
  config VARIANT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);