CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6126_record_feature_instance_investigation_checklist_progress_6125(
  progress_id STRING,
  checklist_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  step_id STRING,
  completed BOOLEAN,
  completed_by STRING,
  notes VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6125_feature_instance_investigation_checklist_progress_6125(progress_id, checklist_id, incident_id, instance_ref, feature_key, org_id, step_id, completed, completed_by, completed_at, notes)
VALUES(:progress_id, :checklist_id, :incident_id, :instance_ref, :feature_key, :org_id, :step_id, :completed, :completed_by, CURRENT_TIMESTAMP(), :notes);
RETURN :progress_id;
$$;