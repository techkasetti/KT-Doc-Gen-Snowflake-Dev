CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6106_create_feature_instance_incident_followup_task_6105(
  task_id STRING,
  followup_id STRING,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  description STRING,
  owner STRING,
  due_date TIMESTAMP_LTZ,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6105_feature_instance_incident_followup_tasks_6105(task_id, followup_id, incident_id, review_id, instance_ref, feature_key, org_id, description, owner, due_date, status, created_at)
VALUES(:task_id, :followup_id, :incident_id, :review_id, :instance_ref, :feature_key, :org_id, :description, :owner, :due_date, COALESCE(:status, 'OPEN'), CURRENT_TIMESTAMP());
RETURN :task_id;
$$;