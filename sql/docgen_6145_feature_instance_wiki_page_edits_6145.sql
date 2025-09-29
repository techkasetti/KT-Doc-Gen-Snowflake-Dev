CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6145_feature_instance_wiki_page_edits_6145 (
  edit_id STRING PRIMARY KEY,
  page_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  edited_by STRING,
  previous_content VARIANT,
  new_content VARIANT,
  edited_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);