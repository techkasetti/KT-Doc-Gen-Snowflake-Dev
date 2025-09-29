CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6128_upsert_feature_instance_incident_priority_rule_6127(
  rule_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  rule_spec VARIANT,
  active BOOLEAN
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6127_feature_instance_incident_priority_rules_6127 tgt
USING (SELECT :rule_id AS rule_id) src
ON tgt.rule_id = src.rule_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, rule_spec = :rule_spec, active = :active, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(rule_id, instance_ref, feature_key, org_id, rule_spec, active, created_at)
VALUES(:rule_id, :instance_ref, :feature_key, :org_id, :rule_spec, :active, CURRENT_TIMESTAMP());
RETURN :rule_id;
$$;