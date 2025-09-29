CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6042_record_feature_instance_incident_learning_item_update_6041(
  update_id STRING,
  item_id STRING,
  review_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  updated_by STRING,
  update_notes VARIANT,
  new_status STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6041_feature_instance_incident_learning_item_updates_6041(update_id, item_id, review_id, instance_ref, feature_key, org_id, updated_by, update_notes, updated_at, new_status)
VALUES(:update_id, :item_id, :review_id, :instance_ref, :feature_key, :org_id, :updated_by, :update_notes, CURRENT_TIMESTAMP(), :new_status);
UPDATE AI_FEATURE_HUB.docgen_6039_feature_instance_incident_learning_items_6039
SET status = :new_status
WHERE item_id = :item_id AND org_id = :org_id;
RETURN :update_id;
$$;