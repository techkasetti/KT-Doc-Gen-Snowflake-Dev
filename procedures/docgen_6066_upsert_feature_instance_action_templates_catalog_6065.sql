CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6066_upsert_feature_instance_action_templates_catalog_6065(
  catalog_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  templates VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6065_feature_instance_postmortem_action_templates_catalog_6065 tgt
USING (SELECT :catalog_id AS catalog_id) src
ON tgt.catalog_id = src.catalog_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, templates = :templates, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(catalog_id, instance_ref, feature_key, org_id, templates, updated_at)
VALUES(:catalog_id, :instance_ref, :feature_key, :org_id, :templates, CURRENT_TIMESTAMP());
RETURN :catalog_id;
$$;