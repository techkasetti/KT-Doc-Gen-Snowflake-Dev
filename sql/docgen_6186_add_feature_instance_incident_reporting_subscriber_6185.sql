CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6186_add_feature_instance_incident_reporting_subscriber_6185(
  subscriber_id STRING,
  report_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  recipient STRING,
  channel STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6185_feature_instance_incident_reporting_subscribers_6185(subscriber_id, report_id, instance_ref, feature_key, org_id, recipient, channel, subscribed_at)
VALUES(:subscriber_id, :report_id, :instance_ref, :feature_key, :org_id, :recipient, :channel, CURRENT_TIMESTAMP());
RETURN :subscriber_id;
$$;