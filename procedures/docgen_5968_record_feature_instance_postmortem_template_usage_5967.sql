CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5968_record_feature_instance_postmortem_template_usage_5967(
  usage_id STRING,
  template_id STRING,
  review_id STRING,
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
INSERT INTO AI_FEATURE_HUB.docgen_5967_feature_instance_postmortem_template_usages_5967(usage_id, template_id, review_id, instance_ref, feature_key, org_id, used_by, used_at, context)
VALUES(:usage_id, :template_id, :review_id, :instance_ref, :feature_key, :org_id, :used_by, CURRENT_TIMESTAMP(), :context);
RETURN :usage_id;
$$;