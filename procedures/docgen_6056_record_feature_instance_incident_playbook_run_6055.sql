CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6056_record_feature_instance_incident_playbook_run_6055(
  run_id STRING,
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
INSERT INTO AI_FEATURE_HUB.docgen_6055_feature_instance_incident_playbook_runs_6055(run_id, template_id, incident_id, instance_ref, feature_key, org_id, executed_by, executed_at, payload, result)
VALUES(:run_id, :template_id, :incident_id, :instance_ref, :feature_key, :org_id, :executed_by, CURRENT_TIMESTAMP(), :payload, :result);
RETURN :run_id;
$$;