CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5984_record_feature_instance_continuous_validation_run_5983(
  run_id STRING,
  config_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  run_result VARIANT,
  finished_at TIMESTAMP_LTZ,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5983_feature_instance_continuous_validation_runs_5983(run_id, config_id, instance_ref, feature_key, org_id, run_result, started_at, finished_at, status)
VALUES(:run_id, :config_id, :instance_ref, :feature_key, :org_id, :run_result, CURRENT_TIMESTAMP(), :finished_at, :status);
RETURN :run_id;
$$;