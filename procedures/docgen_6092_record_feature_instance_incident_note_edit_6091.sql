CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6092_record_feature_instance_incident_note_edit_6091(
  edit_id STRING,
  note_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  edited_by STRING,
  previous_body VARIANT,
  new_body VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6091_feature_instance_incident_note_edits_6091(edit_id, note_id, incident_id, instance_ref, feature_key, org_id, edited_by, previous_body, new_body, edited_at)
VALUES(:edit_id, :note_id, :incident_id, :instance_ref, :feature_key, :org_id, :edited_by, :previous_body, :new_body, CURRENT_TIMESTAMP());
RETURN :edit_id;
$$;