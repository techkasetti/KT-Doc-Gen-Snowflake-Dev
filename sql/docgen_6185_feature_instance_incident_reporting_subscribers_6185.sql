CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6185_feature_instance_incident_reporting_subscribers_6185 (
  subscriber_id STRING PRIMARY KEY,
  report_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  recipient STRING,
  channel STRING,
  subscribed_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);