CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6085_feature_instance_incident_checklist_instances_6085 (
  instance_id STRING PRIMARY KEY,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  filled_by STRING,
  filled_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  data VARIANT
);