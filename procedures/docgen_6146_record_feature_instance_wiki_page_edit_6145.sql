CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6146_record_feature_instance_wiki_page_edit_6145(
  edit_id STRING,
  page_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  edited_by STRING,
  previous_content VARIANT,
  new_content VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6145_feature_instance_wiki_page_edits_6145(edit_id, page_id, instance_ref, feature_key, org_id, edited_by, previous_content, new_content, edited_at)
VALUES(:edit_id, :page_id, :instance_ref, :feature_key, :org_id, :edited_by, :previous_content, :new_content, CURRENT_TIMESTAMP());
RETURN :edit_id;
$$;