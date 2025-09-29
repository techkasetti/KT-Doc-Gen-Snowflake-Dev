CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6090_add_feature_instance_incident_note_6089(
  note_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  body VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6089_feature_instance_incident_notes_6089(note_id, incident_id, instance_ref, feature_key, org_id, body, created_by, created_at)
VALUES(:note_id, :incident_id, :instance_ref, :feature_key, :org_id, :body, :created_by, CURRENT_TIMESTAMP());
RETURN :note_id;
$$;