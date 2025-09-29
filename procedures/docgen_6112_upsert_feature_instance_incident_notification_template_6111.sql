CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6112_upsert_feature_instance_incident_notification_template_6111(
  template_id STRING,
  config_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  channel STRING,
  template VARIANT,
  version INT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6111_feature_instance_incident_notification_templates_6111 tgt
USING (SELECT :template_id AS template_id) src
ON tgt.template_id = src.template_id
WHEN MATCHED THEN UPDATE SET config_id = :config_id, instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, channel = :channel, template = :template, version = :version, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(template_id, config_id, instance_ref, feature_key, org_id, channel, template, version, updated_at)
VALUES(:template_id, :config_id, :instance_ref, :feature_key, :org_id, :channel, :template, :version, CURRENT_TIMESTAMP());
RETURN :template_id;
$$;