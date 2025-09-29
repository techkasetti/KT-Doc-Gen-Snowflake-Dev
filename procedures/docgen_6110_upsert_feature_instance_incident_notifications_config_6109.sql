CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6110_upsert_feature_instance_incident_notifications_config_6109(
  config_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  config VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6109_feature_instance_incident_notifications_config_6109 tgt
USING (SELECT :config_id AS config_id) src
ON tgt.config_id = src.config_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, config = :config, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(config_id, instance_ref, feature_key, org_id, config, updated_at)
VALUES(:config_id, :instance_ref, :feature_key, :org_id, :config, CURRENT_TIMESTAMP());
RETURN :config_id;
$$;