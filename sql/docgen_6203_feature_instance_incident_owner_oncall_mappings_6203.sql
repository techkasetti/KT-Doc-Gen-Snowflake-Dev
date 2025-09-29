CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6203_feature_instance_incident_owner_oncall_mappings_6203 (
  mapping_id STRING PRIMARY KEY,
  incident_id STRING,
  owner STRING,
  oncall_schedule_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  mapped_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);