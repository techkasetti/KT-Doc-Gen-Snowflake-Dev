CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6207_feature_instance_incident_resolution_templates_6207 (
  template_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  template VARIANT,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);