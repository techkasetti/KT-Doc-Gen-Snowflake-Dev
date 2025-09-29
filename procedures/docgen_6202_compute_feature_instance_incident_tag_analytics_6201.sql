CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6202_compute_feature_instance_incident_tag_analytics_6201(
  analytics_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  tag_metrics VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6201_feature_instance_incident_tag_analytics_6201(analytics_id, instance_ref, feature_key, org_id, period_start, period_end, tag_metrics, computed_at)
VALUES(:analytics_id, :instance_ref, :feature_key, :org_id, :period_start, :period_end, :tag_metrics, CURRENT_TIMESTAMP());
RETURN :analytics_id;
$$;