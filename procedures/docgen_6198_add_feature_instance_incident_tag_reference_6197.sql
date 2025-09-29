CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6198_add_feature_instance_incident_tag_reference_6197(
  ref_id STRING,
  incident_id STRING,
  tag STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  added_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6197_feature_instance_incident_tag_references_6197(ref_id, incident_id, tag, instance_ref, feature_key, org_id, added_by, added_at)
VALUES(:ref_id, :incident_id, :tag, :instance_ref, :feature_key, :org_id, :added_by, CURRENT_TIMESTAMP());
RETURN :ref_id;
$$;