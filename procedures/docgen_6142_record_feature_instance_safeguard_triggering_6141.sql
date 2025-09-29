CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6142_record_feature_instance_safeguard_triggering_6141(
  trigger_id STRING,
  rule_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  context VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6141_feature_instance_safeguard_triggerings_6141(trigger_id, rule_id, incident_id, instance_ref, feature_key, org_id, triggered_at, context)
VALUES(:trigger_id, :rule_id, :incident_id, :instance_ref, :feature_key, :org_id, CURRENT_TIMESTAMP(), :context);
RETURN :trigger_id;
$$;