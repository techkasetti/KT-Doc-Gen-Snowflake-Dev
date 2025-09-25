CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5942_add_feature_instance_incident_followup_5941(
  followup_id STRING,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  followup_text VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5941_feature_instance_incident_followups_5941(followup_id, incident_id, review_id, instance_ref, feature_key, org_id, followup_text, created_by, created_at)
VALUES(:followup_id, :incident_id, :review_id, :instance_ref, :feature_key, :org_id, :followup_text, :created_by, CURRENT_TIMESTAMP());
RETURN :followup_id;
$$;