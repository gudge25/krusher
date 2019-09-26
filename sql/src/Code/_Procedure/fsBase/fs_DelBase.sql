DELIMITER $$
DROP PROCEDURE IF EXISTS fs_DelBase;
CREATE PROCEDURE fs_DelBase(
    $token        VARCHAR(100)
    , $dbID       int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_DelBase');
  ELSE
    if ($dbID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from fsBase
    where dbID = $dbID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
