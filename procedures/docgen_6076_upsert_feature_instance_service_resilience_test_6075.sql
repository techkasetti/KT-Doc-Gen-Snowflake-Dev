CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6076_upsert_feature_instance_service_resilience_test_6075(
  test_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  test_spec VARIANT,
  frequency STRING,
  active BOOLEAN
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6075_feature_instance_service_resilience_tests_6075 tgt
USING (SELECT :test_id AS test_id) src
ON tgt.test_id = src.test_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, test_spec = :test_spec, frequency = :frequency, active = :active, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(test_id, instance_ref, feature_key, org_id, test_spec, frequency, active, created_at)
VALUES(:test_id, :instance_ref, :feature_key, :org_id, :test_spec, :frequency, :active, CURRENT_TIMESTAMP());
RETURN :test_id;
$$;