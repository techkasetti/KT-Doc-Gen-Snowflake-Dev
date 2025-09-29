CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6200_record_feature_instance_incident_tag_removal_6199(
  removal_id STRING,
  ref_id STRING,
  incident_id STRING,
  tag STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  removed_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6199_feature_instance_incident_tag_removals_6199(removal_id, ref_id, incident_id, tag, instance_ref, feature_key, org_id, removed_by, removed_at)
VALUES(:removal_id, :ref_id, :incident_id, :tag, :instance_ref, :feature_key, :org_id, :removed_by, CURRENT_TIMESTAMP());
RETURN :removal_id;
$$;