CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5950_set_feature_instance_postmortem_action_priority_5949(
  priority_id STRING,
  action_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  priority_level STRING,
  set_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_5949_feature_instance_postmortem_action_priorities_5949 tgt
USING (SELECT :priority_id AS priority_id) src
ON tgt.priority_id = src.priority_id
WHEN MATCHED THEN UPDATE SET action_id = :action_id, review_id = :review_id, instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, priority_level = :priority_level, set_by = :set_by, set_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(priority_id, action_id, review_id, instance_ref, feature_key, org_id, priority_level, set_by, set_at)
VALUES(:priority_id, :action_id, :review_id, :instance_ref, :feature_key, :org_id, :priority_level, :set_by, CURRENT_TIMESTAMP());
RETURN :priority_id;
$$;