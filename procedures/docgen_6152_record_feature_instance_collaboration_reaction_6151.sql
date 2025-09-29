CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6152_record_feature_instance_collaboration_reaction_6151(
  reaction_id STRING,
  post_id STRING,
  thread_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  actor STRING,
  reaction STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6151_feature_instance_collaboration_reactions_6151(reaction_id, post_id, thread_id, incident_id, instance_ref, feature_key, org_id, actor, reaction, reacted_at)
VALUES(:reaction_id, :post_id, :thread_id, :incident_id, :instance_ref, :feature_key, :org_id, :actor, :reaction, CURRENT_TIMESTAMP());
RETURN :reaction_id;
$$;