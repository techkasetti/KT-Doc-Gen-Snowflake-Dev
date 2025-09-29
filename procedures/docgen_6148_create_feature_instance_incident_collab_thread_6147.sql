CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6148_create_feature_instance_incident_collab_thread_6147(
  thread_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  subject STRING,
  created_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6147_feature_instance_incident_collaboration_threads_6147(thread_id, incident_id, instance_ref, feature_key, org_id, subject, created_by, created_at)
VALUES(:thread_id, :incident_id, :instance_ref, :feature_key, :org_id, :subject, :created_by, CURRENT_TIMESTAMP());
RETURN :thread_id;
$$;