CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6005_feature_instance_model_artifact_refs_6005 (
  artifact_id STRING PRIMARY KEY,
  model_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  artifact_meta VARIANT,
  stored_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);