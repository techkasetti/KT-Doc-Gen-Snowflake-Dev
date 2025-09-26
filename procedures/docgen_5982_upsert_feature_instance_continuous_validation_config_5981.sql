CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5982_upsert_feature_instance_continuous_validation_config_5981(
  config_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  validation_spec VARIANT,
  active BOOLEAN
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_5981_feature_instance_continuous_validation_configs_5981 tgt
USING (SELECT :config_id AS config_id) src
ON tgt.config_id = src.config_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, validation_spec = :validation_spec, active = :active, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(config_id, instance_ref, feature_key, org_id, validation_spec, active, created_at)
VALUES(:config_id, :instance_ref, :feature_key, :org_id, :validation_spec, :active, CURRENT_TIMESTAMP());
RETURN :config_id;
$$;