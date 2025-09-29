CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6118_record_feature_instance_incident_feedback_response_6117(
  response_id STRING,
  survey_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  respondent STRING,
  answers VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6117_feature_instance_incident_feedback_responses_6117(response_id, survey_id, incident_id, instance_ref, feature_key, org_id, respondent, answers, responded_at)
VALUES(:response_id, :survey_id, :incident_id, :instance_ref, :feature_key, :org_id, :respondent, :answers, CURRENT_TIMESTAMP());
RETURN :response_id;
$$;