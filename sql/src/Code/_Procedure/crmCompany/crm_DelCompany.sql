DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelCompany;
CREATE PROCEDURE crm_DelCompany(
    $token          VARCHAR(100)
    , $coID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_DelCompany');
  ELSE
    DELETE FROM ast_pool_list
    WHERE poolID IN (SELECT poolID FROM ast_pools WHERE coID=$coID AND Aid=$Aid) AND Aid=$Aid;
    --
    DELETE FROM ast_pools
    WHERE coID=$coID AND Aid=$Aid;
    --
    DELETE FROM ast_route_outgoing
    WHERE coID=$coID AND Aid=$Aid;
    --
    DELETE FROM crmCompany
    WHERE coID = $coID AND Aid = $Aid;
    --
    UPDATE ast_trunk SET coID=NULL WHERE coID = $coID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
