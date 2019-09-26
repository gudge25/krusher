DELIMITER $$
DROP PROCEDURE IF EXISTS us_DelComment;
CREATE PROCEDURE us_DelComment(
    $token            VARCHAR(100)
    , $id             int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_DelComment');
  ELSE
    if ($id is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from usComment
    where id = $id AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
