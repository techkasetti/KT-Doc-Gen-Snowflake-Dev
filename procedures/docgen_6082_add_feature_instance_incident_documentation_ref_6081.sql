CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6082_add_feature_instance_incident_documentation_ref_6081(
  doc_ref_id STRING,
  incident_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  url STRING,
  description STRING,
  added_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6081_feature_instance_incident_documentation_refs_6081(doc_ref_id, incident_id, review_id, instance_ref, feature_key, org_id, url, description, added_by, added_at)
VALUES(:doc_ref_id, :incident_id, :review_id, :instance_ref, :feature_key, :org_id, :url, :description, :added_by, CURRENT_TIMESTAMP());
RETURN :doc_ref_id;
$$;