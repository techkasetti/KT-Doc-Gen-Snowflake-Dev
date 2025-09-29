CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6070_upsert_feature_instance_sla_contract_6069(
  sla_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  sla_spec VARIANT,
  effective_from TIMESTAMP_LTZ,
  effective_to TIMESTAMP_LTZ
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6069_feature_instance_sla_contracts_6069 tgt
USING (SELECT :sla_id AS sla_id) src
ON tgt.sla_id = src.sla_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, sla_spec = :sla_spec, effective_from = :effective_from, effective_to = :effective_to, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(sla_id, instance_ref, feature_key, org_id, sla_spec, effective_from, effective_to, created_at)
VALUES(:sla_id, :instance_ref, :feature_key, :org_id, :sla_spec, :effective_from, :effective_to, CURRENT_TIMESTAMP());
RETURN :sla_id;
$$;