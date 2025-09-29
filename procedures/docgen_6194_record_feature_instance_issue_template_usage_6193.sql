CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6194_record_feature_instance_issue_template_usage_6193(
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
INSERT INTO AI_FEATURE_HUB.docgen_6193_feature_instance_issue_template_usages_6193(usage_id, template_id, incident_id, instance_ref, feature_key, org_id, used_by, used_at)
VALUES(:usage_id, :template_id, :incident_id, :instance_ref, :feature_key, :org_id, :used_by, CURRENT_TIMESTAMP());
RETURN :usage_id;
$$;