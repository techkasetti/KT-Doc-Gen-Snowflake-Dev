CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5976_upsert_feature_instance_testing_plan_5975(
  plan_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  plan_spec VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_5975_feature_instance_testing_plans_5975 tgt
USING (SELECT :plan_id AS plan_id) src
ON tgt.plan_id = src.plan_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, title = :title, plan_spec = :plan_spec, created_by = :created_by, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(plan_id, instance_ref, feature_key, org_id, title, plan_spec, created_by, created_at)
VALUES(:plan_id, :instance_ref, :feature_key, :org_id, :title, :plan_spec, :created_by, CURRENT_TIMESTAMP());
RETURN :plan_id;
$$;