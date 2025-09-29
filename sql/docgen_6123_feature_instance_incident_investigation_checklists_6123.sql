CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6123_feature_instance_incident_investigation_checklists_6123 (
  checklist_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  items VARIANT,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);