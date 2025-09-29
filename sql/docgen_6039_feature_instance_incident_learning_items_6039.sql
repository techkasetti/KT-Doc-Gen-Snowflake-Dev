CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6039_feature_instance_incident_learning_items_6039 (
  item_id STRING PRIMARY KEY,
  review_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  description VARIANT,
  owner STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING
);