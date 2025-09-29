CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6130_record_feature_instance_incident_priority_assignment_6129(
  assignment_id STRING,
  incident_id STRING,
  rule_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  priority STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6129_feature_instance_incident_priority_assignments_6129(assignment_id, incident_id, rule_id, instance_ref, feature_key, org_id, priority, assigned_at)
VALUES(:assignment_id, :incident_id, :rule_id, :instance_ref, :feature_key, :org_id, :priority, CURRENT_TIMESTAMP());
RETURN :assignment_id;
$$;