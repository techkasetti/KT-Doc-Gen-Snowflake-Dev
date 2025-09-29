CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6138_record_feature_instance_incident_log_archive_part_6137(
  part_id STRING,
  archive_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  part_url STRING,
  size_bytes NUMBER
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6137_feature_instance_incident_log_archive_parts_6137(part_id, archive_id, incident_id, instance_ref, feature_key, org_id, part_url, size_bytes, created_at)
VALUES(:part_id, :archive_id, :incident_id, :instance_ref, :feature_key, :org_id, :part_url, :size_bytes, CURRENT_TIMESTAMP());
RETURN :part_id;
$$;