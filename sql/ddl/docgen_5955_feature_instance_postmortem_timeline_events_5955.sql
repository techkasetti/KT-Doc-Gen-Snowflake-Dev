CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5955_feature_instance_postmortem_timeline_events_5955 (
  event_id STRING PRIMARY KEY,
  review_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  event_time TIMESTAMP_LTZ,
  event_payload VARIANT,
  recorded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);