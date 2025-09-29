CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6144_upsert_feature_instance_incident_wiki_page_6143(
  page_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  content VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6143_feature_instance_incident_wiki_pages_6143 tgt
USING (SELECT :page_id AS page_id) src
ON tgt.page_id = src.page_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, title = :title, content = :content, updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(page_id, instance_ref, feature_key, org_id, title, content, created_by, created_at, updated_at)
VALUES(:page_id, :instance_ref, :feature_key, :org_id, :title, :content, :created_by, CURRENT_TIMESTAMP(), NULL);
RETURN :page_id;
$$;