CREATE OR REPLACE PROCEDURE AI_FEATURE_HUB.proc_docgen_6018_create_feature_instance_compliance_exception_6017(
  exception_id STRING,
  check_id STRING,
  instance_ref STRING,
  feature_key STRING,
  org_id STRING,
  requester STRING,
  reason VARIANT,
  approved BOOLEAN,
  decision_by STRING,
  decision_at TIMESTAMP_LTZ
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO AI_FEATURE_HUB.docgen_6017_feature_instance_compliance_exceptions_6017(exception_id, check_id, instance_ref, feature_key, org_id, requester, reason, approved, decision_by, decision_at, created_at)
VALUES(:exception_id, :check_id, :instance_ref, :feature_key, :org_id, :requester, :reason, :approved, :decision_by, :decision_at, CURRENT_TIMESTAMP());
RETURN :exception_id;
$$;