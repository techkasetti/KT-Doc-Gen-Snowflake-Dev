CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5970_add_feature_instance_engineering_note_5969(
  note_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  body VARIANT,
  author STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5969_feature_instance_engineering_notes_5969(note_id, instance_ref, feature_key, org_id, title, body, author, created_at)
VALUES(:note_id, :instance_ref, :feature_key, :org_id, :title, :body, :author, CURRENT_TIMESTAMP());
RETURN :note_id;
$$;