CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6040_create_feature_instance_incident_learning_item_6039(
  item_id STRING,
  review_id STRING,
  incident_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  description VARIANT,
  owner STRING,
  status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6039_feature_instance_incident_learning_items_6039(item_id, review_id, incident_id, instance_ref, feature_key, org_id, description, owner, created_at, status)
VALUES(:item_id, :review_id, :incident_id, :instance_ref, :feature_key, :org_id, :description, :owner, CURRENT_TIMESTAMP(), :status);
RETURN :item_id;
$$;