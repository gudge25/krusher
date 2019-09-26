DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelQueueMembers;
CREATE PROCEDURE ast_DelQueueMembers(
    $token        VARCHAR(100)
    , $quemID     INT(11)
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelQueueMembers');
  ELSE
    DELETE FROM ast_queue_members
    WHERE quemID = $quemID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
