CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6010_upsert_feature_instance_model_rollback_policy_6009(
  policy_id STRING,
  model_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  policy_spec VARIANT,
  active BOOLEAN
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6009_feature_instance_model_rollback_policies_6009 tgt
USING (SELECT :policy_id AS policy_id) src
ON tgt.policy_id = src.policy_id
WHEN MATCHED THEN UPDATE SET model_id = :model_id, instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, policy_spec = :policy_spec, active = :active, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(policy_id, model_id, instance_ref, feature_key, org_id, policy_spec, active, created_at)
VALUES(:policy_id, :model_id, :instance_ref, :feature_key, :org_id, :policy_spec, :active, CURRENT_TIMESTAMP());
RETURN :policy_id;
$$;