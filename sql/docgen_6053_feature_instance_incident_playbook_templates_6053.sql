CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6053_feature_instance_incident_playbook_templates_6053 (
  template_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  template VARIANT,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);