DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelRecall;
CREATE PROCEDURE ast_DelRecall(
    $token          VARCHAR(100)
    , $rcID         INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelRecall');
  ELSE
    DELETE FROM ast_recall
    WHERE rcID = $rcID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
