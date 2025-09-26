CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6020_register_feature_instance_backup_6019(
  backup_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  backup_spec VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6019_feature_instance_backup_catalog_6019(backup_id, instance_ref, feature_key, org_id, backup_spec, stored_at)
VALUES(:backup_id, :instance_ref, :feature_key, :org_id, :backup_spec, CURRENT_TIMESTAMP());
RETURN :backup_id;
$$;