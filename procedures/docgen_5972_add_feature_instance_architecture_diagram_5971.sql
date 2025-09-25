CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5972_add_feature_instance_architecture_diagram_5971(
  diagram_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  name STRING,
  diagram VARIANT,
  added_by STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5971_feature_instance_architecture_diagrams_5971(diagram_id, instance_ref, feature_key, org_id, name, diagram, added_by, added_at)
VALUES(:diagram_id, :instance_ref, :feature_key, :org_id, :name, :diagram, :added_by, CURRENT_TIMESTAMP());
RETURN :diagram_id;
$$;