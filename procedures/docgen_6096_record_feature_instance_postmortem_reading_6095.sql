CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6096_record_feature_instance_postmortem_reading_6095(
  reading_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  type STRING,
  payload VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6095_feature_instance_postmortem_readings_6095(reading_id, review_id, instance_ref, feature_key, org_id, type, payload, recorded_at)
VALUES(:reading_id, :review_id, :instance_ref, :feature_key, :org_id, :type, :payload, CURRENT_TIMESTAMP());
RETURN :reading_id;
$$;