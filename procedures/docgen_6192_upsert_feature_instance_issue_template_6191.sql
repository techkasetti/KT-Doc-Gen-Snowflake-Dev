CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6192_upsert_feature_instance_issue_template_6191(
  template_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  template VARIANT,
  version INT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6191_feature_instance_issue_templates_6191 tgt
USING (SELECT :template_id AS template_id) src
ON tgt.template_id = src.template_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, name = :name, template = :template, version = :version, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(template_id, instance_ref, feature_key, org_id, name, template, version, updated_at)
VALUES(:template_id, :instance_ref, :feature_key, :org_id, :name, :template, :version, CURRENT_TIMESTAMP());
RETURN :template_id;
$$;