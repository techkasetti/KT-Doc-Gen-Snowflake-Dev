CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5944_add_feature_instance_postmortem_participant_5943(
  participant_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  participant STRING,
  role STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5943_feature_instance_postmortem_participants_5943(participant_id, review_id, instance_ref, feature_key, org_id, participant, role, added_at)
VALUES(:participant_id, :review_id, :instance_ref, :feature_key, :org_id, :participant, :role, CURRENT_TIMESTAMP());
RETURN :participant_id;
$$;
