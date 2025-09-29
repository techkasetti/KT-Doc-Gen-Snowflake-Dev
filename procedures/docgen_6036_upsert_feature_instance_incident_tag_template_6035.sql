CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6036_upsert_feature_instance_incident_tag_template_6035(
  template_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  tags ARRAY,
  version INT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6035_feature_instance_incident_tag_templates_6035 tgt
USING (SELECT :template_id AS template_id) src
ON tgt.template_id = src.template_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, name = :name, tags = :tags, version = :version, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(template_id, instance_ref, feature_key, org_id, name, tags, version, updated_at)
VALUES(:template_id, :instance_ref, :feature_key, :org_id, :name, :tags, :version, CURRENT_TIMESTAMP());
RETURN :template_id;
$$;