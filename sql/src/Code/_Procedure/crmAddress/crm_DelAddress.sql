DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelAddress;
CREATE PROCEDURE crm_DelAddress(
    $token          VARCHAR(100)
    , $adsID        INT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_DelAddress');
  ELSE
    if ($adsID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    DELETE FROM crmAddress
    WHERE adsID = $adsID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
