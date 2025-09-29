CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6119_feature_instance_incident_feedback_results_6119 (
  result_id STRING PRIMARY KEY,
  survey_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  aggregated VARIANT,
  computed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);