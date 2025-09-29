CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6030_record_feature_instance_playbook_usage_6029(
  usage_id STRING,
  playbook_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  context VARIANT,
  result VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6029_feature_instance_playbook_usages_6029(usage_id, playbook_id, incident_id, instance_ref, feature_key, org_id, executed_by, executed_at, context, result)
VALUES(:usage_id, :playbook_id, :incident_id, :instance_ref, :feature_key, :org_id, :executed_by, CURRENT_TIMESTAMP(), :context, :result);
RETURN :usage_id;
$$;