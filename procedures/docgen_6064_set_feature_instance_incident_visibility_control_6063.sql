CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6064_set_feature_instance_incident_visibility_control_6063(
  control_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  visibility_spec VARIANT,
  set_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6063_feature_instance_incident_visibility_controls_6063 tgt
USING (SELECT :control_id AS control_id) src
ON tgt.control_id = src.control_id
WHEN MATCHED THEN UPDATE SET incident_id = :incident_id, instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, visibility_spec = :visibility_spec, set_by = :set_by, set_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(control_id, incident_id, instance_ref, feature_key, org_id, visibility_spec, set_by, set_at)
VALUES(:control_id, :incident_id, :instance_ref, :feature_key, :org_id, :visibility_spec, :set_by, CURRENT_TIMESTAMP());
RETURN :control_id;
$$;