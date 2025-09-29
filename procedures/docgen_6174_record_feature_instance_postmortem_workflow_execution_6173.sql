CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6174_record_feature_instance_postmortem_workflow_execution_6173(
  execution_id STRING,
  workflow_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  finished_at TIMESTAMP_LTZ,
  status STRING,
  result VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6173_feature_instance_postmortem_workflow_executions_6173(execution_id, workflow_id, review_id, instance_ref, feature_key, org_id, executed_by, started_at, finished_at, status, result)
VALUES(:execution_id, :workflow_id, :review_id, :instance_ref, :feature_key, :org_id, :executed_by, CURRENT_TIMESTAMP(), :finished_at, :status, :result);
RETURN :execution_id;
$$;