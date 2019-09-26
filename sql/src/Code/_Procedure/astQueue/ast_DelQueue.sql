DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelQueue;
CREATE PROCEDURE ast_DelQueue(
    $token        VARCHAR(100)
    , $queID      INT(11)
)
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelQueue');
  ELSE
    DELETE FROM ast_queue_members
    WHERE queID = $queID AND Aid = $Aid;
    --
    DELETE FROM ast_queues
    WHERE queID = $queID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
