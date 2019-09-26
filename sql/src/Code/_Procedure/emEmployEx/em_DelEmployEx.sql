DELIMITER $$
DROP PROCEDURE IF EXISTS em_DelEmployEx;
CREATE PROCEDURE em_DelEmployEx(
    $token        VARCHAR(100)
    , $emID       int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_DelEmployEx');
  ELSE
    if $emID is NULL then
      -- Параметр "ID сотрудника" должен иметь значение
      call RAISE(77007,NULL);
    end if;
    --
    delete from emEmployEx
    where emID = $emID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
