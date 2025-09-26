CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5988_record_feature_instance_comms_template_usage_5987(
  usage_id STRING,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  payload VARIANT,
  result VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5987_feature_instance_comms_template_usages_5987(usage_id, template_id, incident_id, instance_ref, feature_key, org_id, executed_by, executed_at, payload, result)
VALUES(:usage_id, :template_id, :incident_id, :instance_ref, :feature_key, :org_id, :executed_by, CURRENT_TIMESTAMP(), :payload, :result);
RETURN :usage_id;
$$;