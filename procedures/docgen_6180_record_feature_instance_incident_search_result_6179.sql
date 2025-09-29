CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6180_record_feature_instance_incident_search_result_6179(
  result_id STRING,
  query_id STRING,
  user_ref STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  results VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6179_feature_instance_incident_search_results_6179(result_id, query_id, user_ref, instance_ref, feature_key, org_id, results, returned_at)
VALUES(:result_id, :query_id, :user_ref, :instance_ref, :feature_key, :org_id, :results, CURRENT_TIMESTAMP());
RETURN :result_id;
$$;