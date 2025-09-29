CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6088_record_feature_instance_incident_checklist_completion_6087(
  completion_id STRING,
  instance_id STRING,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  completed_by STRING,
  results VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6087_feature_instance_incident_checklist_completions_6087(completion_id, instance_id, template_id, incident_id, instance_ref, feature_key, org_id, completed_by, completed_at, results)
VALUES(:completion_id, :instance_id, :template_id, :incident_id, :instance_ref, :feature_key, :org_id, :completed_by, CURRENT_TIMESTAMP(), :results);
RETURN :completion_id;
$$;