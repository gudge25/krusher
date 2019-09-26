DELIMITER $$
DROP PROCEDURE IF EXISTS st_DelCategory;
CREATE PROCEDURE st_DelCategory(
    $token        VARCHAR(100)
    , $pctID      int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'st_DelCategory');
  ELSE
    if ($pctID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from stCategory
    where pctID = $pctID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
