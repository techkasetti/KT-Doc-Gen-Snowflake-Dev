CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5946_upsert_feature_instance_incident_metric_definition_5945(
  metric_def_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  metric_key STRING,
  metric_def VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
MERGE INTO AI_FEATURE_HUB.docgen_5945_feature_instance_incident_metrics_definitions_5945 tgt
USING (SELECT :metric_def_id AS metric_def_id) src
ON tgt.metric_def_id = src.metric_def_id
WHEN MATCHED THEN UPDATE SET instance_ref = :instance_ref, feature_key = :feature_key, org_id = :org_id, metric_key = :metric_key, metric_def = :metric_def, created_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT(metric_def_id, instance_ref, feature_key, org_id, metric_key, metric_def, created_at)
VALUES(:metric_def_id, :instance_ref, :feature_key, :org_id, :metric_key, :metric_def, CURRENT_TIMESTAMP());
RETURN :metric_def_id;
$$;