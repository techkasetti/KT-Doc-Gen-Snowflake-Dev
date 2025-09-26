CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6012_record_feature_instance_model_rollback_execution_6011(
  execution_id STRING,
  policy_id STRING,
  model_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  result VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6011_feature_instance_model_rollback_executions_6011(execution_id, policy_id, model_id, instance_ref, feature_key, org_id, executed_by, executed_at, result)
VALUES(:execution_id, :policy_id, :model_id, :instance_ref, :feature_key, :org_id, :executed_by, CURRENT_TIMESTAMP(), :result);
RETURN :execution_id;
$$;