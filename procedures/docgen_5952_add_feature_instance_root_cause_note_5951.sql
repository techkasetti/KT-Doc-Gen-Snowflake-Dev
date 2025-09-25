CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5952_add_feature_instance_root_cause_note_5951(
  note_id STRING,
  review_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  note VARIANT,
  author STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5951_feature_instance_root_cause_analysis_notes_5951(note_id, review_id, incident_id, instance_ref, feature_key, org_id, note, author, created_at)
VALUES(:note_id, :review_id, :incident_id, :instance_ref, :feature_key, :org_id, :note, :author, CURRENT_TIMESTAMP());
RETURN :note_id;
$$;