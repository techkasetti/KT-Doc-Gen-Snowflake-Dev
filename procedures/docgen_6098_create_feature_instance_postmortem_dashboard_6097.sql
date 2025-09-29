CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6098_create_feature_instance_postmortem_dashboard_6097(
  dashboard_id STRING,
  review_id STRING,
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
INSERT INTO AI_FEATURE_HUB.docgen_6097_feature_instance_postmortem_dashboards_6097(dashboard_id, review_id, instance_ref, feature_key, org_id, spec, created_by, created_at)
VALUES(:dashboard_id, :review_id, :instance_ref, :feature_key, :org_id, :spec, :created_by, CURRENT_TIMESTAMP());
RETURN :dashboard_id;
$$;