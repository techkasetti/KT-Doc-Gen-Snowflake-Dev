CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6171_feature_instance_incident_postmortem_workflows_6171 (
  workflow_id STRING PRIMARY KEY,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  workflow_spec VARIANT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);