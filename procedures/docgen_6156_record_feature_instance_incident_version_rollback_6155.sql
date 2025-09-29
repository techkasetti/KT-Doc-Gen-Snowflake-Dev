CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6156_record_feature_instance_incident_version_rollback_6155(
  rollback_id STRING,
  version_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  rolled_back_by STRING,
  notes VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6155_feature_instance_incident_version_rollbacks_6155(rollback_id, version_id, incident_id, instance_ref, feature_key, org_id, rolled_back_by, rolled_back_at, notes)
VALUES(:rollback_id, :version_id, :incident_id, :instance_ref, :feature_key, :org_id, :rolled_back_by, CURRENT_TIMESTAMP(), :notes);
RETURN :rollback_id;
$$;