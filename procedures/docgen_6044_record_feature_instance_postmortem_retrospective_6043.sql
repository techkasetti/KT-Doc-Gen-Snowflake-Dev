CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6044_record_feature_instance_postmortem_retrospective_6043(
  retro_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  notes VARIANT,
  conducted_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6043_feature_instance_postmortem_retrospectives_6043(retro_id, review_id, instance_ref, feature_key, org_id, notes, conducted_by, conducted_at)
VALUES(:retro_id, :review_id, :instance_ref, :feature_key, :org_id, :notes, :conducted_by, CURRENT_TIMESTAMP());
RETURN :retro_id;
$$;