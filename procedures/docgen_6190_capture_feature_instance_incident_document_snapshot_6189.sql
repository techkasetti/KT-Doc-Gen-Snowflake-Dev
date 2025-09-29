CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6190_capture_feature_instance_incident_document_snapshot_6189(
  snapshot_id STRING,
  doc_ref_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  content VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6189_feature_instance_incident_document_snapshots_6189(snapshot_id, doc_ref_id, incident_id, instance_ref, feature_key, org_id, content, captured_at)
VALUES(:snapshot_id, :doc_ref_id, :incident_id, :instance_ref, :feature_key, :org_id, :content, CURRENT_TIMESTAMP());
RETURN :snapshot_id;
$$;