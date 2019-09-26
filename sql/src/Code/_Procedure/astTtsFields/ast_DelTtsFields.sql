DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelTtsFields;
CREATE PROCEDURE ast_DelTtsFields(
    $token            VARCHAR(100)
    , $ttsfID           int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelTtsFields');
  ELSE
    if ($ttsfID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    DELETE FROM ast_tts_fields
    WHERE ttsfID = $ttsfID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
