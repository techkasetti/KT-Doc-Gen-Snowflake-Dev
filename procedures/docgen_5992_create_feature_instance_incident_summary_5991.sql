CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5992_create_feature_instance_incident_summary_5991(
  summary_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  title STRING,
  summary VARIANT,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5991_feature_instance_incident_summaries_5991(summary_id, incident_id, instance_ref, feature_key, org_id, title, summary, created_by, created_at)
VALUES(:summary_id, :incident_id, :instance_ref, :feature_key, :org_id, :title, :summary, :created_by, CURRENT_TIMESTAMP());
RETURN :summary_id;
$$;