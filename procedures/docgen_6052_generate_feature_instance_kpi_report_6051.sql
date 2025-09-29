CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6052_generate_feature_instance_kpi_report_6051(
  report_id STRING,
  template_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  period_start TIMESTAMP_LTZ,
  period_end TIMESTAMP_LTZ,
  report_payload VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6051_feature_instance_kpi_reports_6051(report_id, template_id, instance_ref, feature_key, org_id, period_start, period_end, report_payload, generated_at)
VALUES(:report_id, :template_id, :instance_ref, :feature_key, :org_id, :period_start, :period_end, :report_payload, CURRENT_TIMESTAMP());
RETURN :report_id;
$$;