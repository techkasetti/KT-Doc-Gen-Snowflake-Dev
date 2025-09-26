CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6000_record_feature_instance_incident_training_example_5999(
  example_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  input VARIANT,
  label VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5999_feature_instance_incident_training_examples_5999(example_id, incident_id, instance_ref, feature_key, org_id, input, label, created_at)
VALUES(:example_id, :incident_id, :instance_ref, :feature_key, :org_id, :input, :label, CURRENT_TIMESTAMP());
RETURN :example_id;
$$;