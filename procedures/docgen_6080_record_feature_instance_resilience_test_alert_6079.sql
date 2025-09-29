CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6080_record_feature_instance_resilience_test_alert_6079(
  alert_id STRING,
  run_id STRING,
  test_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  alert_spec VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6079_feature_instance_resilience_test_alerts_6079(alert_id, run_id, test_id, instance_ref, feature_key, org_id, alert_spec, triggered_at)
VALUES(:alert_id, :run_id, :test_id, :instance_ref, :feature_key, :org_id, :alert_spec, CURRENT_TIMESTAMP());
RETURN :alert_id;
$$;