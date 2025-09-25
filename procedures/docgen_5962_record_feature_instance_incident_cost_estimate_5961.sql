CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5962_record_feature_instance_incident_cost_estimate_5961(
  estimate_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  estimate_spec VARIANT,
  estimated_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5961_feature_instance_incident_cost_estimates_5961(estimate_id, incident_id, instance_ref, feature_key, org_id, estimate_spec, estimated_by, estimated_at)
VALUES(:estimate_id, :incident_id, :instance_ref, :feature_key, :org_id, :estimate_spec, :estimated_by, CURRENT_TIMESTAMP());
RETURN :estimate_id;
$$;