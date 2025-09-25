CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5974_record_feature_instance_architecture_change_5973(
  change_id STRING,
  diagram_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  change_summary VARIANT,
  changed_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5973_feature_instance_architecture_changes_5973(change_id, diagram_id, instance_ref, feature_key, org_id, change_summary, changed_by, changed_at)
VALUES(:change_id, :diagram_id, :instance_ref, :feature_key, :org_id, :change_summary, :changed_by, CURRENT_TIMESTAMP());
RETURN :change_id;
$$;