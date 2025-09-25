CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5975_feature_instance_testing_plans_5975 (
  plan_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  plan_spec VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);