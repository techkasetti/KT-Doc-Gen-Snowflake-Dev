CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_5953_feature_instance_incident_related_services_5953 (
  rel_id STRING PRIMARY KEY,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  service_ref STRING,
  impact_summary VARIANT,
  added_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);