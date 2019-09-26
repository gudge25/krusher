DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelPoolList;
CREATE PROCEDURE ast_DelPoolList(
    $token          VARCHAR(100)
    , $plID       INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelPoolList');
  ELSE
    DELETE FROM ast_pool_list
    WHERE plID = $plID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
