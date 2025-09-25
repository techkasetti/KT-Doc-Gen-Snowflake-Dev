CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5958_declare_feature_instance_major_incident_5957(
  declaration_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  declared_by STRING,
  reason VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5957_feature_instance_major_incident_declarations_5957(declaration_id, incident_id, instance_ref, feature_key, org_id, declared_by, declared_at, reason)
VALUES(:declaration_id, :incident_id, :instance_ref, :feature_key, :org_id, :declared_by, CURRENT_TIMESTAMP(), :reason);
RETURN :declaration_id;
$$;