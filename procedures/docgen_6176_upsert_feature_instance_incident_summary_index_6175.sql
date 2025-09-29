CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6176_upsert_feature_instance_incident_summary_index_6175(
  index_id STRING,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  search_text STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6175_feature_instance_incident_summaries_index_6175 tgt
USING (SELECT :index_id AS index_id) src
ON tgt.index_id = src.index_id
WHEN MATCHED THEN UPDATE SET incident_id = :incident_id, review_id = :review_id, instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, search_text = :search_text, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(index_id, incident_id, review_id, instance_ref, feature_key, org_id, search_text, updated_at)
VALUES(:index_id, :incident_id, :review_id, :instance_ref, :feature_key, :org_id, :search_text, CURRENT_TIMESTAMP());
RETURN :index_id;
$$;