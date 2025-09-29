CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6149_feature_instance_collaboration_posts_6149 (
  post_id STRING PRIMARY KEY,
  thread_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  author STRING,
  body VARIANT,
  posted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);