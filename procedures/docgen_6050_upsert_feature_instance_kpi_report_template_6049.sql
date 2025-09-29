CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6050_upsert_feature_instance_kpi_report_template_6049(
  template_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  spec VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6049_feature_instance_kpi_report_templates_6049 tgt
USING (SELECT :template_id AS template_id) src
ON tgt.template_id = src.template_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, name = :name, spec = :spec, created_by = :created_by, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(template_id, instance_ref, feature_key, org_id, name, spec, created_by, created_at)
VALUES(:template_id, :instance_ref, :feature_key, :org_id, :name, :spec, :created_by, CURRENT_TIMESTAMP());
RETURN :template_id;
$$;