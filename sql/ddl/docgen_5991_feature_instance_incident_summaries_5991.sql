CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5991_feature_instance_incident_summaries_5991 (
  summary_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  summary VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);