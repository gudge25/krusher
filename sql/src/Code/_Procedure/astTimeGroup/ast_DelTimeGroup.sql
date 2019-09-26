DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelTimeGroup;
CREATE PROCEDURE ast_DelTimeGroup(
    $token          VARCHAR(100)
    , $tgID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelTimeGroup');
  ELSE
    DELETE FROM ast_time_group
    WHERE tgID = $tgID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
