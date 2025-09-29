CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6083_feature_instance_incident_checklist_templates_6083 (
  template_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  items VARIANT,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);