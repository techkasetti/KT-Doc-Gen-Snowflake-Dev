CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6166_record_feature_instance_incident_kpi_6165(
  kpi_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  kpi_key STRING,
  kpi_value NUMBER
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6165_feature_instance_incident_kpis_6165(kpi_id, incident_id, instance_ref, feature_key, org_id, kpi_key, kpi_value, recorded_at)
VALUES(:kpi_id, :incident_id, :instance_ref, :feature_key, :org_id, :kpi_key, :kpi_value, CURRENT_TIMESTAMP());
RETURN :kpi_id;
$$;