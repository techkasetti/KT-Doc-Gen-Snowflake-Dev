CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6074_record_feature_instance_sla_breach_response_6073(
  response_id STRING,
  breach_id STRING,
  sla_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  responder STRING,
  response VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6073_feature_instance_sla_breach_responses_6073(response_id, breach_id, sla_id, incident_id, instance_ref, feature_key, org_id, responder, response, responded_at)
VALUES(:response_id, :breach_id, :sla_id, :incident_id, :instance_ref, :feature_key, :org_id, :responder, :response, CURRENT_TIMESTAMP());
RETURN :response_id;
$$;