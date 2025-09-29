CREATE OR REPLACE TABLE AI_FEATURE_HUB.docgen_6027_feature_instance_operational_playbooks_6027 (
  playbook_id STRING PRIMARY KEY,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  content VARIANT,
  version INT,
  updated_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);