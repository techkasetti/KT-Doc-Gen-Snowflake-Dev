CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5969_feature_instance_engineering_notes_5969 (
  note_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  body VARIANT,
  author STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);