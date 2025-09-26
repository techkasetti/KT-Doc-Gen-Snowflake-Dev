CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6017_feature_instance_compliance_exceptions_6017 (
  exception_id STRING PRIMARY KEY,
  check_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  requester STRING,
  reason VARIANT,
  approved BOOLEAN,
  decision_by STRING,
  decision_at TIMESTAMP_LTZ,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);