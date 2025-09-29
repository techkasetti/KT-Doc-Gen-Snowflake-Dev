CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6046_create_feature_instance_service_health_dashboard_6045(
  dashboard_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  spec VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6045_feature_instance_service_health_dashboards_6045(dashboard_id, instance_ref, feature_key, org_id, spec, created_by, created_at)
VALUES(:dashboard_id, :instance_ref, :feature_key, :org_id, :spec, :created_by, CURRENT_TIMESTAMP());
RETURN :dashboard_id;
$$;