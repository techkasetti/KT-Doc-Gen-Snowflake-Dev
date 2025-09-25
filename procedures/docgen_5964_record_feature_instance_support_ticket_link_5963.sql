CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_5964_record_feature_instance_support_ticket_link_5963(
  link_id STRING,
  incident_id STRING,
  ticket_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  link_meta VARIANT
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_5963_feature_instance_support_ticket_links_5963(link_id, incident_id, ticket_id, instance_ref, feature_key, org_id, link_meta, linked_at)
VALUES(:link_id, :incident_id, :ticket_id, :instance_ref, :feature_key, :org_id, :link_meta, CURRENT_TIMESTAMP());
RETURN :link_id;
$$;