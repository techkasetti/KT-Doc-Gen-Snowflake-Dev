CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5961_feature_instance_incident_cost_estimates_5961 (
  estimate_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  estimate_spec VARIANT,
  estimated_by STRING,
  estimated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);