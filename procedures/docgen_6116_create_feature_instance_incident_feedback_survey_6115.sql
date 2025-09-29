CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6116_create_feature_instance_incident_feedback_survey_6115(
  survey_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  survey_spec VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6115_feature_instance_incident_feedback_surveys_6115(survey_id, incident_id, instance_ref, feature_key, org_id, survey_spec, created_at)
VALUES(:survey_id, :incident_id, :instance_ref, :feature_key, :org_id, :survey_spec, CURRENT_TIMESTAMP());
RETURN :survey_id;
$$;