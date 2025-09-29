CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6170_send_feature_instance_incident_summary_email_6169(
  email_id STRING,
  review_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  recipients ARRAY,
  subject STRING,
  body VARIANT,
  sent_by STRING,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6169_feature_instance_incident_summary_emails_6169(email_id, review_id, incident_id, instance_ref, feature_key, org_id, recipients, subject, body, sent_by, sent_at, status)
VALUES(:email_id, :review_id, :incident_id, :instance_ref, :feature_key, :org_id, :recipients, :subject, :body, :sent_by, CURRENT_TIMESTAMP(), :status);
RETURN :email_id;
$$;