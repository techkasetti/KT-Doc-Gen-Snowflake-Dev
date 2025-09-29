CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6038_record_feature_instance_incident_tag_template_usage_6037(
  usage_id STRING,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  used_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6037_feature_instance_incident_tag_template_usages_6037(usage_id, template_id, incident_id, instance_ref, feature_key, org_id, used_by, used_at)
VALUES(:usage_id, :template_id, :incident_id, :instance_ref, :feature_key, :org_id, :used_by, CURRENT_TIMESTAMP());
RETURN :usage_id;
$$;