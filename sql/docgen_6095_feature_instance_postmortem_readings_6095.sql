CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6095_feature_instance_postmortem_readings_6095 (
  reading_id STRING PRIMARY KEY,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  type STRING,
  payload VARIANT,
  recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);