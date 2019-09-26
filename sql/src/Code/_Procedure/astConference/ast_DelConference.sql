DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelConference;
CREATE PROCEDURE ast_DelConference(
    $token          VARCHAR(100)
    , $cfID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelConference');
  ELSE
    DELETE FROM ast_conference
    WHERE cfID = $cfID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
