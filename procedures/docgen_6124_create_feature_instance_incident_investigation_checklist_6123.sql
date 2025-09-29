CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6124_create_feature_instance_incident_investigation_checklist_6123(
  checklist_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  items VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6123_feature_instance_incident_investigation_checklists_6123(checklist_id, incident_id, instance_ref, feature_key, org_id, items, created_at)
VALUES(:checklist_id, :incident_id, :instance_ref, :feature_key, :org_id, :items, CURRENT_TIMESTAMP());
RETURN :checklist_id;
$$;