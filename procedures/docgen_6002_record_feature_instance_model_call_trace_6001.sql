CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6002_record_feature_instance_model_call_trace_6001(
  trace_id STRING,
  model_call_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  request VARIANT,
  response VARIANT,
  duration_ms NUMBER
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6001_feature_instance_model_call_traces_6001(trace_id, model_call_id, instance_ref, feature_key, org_id, request, response, duration_ms, called_at)
VALUES(:trace_id, :model_call_id, :instance_ref, :feature_key, :org_id, :request, :response, :duration_ms, CURRENT_TIMESTAMP());
RETURN :trace_id;
$$;