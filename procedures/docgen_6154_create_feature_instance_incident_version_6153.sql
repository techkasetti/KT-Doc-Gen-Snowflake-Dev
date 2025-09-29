CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6154_create_feature_instance_incident_version_6153(
  version_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  snapshot VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6153_feature_instance_incident_versions_6153(version_id, incident_id, instance_ref, feature_key, org_id, snapshot, created_by, created_at)
VALUES(:version_id, :incident_id, :instance_ref, :feature_key, :org_id, :snapshot, :created_by, CURRENT_TIMESTAMP());
RETURN :version_id;
$$;