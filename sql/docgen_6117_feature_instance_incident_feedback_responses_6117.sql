CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6117_feature_instance_incident_feedback_responses_6117 (
  response_id STRING PRIMARY KEY,
  survey_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  respondent STRING,
  answers VARIANT,
  responded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);