CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5959_feature_instance_major_incident_communications_5959 (
  comm_id STRING PRIMARY KEY,
  declaration_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  channel STRING,
  message VARIANT,
  sent_by STRING,
  sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING
);