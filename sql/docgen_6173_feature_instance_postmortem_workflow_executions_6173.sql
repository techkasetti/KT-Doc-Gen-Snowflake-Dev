CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6173_feature_instance_postmortem_workflow_executions_6173 (
  execution_id STRING PRIMARY KEY,
  workflow_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  executed_by STRING,
  started_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  finished_at TIMESTAMP_LTZ,
  status STRING,
  result VARIANT
);