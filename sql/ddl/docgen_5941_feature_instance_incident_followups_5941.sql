CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5941_feature_instance_incident_followups_5941 (
  followup_id STRING PRIMARY KEY,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  followup_text VARIANT,
  created_by STRING,
  created_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);


