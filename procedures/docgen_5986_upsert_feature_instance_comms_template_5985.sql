REATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5986_upsert_feature_instance_comms_template_5985(
  template_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  template VARIANT,
  channel STRING,
  version INT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_5985_feature_instance_comms_templates_5985 tgt
USING (SELECT :template_id AS template_id) src
ON tgt.template_id = src.template_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, name = :name, template = :template, channel = :channel, version = :version, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(template_id, instance_ref, feature_key, org_id, name, template, channel, version, updated_at)
VALUES(:template_id, :instance_ref, :feature_key, :org_id, :name, :template, :channel, :version, CURRENT_TIMESTAMP());
RETURN :template_id;
$$;