CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6164_record_feature_instance_incident_retention_event_6163(
  event_id STRING,
  incident_id STRING,
  policy_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  action STRING,
  executed_by STRING,
  details VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6163_feature_instance_incident_retention_events_6163(event_id, incident_id, policy_id, instance_ref, feature_key, org_id, action, executed_by, executed_at, details)
VALUES(:event_id, :incident_id, :policy_id, :instance_ref, :feature_key, :org_id, :action, :executed_by, CURRENT_TIMESTAMP(), :details);
RETURN :event_id;
$$;