CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6089_feature_instance_incident_notes_6089 (
  note_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  body VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);