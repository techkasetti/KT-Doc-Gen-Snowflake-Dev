CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5980_record_feature_instance_test_run_result_5979(
  result_id STRING,
  run_id STRING,
  test_case STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  outcome STRING,
  details VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5979_feature_instance_test_run_results_5979(result_id, run_id, test_case, instance_ref, feature_key, org_id, outcome, details, recorded_at)
VALUES(:result_id, :run_id, :test_case, :instance_ref, :feature_key, :org_id, :outcome, :details, CURRENT_TIMESTAMP());
RETURN :result_id;
$$;