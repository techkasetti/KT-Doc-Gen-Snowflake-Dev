CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5998_record_feature_instance_release_checklist_completion_5997(
  completion_id STRING,
  checklist_id STRING,
  release_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  completed_by STRING,
  details VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5997_feature_instance_release_checklist_completions_5997(completion_id, checklist_id, release_id, instance_ref, feature_key, org_id, completed_by, completed_at, details)
VALUES(:completion_id, :checklist_id, :release_id, :instance_ref, :feature_key, :org_id, :completed_by, CURRENT_TIMESTAMP(), :details);
RETURN :completion_id;
$$;