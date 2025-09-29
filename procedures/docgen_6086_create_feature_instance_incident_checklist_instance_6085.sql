CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6086_create_feature_instance_incident_checklist_instance_6085(
  instance_id STRING,
  template_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  filled_by STRING,
  data VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6085_feature_instance_incident_checklist_instances_6085(instance_id, template_id, incident_id, instance_ref, feature_key, org_id, filled_by, filled_at, data)
VALUES(:instance_id, :template_id, :incident_id, :instance_ref, :feature_key, :org_id, :filled_by, CURRENT_TIMESTAMP(), :data);
RETURN :instance_id;
$$;