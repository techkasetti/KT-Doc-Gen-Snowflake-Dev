CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5994_record_feature_instance_incident_summary_view_5993(
  view_id STRING,
  summary_id STRING,
  viewer STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5993_feature_instance_incident_summary_views_5993(view_id, summary_id, viewer, instance_ref, feature_key, org_id, viewed_at)
VALUES(:view_id, :summary_id, :viewer, :instance_ref, :feature_key, :org_id, CURRENT_TIMESTAMP());
RETURN :view_id;
$$;