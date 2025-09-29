CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6168_compute_feature_instance_incident_kpi_rollup_6167(
  rollup_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  rollup_spec VARIANT,
  rollup_result VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6167_feature_instance_incident_kpi_rollups_6167(rollup_id, incident_id, instance_ref, feature_key, org_id, rollup_spec, rollup_result, computed_at)
VALUES(:rollup_id, :incident_id, :instance_ref, :feature_key, :org_id, :rollup_spec, :rollup_result, CURRENT_TIMESTAMP());
RETURN :rollup_id;
$$;