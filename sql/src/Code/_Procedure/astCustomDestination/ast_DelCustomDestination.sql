DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelCustomDestination;
CREATE PROCEDURE ast_DelCustomDestination(
    $token          VARCHAR(100)
    , $cdID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelCustomDestination');
  ELSE
    DELETE FROM ast_custom_destination
    WHERE cdID = $cdID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
