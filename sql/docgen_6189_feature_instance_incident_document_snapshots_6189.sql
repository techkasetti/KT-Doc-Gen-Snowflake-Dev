CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6189_feature_instance_incident_document_snapshots_6189 (
  snapshot_id STRING PRIMARY KEY,
  doc_ref_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  content VARIANT,
  captured_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);