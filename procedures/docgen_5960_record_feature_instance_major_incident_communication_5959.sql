CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5960_record_feature_instance_major_incident_communication_5959(
  comm_id STRING,
  declaration_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  channel STRING,
  message VARIANT,
  sent_by STRING,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5959_feature_instance_major_incident_communications_5959(comm_id, declaration_id, incident_id, instance_ref, feature_key, org_id, channel, message, sent_by, sent_at, status)
VALUES(:comm_id, :declaration_id, :incident_id, :instance_ref, :feature_key, :org_id, :channel, :message, :sent_by, CURRENT_TIMESTAMP(), :status);
RETURN :comm_id;
$$;