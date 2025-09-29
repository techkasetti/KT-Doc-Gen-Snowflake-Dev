CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6129_feature_instance_incident_priority_assignments_6129 (
  assignment_id STRING PRIMARY KEY,
  incident_id STRING,
  rule_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  priority STRING,
  assigned_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);