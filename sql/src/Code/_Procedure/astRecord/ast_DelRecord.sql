DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelRecord;
CREATE PROCEDURE ast_DelRecord(
    $token        VARCHAR(100)
    , $record_id  INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelRecord');
  ELSE
    DELETE FROM ast_record
    WHERE record_id = $record_id AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
