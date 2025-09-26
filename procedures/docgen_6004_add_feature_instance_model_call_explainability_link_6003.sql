CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6004_add_feature_instance_model_call_explainability_link_6003(
  link_id STRING,
  trace_id STRING,
  model_call_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  explainability_ref STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6003_feature_instance_model_call_explainability_links_6003(link_id, trace_id, model_call_id, instance_ref, feature_key, org_id, explainability_ref, added_at)
VALUES(:link_id, :trace_id, :model_call_id, :instance_ref, :feature_key, :org_id, :explainability_ref, CURRENT_TIMESTAMP());
RETURN :link_id;
$$;