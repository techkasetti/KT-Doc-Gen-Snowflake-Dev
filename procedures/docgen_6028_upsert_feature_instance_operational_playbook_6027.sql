CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6028_upsert_feature_instance_operational_playbook_6027(
  playbook_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  content VARIANT,
  version INT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6027_feature_instance_operational_playbooks_6027 tgt
USING (SELECT :playbook_id AS playbook_id) src
ON tgt.playbook_id = src.playbook_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, title = :title, content = :content, version = :version, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(playbook_id, instance_ref, feature_key, org_id, title, content, version, updated_at)
VALUES(:playbook_id, :instance_ref, :feature_key, :org_id, :title, :content, :version, CURRENT_TIMESTAMP());
RETURN :playbook_id;
$$;