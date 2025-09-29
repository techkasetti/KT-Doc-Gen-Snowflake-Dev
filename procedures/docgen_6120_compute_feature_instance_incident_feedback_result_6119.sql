CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6120_compute_feature_instance_incident_feedback_result_6119(
  result_id STRING,
  survey_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  aggregated VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6119_feature_instance_incident_feedback_results_6119(result_id, survey_id, instance_ref, feature_key, org_id, aggregated, computed_at)
VALUES(:result_id, :survey_id, :instance_ref, :feature_key, :org_id, :aggregated, CURRENT_TIMESTAMP());
RETURN :result_id;
$$;