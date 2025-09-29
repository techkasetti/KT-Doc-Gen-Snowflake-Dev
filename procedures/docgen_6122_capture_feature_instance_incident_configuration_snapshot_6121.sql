CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6122_capture_feature_instance_incident_configuration_snapshot_6121(
  snapshot_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  config_snapshot VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6121_feature_instance_incident_configuration_snapshots_6121(snapshot_id, incident_id, instance_ref, feature_key, org_id, config_snapshot, captured_at)
VALUES(:snapshot_id, :incident_id, :instance_ref, :feature_key, :org_id, :config_snapshot, CURRENT_TIMESTAMP());
RETURN :snapshot_id;
$$;