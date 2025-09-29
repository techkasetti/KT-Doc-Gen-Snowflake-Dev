CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6134_capture_feature_instance_incident_telemetry_snapshot_6133(
  snapshot_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  telemetry VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6133_feature_instance_incident_telemetry_snapshots_6133(snapshot_id, incident_id, instance_ref, feature_key, org_id, telemetry, captured_at)
VALUES(:snapshot_id, :incident_id, :instance_ref, :feature_key, :org_id, :telemetry, CURRENT_TIMESTAMP());
RETURN :snapshot_id;
$$;