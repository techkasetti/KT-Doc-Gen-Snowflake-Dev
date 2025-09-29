CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6043_feature_instance_postmortem_retrospectives_6043 (
  retro_id STRING PRIMARY KEY,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  notes VARIANT,
  conducted_by STRING,
  conducted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);