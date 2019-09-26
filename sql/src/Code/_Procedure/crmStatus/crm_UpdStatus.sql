DELIMITER $$
DROP PROCEDURE IF EXISTS crm_UpdStatus;
CREATE PROCEDURE crm_UpdStatus (
    $token        VARCHAR(100)
    , $clID       INT
    , $clStatus   INT
    , $isFixed    BIT
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Обновляет статусы клиента'
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdStatus');
  ELSE
    UPDATE crmStatus SET
      clStatus = if($isFixed = 1, $clStatus, (SELECT crm_IPGetClientStatus($clID)))
      , isFixed  = $isFixed
  WHERE clID = $clID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
