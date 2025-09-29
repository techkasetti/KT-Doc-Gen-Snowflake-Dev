CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6172_upsert_feature_instance_postmortem_workflow_6171(
  workflow_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  workflow_spec VARIANT,
  active BOOLEAN
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_6171_feature_instance_incident_postmortem_workflows_6171 tgt
USING (SELECT :workflow_id AS workflow_id) src
ON tgt.workflow_id = src.workflow_id
WHEN MATCHED THEN UPDATE SET review_id = :review_id, instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, workflow_spec = :workflow_spec, active = :active, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(workflow_id, review_id, instance_ref, feature_key, org_id, workflow_spec, active, created_at)
VALUES(:workflow_id, :review_id, :instance_ref, :feature_key, :org_id, :workflow_spec, :active, CURRENT_TIMESTAMP());
RETURN :workflow_id;
$$;