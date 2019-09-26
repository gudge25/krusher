DELIMITER $$
DROP PROCEDURE IF EXISTS us_DelRank;
CREATE PROCEDURE us_DelRank(
    $token            VARCHAR(100)
    , $id             VARCHAR(20)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_DelRank');
  ELSE
    if ($id is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    DELETE FROM usRank
    WHERE uID = $id AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
