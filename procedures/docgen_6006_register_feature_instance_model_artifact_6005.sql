CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6006_register_feature_instance_model_artifact_6005(
  artifact_id STRING,
  model_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  artifact_meta VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6005_feature_instance_model_artifact_refs_6005(artifact_id, model_id, instance_ref, feature_key, org_id, artifact_meta, stored_at)
VALUES(:artifact_id, :model_id, :instance_ref, :feature_key, :org_id, :artifact_meta, CURRENT_TIMESTAMP());
RETURN :artifact_id;
$$;
