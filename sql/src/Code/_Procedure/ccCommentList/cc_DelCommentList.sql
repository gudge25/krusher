DELIMITER $$
DROP PROCEDURE IF EXISTS cc_DelCommentList;
CREATE PROCEDURE cc_DelCommentList(
    $token          VARCHAR(100)
    , $comID        INT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_DelCommentList');
  ELSE
    DELETE FROM ccCommentList
    WHERE comID = $comID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
