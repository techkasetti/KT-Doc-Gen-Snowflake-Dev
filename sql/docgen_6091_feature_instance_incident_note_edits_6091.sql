CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6091_feature_instance_incident_note_edits_6091 (
  edit_id STRING PRIMARY KEY,
  note_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  edited_by STRING,
  previous_body VARIANT,
  new_body VARIANT,
  edited_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);