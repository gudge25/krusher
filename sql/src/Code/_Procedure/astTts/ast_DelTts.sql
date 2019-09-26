DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelTts;
CREATE PROCEDURE ast_DelTts(
    $token          VARCHAR(100)
    , $ttsID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelTts');
  ELSE
    DELETE FROM ast_tts
    WHERE ttsID = $ttsID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
