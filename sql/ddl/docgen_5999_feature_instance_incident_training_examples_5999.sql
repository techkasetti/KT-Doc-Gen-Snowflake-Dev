CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5999_feature_instance_incident_training_examples_5999 (
  example_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  input VARIANT,
  label VARIANT,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);