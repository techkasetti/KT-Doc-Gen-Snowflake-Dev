CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5996_create_feature_instance_release_checklist_5995(
  checklist_id STRING,
  release_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  items VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5995_feature_instance_release_checklists_5995(checklist_id, release_id, instance_ref, feature_key, org_id, items, created_by, created_at)
VALUES(:checklist_id, :release_id, :instance_ref, :feature_key, :org_id, :items, :created_by, CURRENT_TIMESTAMP());
RETURN :checklist_id;
$$;