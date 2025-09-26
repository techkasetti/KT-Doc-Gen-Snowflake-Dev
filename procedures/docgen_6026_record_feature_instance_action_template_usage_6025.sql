CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6026_record_feature_instance_action_template_usage_6025(
  usage_id STRING,
  template_id STRING,
  action_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  used_by STRING,
  context VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6025_feature_instance_action_template_usages_6025(usage_id, template_id, action_id, instance_ref, feature_key, org_id, used_by, used_at, context)
VALUES(:usage_id, :template_id, :action_id, :instance_ref, :feature_key, :org_id, :used_by, CURRENT_TIMESTAMP(), :context);
RETURN :usage_id;
$$;