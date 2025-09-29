CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6210_record_feature_instance_incident_resolution_run_6209(
  run_id STRING,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  outcome VARIANT,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6209_feature_instance_incident_resolution_runs_6209(run_id, template_id, incident_id, instance_ref, feature_key, org_id, executed_by, executed_at, outcome, status)
VALUES(:run_id, :template_id, :incident_id, :instance_ref, :feature_key, :org_id, :executed_by, CURRENT_TIMESTAMP(), :outcome, :status);
RETURN :run_id;
$$;