CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6094_add_feature_instance_incident_contributor_6093(
  contributor_id STRING,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  contributor STRING,
  role STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6093_feature_instance_incident_contributors_6093(contributor_id, incident_id, review_id, instance_ref, feature_key, org_id, contributor, role, contributed_at)
VALUES(:contributor_id, :incident_id, :review_id, :instance_ref, :feature_key, :org_id, :contributor, :role, CURRENT_TIMESTAMP());
RETURN :contributor_id;
$$;