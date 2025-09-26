CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6015_feature_instance_compliance_check_results_6015 (
  result_id STRING PRIMARY KEY,
  check_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  result VARIANT,
  checked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);