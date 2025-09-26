CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5990_record_feature_instance_third_party_incident_mapping_5989(
  mapping_id STRING,
  incident_id STRING,
  external_incident_id STRING,
  provider STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  details VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5989_feature_instance_third_party_incident_mappings_5989(mapping_id, incident_id, external_incident_id, provider, instance_ref, feature_key, org_id, mapped_at, details)
VALUES(:mapping_id, :incident_id, :external_incident_id, :provider, :instance_ref, :feature_key, :org_id, CURRENT_TIMESTAMP(), :details);
RETURN :mapping_id;
$$;