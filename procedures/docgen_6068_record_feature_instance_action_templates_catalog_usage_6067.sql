CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6068_record_feature_instance_action_templates_catalog_usage_6067(
  usage_id STRING,
  catalog_id STRING,
  template_id STRING,
  action_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  used_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6067_feature_instance_action_templates_catalog_usages_6067(usage_id, catalog_id, template_id, action_id, instance_ref, feature_key, org_id, used_by, used_at)
VALUES(:usage_id, :catalog_id, :template_id, :action_id, :instance_ref, :feature_key, :org_id, :used_by, CURRENT_TIMESTAMP());
RETURN :usage_id;
$$;