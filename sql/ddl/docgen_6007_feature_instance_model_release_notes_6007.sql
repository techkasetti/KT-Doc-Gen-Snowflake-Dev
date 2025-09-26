CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6007_feature_instance_model_release_notes_6007 (
  note_id STRING PRIMARY KEY,
  model_id STRING,
  version STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  body VARIANT,
  released_by STRING,
  released_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);