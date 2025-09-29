CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6073_feature_instance_sla_breach_responses_6073 (
  response_id STRING PRIMARY KEY,
  breach_id STRING,
  sla_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  responder STRING,
  response VARIANT,
  responded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);