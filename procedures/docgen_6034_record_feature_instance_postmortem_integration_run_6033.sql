CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6034_record_feature_instance_postmortem_integration_run_6033(
  run_id STRING,
  integration_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  payload VARIANT,
  status STRING,
  result VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6033_feature_instance_incident_postmortem_integration_runs_6033(run_id, integration_id, review_id, instance_ref, feature_key, org_id, payload, executed_at, status, result)
VALUES(:run_id, :integration_id, :review_id, :instance_ref, :feature_key, :org_id, :payload, CURRENT_TIMESTAMP(), :status, :result);
RETURN :run_id;
$$;