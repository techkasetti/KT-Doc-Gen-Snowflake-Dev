CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6102_add_feature_instance_incident_bookmark_6101(
  bookmark_id STRING,
  incident_id STRING,
  user_ref STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  note STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6101_feature_instance_incident_bookmarks_6101(bookmark_id, incident_id, user_ref, instance_ref, feature_key, org_id, note, bookmarked_at)
VALUES(:bookmark_id, :incident_id, :user_ref, :instance_ref, :feature_key, :org_id, :note, CURRENT_TIMESTAMP());
RETURN :bookmark_id;
$$;