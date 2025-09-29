CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6060_record_feature_instance_incident_ownership_hist_6059(
  hist_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  owner STRING,
  assigned_by STRING,
  notes VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6059_feature_instance_incident_ownership_hist_6059(hist_id, incident_id, instance_ref, feature_key, org_id, owner, assigned_by, assigned_at, notes)
VALUES(:hist_id, :incident_id, :instance_ref, :feature_key, :org_id, :owner, :assigned_by, CURRENT_TIMESTAMP(), :notes);
RETURN :hist_id;
$$;