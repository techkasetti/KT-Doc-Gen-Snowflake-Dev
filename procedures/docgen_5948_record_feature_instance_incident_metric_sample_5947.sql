CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5948_record_feature_instance_incident_metric_sample_5947(
  sample_id STRING,
  metric_def_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  metric_key STRING,
  metric_value NUMBER
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5947_feature_instance_incident_metric_samples_5947(sample_id, metric_def_id, incident_id, instance_ref, feature_key, org_id, metric_key, metric_value, collected_at)
VALUES(:sample_id, :metric_def_id, :incident_id, :instance_ref, :feature_key, :org_id, :metric_key, :metric_value, CURRENT_TIMESTAMP());
RETURN :sample_id;
$$;
