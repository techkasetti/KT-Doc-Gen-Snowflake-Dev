CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6136_create_feature_instance_incident_log_archive_6135(
  archive_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  archive_url STRING,
  size_bytes NUMBER
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6135_feature_instance_incident_log_archives_6135(archive_id, incident_id, instance_ref, feature_key, org_id, archive_url, size_bytes, archived_at)
VALUES(:archive_id, :incident_id, :instance_ref, :feature_key, :org_id, :archive_url, :size_bytes, CURRENT_TIMESTAMP());
RETURN :archive_id;
$$;