CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6008_publish_feature_instance_model_release_note_6007(
  note_id STRING,
  model_id STRING,
  version STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  body VARIANT,
  released_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6007_feature_instance_model_release_notes_6007(note_id, model_id, version, instance_ref, feature_key, org_id, title, body, released_by, released_at)
VALUES(:note_id, :model_id, :version, :instance_ref, :feature_key, :org_id, :title, :body, :released_by, CURRENT_TIMESTAMP());
RETURN :note_id;
$$;