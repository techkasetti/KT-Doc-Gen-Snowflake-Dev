CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6041_feature_instance_incident_learning_item_updates_6041 (
  update_id STRING PRIMARY KEY,
  item_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  updated_by STRING,
  update_notes VARIANT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  new_status STRING
);