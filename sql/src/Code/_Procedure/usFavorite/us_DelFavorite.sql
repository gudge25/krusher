DROP PROCEDURE IF EXISTS us_DelFavorite;
DELIMITER $$
CREATE PROCEDURE us_DelFavorite(
    $token            VARCHAR(100)
    , $uID            VARCHAR(20)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_DelFavorite');
  ELSE
    IF ($uID is NULL) THEN
      -- Параметр "ID записи" должен иметь значение
      CALL RAISE(77021,NULL);
    END IF;
    --
    DELETE FROM usFavorite
    WHERE uID = $uID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
