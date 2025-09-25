CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5951_feature_instance_root_cause_analysis_notes_5951 (
  note_id STRING PRIMARY KEY,
  review_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  note VARIANT,
  author STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);