CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5957_feature_instance_major_incident_declarations_5957 (
  declaration_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  declared_by STRING,
  declared_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  reason VARIANT
);