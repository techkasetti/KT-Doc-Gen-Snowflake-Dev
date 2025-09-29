CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6169_feature_instance_incident_summary_emails_6169 (
  email_id STRING PRIMARY KEY,
  review_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  recipients ARRAY,
  subject STRING,
  body VARIANT,
  sent_by STRING,
  sent_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
  status STRING
);