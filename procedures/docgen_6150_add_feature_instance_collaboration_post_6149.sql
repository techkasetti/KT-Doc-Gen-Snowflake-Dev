CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6150_add_feature_instance_collaboration_post_6149(
  post_id STRING,
  thread_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  author STRING,
  body VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6149_feature_instance_collaboration_posts_6149(post_id, thread_id, incident_id, instance_ref, feature_key, org_id, author, body, posted_at)
VALUES(:post_id, :thread_id, :incident_id, :instance_ref, :feature_key, :org_id, :author, :body, CURRENT_TIMESTAMP());
RETURN :post_id;
$$;