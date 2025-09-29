CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6158_upsert_feature_instance_incident_archival_policy_6157(
  policy_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  policy_spec VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6157_feature_instance_incident_archival_policies_6157 tgt
USING (SELECT :policy_id AS policy_id) src
ON tgt.policy_id = src.policy_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, policy_spec = :policy_spec, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(policy_id, instance_ref, feature_key, org_id, policy_spec, created_at)
VALUES(:policy_id, :instance_ref, :feature_key, :org_id, :policy_spec, CURRENT_TIMESTAMP());
RETURN :policy_id;
$$;
