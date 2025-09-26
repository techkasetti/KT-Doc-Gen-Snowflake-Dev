CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6016_record_feature_instance_compliance_check_result_6015(
  result_id STRING,
  check_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  result VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6015_feature_instance_compliance_check_results_6015(result_id, check_id, instance_ref, feature_key, org_id, result, checked_at)
VALUES(:result_id, :check_id, :instance_ref, :feature_key, :org_id, :result, CURRENT_TIMESTAMP());
RETURN :result_id;
$$;