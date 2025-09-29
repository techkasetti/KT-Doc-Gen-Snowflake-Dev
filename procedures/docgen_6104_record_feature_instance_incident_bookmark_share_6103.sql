CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6104_record_feature_instance_incident_bookmark_share_6103(
  share_id STRING,
  bookmark_id STRING,
  incident_id STRING,
  shared_by STRING,
  shared_with ARRAY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6103_feature_instance_incident_bookmark_shares_6103(share_id, bookmark_id, incident_id, shared_by, shared_with, instance_ref, feature_key, org_id, shared_at)
VALUES(:share_id, :bookmark_id, :incident_id, :shared_by, :shared_with, :instance_ref, :feature_key, :org_id, CURRENT_TIMESTAMP());
RETURN :share_id;
$$;