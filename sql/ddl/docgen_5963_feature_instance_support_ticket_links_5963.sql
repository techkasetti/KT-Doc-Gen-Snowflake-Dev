CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5963_feature_instance_support_ticket_links_5963 (
  link_id STRING PRIMARY KEY,
  incident_id STRING,
  ticket_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  link_meta VARIANT,
  linked_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);