CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6032_upsert_feature_instance_postmortem_integration_6031(
  integration_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  provider STRING,
  config VARIANT,
  active BOOLEAN
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6031_feature_instance_incident_postmortem_integrations_6031 tgt
USING (SELECT :integration_id AS integration_id) src
ON tgt.integration_id = src.integration_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, provider = :provider, config = :config, active = :active, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(integration_id, instance_ref, feature_key, org_id, provider, config, active, created_at)
VALUES(:integration_id, :instance_ref, :feature_key, :org_id, :provider, :config, :active, CURRENT_TIMESTAMP());
RETURN :integration_id;
$$;