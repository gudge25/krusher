DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelCallback;
CREATE PROCEDURE ast_DelCallback(
    $token          VARCHAR(100)
    , $cbID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelCallback');
  ELSE
    DELETE FROM ast_callback
    WHERE cbID = $cbID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
