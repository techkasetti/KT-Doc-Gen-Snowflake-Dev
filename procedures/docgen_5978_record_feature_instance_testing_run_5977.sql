CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5978_record_feature_instance_testing_run_5977(
  run_id STRING,
  plan_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  run_payload VARIANT,
  finished_at TIMESTAMP_LTZ,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5977_feature_instance_testing_runs_5977(run_id, plan_id, instance_ref, feature_key, org_id, run_payload, started_at, finished_at, status)
VALUES(:run_id, :plan_id, :instance_ref, :feature_key, :org_id, :run_payload, CURRENT_TIMESTAMP(), :finished_at, :status);
RETURN :run_id;
$$;