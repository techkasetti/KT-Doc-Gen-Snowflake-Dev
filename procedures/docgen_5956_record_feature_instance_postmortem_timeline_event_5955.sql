CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5956_record_feature_instance_postmortem_timeline_event_5955(
  event_id STRING,
  review_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  event_time TIMESTAMP_LTZ,
  event_payload VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5955_feature_instance_postmortem_timeline_events_5955(event_id, review_id, incident_id, instance_ref, feature_key, org_id, event_time, event_payload, recorded_at)
VALUES(:event_id, :review_id, :incident_id, :instance_ref, :feature_key, :org_id, :event_time, :event_payload, CURRENT_TIMESTAMP());
RETURN :event_id;
$$;