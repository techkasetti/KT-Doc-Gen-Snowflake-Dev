CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6204_create_feature_instance_incident_owner_oncall_mapping_6203(
  mapping_id STRING,
  incident_id STRING,
  owner STRING,
  oncall_schedule_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6203_feature_instance_incident_owner_oncall_mappings_6203(mapping_id, incident_id, owner, oncall_schedule_id, instance_ref, feature_key, org_id, mapped_at)
VALUES(:mapping_id, :incident_id, :owner, :oncall_schedule_id, :instance_ref, :feature_key, :org_id, CURRENT_TIMESTAMP());
RETURN :mapping_id;
$$;