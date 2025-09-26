CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6014_upsert_feature_instance_compliance_check_config_6013(
  check_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  check_spec VARIANT,
  active BOOLEAN
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6013_feature_instance_compliance_check_configs_6013 tgt
USING (SELECT :check_id AS check_id) src
ON tgt.check_id = src.check_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, check_spec = :check_spec, active = :active, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(check_id, instance_ref, feature_key, org_id, check_spec, active, created_at)
VALUES(:check_id, :instance_ref, :feature_key, :org_id, :check_spec, :active, CURRENT_TIMESTAMP());
RETURN :check_id;
$$;