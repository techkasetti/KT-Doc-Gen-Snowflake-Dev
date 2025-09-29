CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6100_record_feature_instance_postmortem_dashboard_view_6099(
  view_id STRING,
  dashboard_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  viewer STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6099_feature_instance_postmortem_dashboard_views_6099(view_id, dashboard_id, review_id, instance_ref, feature_key, org_id, viewer, viewed_at)
VALUES(:view_id, :dashboard_id, :review_id, :instance_ref, :feature_key, :org_id, :viewer, CURRENT_TIMESTAMP());
RETURN :view_id;
$$;