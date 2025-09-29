CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6151_feature_instance_collaboration_reactions_6151 (
  reaction_id STRING PRIMARY KEY,
  post_id STRING,
  thread_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  actor STRING,
  reaction STRING,
  reacted_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);