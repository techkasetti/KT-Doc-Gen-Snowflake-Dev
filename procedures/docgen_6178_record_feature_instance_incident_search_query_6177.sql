CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6178_record_feature_instance_incident_search_query_6177(
  query_id STRING,
  user_ref STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  query_text STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6177_feature_instance_incident_search_queries_6177(query_id, user_ref, instance_ref, feature_key, org_id, query_text, executed_at)
VALUES(:query_id, :user_ref, :instance_ref, :feature_key, :org_id, :query_text, CURRENT_TIMESTAMP());
RETURN :query_id;
$$;