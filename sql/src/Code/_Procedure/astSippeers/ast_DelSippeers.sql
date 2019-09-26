DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelSippeers;
CREATE PROCEDURE ast_DelSippeers(
    $token          VARCHAR(100)
    , $sipID        INT(11)
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelSippeers');
  ELSE
    DELETE FROM ast_sippeers
    WHERE sipID = $sipID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
