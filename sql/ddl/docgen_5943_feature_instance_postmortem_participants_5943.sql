CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5943_feature_instance_postmortem_participants_5943 (
  participant_id STRING PRIMARY KEY,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  participant STRING,
  role STRING,
  added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);