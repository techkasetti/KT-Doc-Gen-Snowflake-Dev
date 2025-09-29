CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6115_feature_instance_incident_feedback_surveys_6115 (
  survey_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  survey_spec VARIANT,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);