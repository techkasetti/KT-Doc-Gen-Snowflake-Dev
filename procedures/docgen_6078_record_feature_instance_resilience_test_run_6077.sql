CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6078_record_feature_instance_resilience_test_run_6077(
  run_id STRING,
  test_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  run_payload VARIANT,
  finished_at TIMESTAMP_LTZ,
  status STRING,
  result VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6077_feature_instance_resilience_test_runs_6077(run_id, test_id, instance_ref, feature_key, org_id, run_payload, started_at, finished_at, status, result)
VALUES(:run_id, :test_id, :instance_ref, :feature_key, :org_id, :run_payload, CURRENT_TIMESTAMP(), :finished_at, :status, :result);
RETURN :run_id;
$$;