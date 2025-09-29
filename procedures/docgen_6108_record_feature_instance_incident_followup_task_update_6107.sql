CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6108_record_feature_instance_incident_followup_task_update_6107(
  update_id STRING,
  task_id STRING,
  followup_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  updated_by STRING,
  update_notes VARIANT,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6107_feature_instance_incident_followup_task_updates_6107(update_id, task_id, followup_id, incident_id, instance_ref, feature_key, org_id, updated_by, update_notes, status, updated_at)
VALUES(:update_id, :task_id, :followup_id, :incident_id, :instance_ref, :feature_key, :org_id, :updated_by, :update_notes, :status, CURRENT_TIMESTAMP());
UPDATE AI_FEATURE_HUB.docgen_6105_feature_instance_incident_followup_tasks_6105
SET status = :status
WHERE task_id = :task_id AND org_id = :org_id;
RETURN :update_id;
$$;