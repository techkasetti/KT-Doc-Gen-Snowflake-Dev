CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5954_add_feature_instance_incident_related_service_5953(
  rel_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  service_ref STRING,
  impact_summary VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5953_feature_instance_incident_related_services_5953(rel_id, incident_id, instance_ref, feature_key, org_id, service_ref, impact_summary, added_at)
VALUES(:rel_id, :incident_id, :instance_ref, :feature_key, :org_id, :service_ref, :impact_summary, CURRENT_TIMESTAMP());
RETURN :rel_id;
$$;