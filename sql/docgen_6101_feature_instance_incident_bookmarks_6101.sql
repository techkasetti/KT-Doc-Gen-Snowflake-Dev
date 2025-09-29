CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6101_feature_instance_incident_bookmarks_6101 (
  bookmark_id STRING PRIMARY KEY,
  incident_id STRING,
  user_ref STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  note STRING,
  bookmarked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);