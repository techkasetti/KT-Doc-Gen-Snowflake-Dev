CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6184_generate_feature_instance_incident_analytics_report_6183(
  report_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  report VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6183_feature_instance_incident_analytics_reports_6183(report_id, instance_ref, feature_key, org_id, period_start, period_end, report, generated_at)
VALUES(:report_id, :instance_ref, :feature_key, :org_id, :period_start, :period_end, :report, CURRENT_TIMESTAMP());
RETURN :report_id;
$$;