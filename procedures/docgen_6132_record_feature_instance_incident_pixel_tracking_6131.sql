CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6132_record_feature_instance_incident_pixel_tracking_6131(
  tracking_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  pixel_context VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6131_feature_instance_incident_pixel_tracking_6131(tracking_id, incident_id, instance_ref, feature_key, org_id, pixel_context, recorded_at)
VALUES(:tracking_id, :incident_id, :instance_ref, :feature_key, :org_id, :pixel_context, CURRENT_TIMESTAMP());
RETURN :tracking_id;
$$;