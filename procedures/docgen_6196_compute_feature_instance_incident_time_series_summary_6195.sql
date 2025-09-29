CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6196_compute_feature_instance_incident_time_series_summary_6195(
  summary_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  series VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6195_feature_instance_incident_time_series_summaries_6195(summary_id, incident_id, instance_ref, feature_key, org_id, period_start, period_end, series, computed_at)
VALUES(:summary_id, :incident_id, :instance_ref, :feature_key, :org_id, :period_start, :period_end, :series, CURRENT_TIMESTAMP());
RETURN :summary_id;
$$;