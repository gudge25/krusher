DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelTag;
CREATE PROCEDURE crm_DelTag(
    $token        VARCHAR(100)
    , $tagID      INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_DelTag');
  ELSE
    if ($tagID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from crmTag
    where tagID = $tagID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
