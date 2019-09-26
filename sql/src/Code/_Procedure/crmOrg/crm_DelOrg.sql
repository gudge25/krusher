DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelOrg;
CREATE PROCEDURE crm_DelOrg(
    $token        VARCHAR(100)
    , $clID       INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_DelOrg');
  ELSE
    if $clID is NULL then
      -- 'Параметр ID клиента должен иметь значение';
      call raise(77004, NULL);
    end if;
    --
    delete from crmOrg
    where clID = $clID AND Aid = $Aid;
    if ROW_COUNT() = -1 then
      call raise(60006, 'crmOrg');
    end if;
  END IF;
END $$
DELIMITER ;
--
