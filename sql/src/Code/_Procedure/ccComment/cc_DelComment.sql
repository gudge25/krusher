DELIMITER $$
DROP PROCEDURE IF EXISTS cc_DelComment;
CREATE PROCEDURE cc_DelComment(
    $token          VARCHAR(100)
    , $cccID        INT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_DelComment');
  ELSE
    DELETE FROM ccComment
    WHERE cccID = $cccID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
