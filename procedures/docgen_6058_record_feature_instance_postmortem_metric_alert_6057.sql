CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6058_record_feature_instance_postmortem_metric_alert_6057(
  alert_id STRING,
  metric_key STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  observed_value NUMBER,
  threshold NUMBER,
  severity STRING,
  metadata VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6057_feature_instance_postmortem_metrics_alerts_6057(alert_id, metric_key, review_id, instance_ref, feature_key, org_id, observed_value, threshold, severity, detected_at, metadata)
VALUES(:alert_id, :metric_key, :review_id, :instance_ref, :feature_key, :org_id, :observed_value, :threshold, :severity, CURRENT_TIMESTAMP(), :metadata);
RETURN :alert_id;
$$;