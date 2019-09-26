DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsQueueMembers;
CREATE PROCEDURE ast_InsQueueMembers(
  $token          VARCHAR(100)
  , $quemID       INT(11)
  , $emID         INT(11)
  , $queID        INT(11)
  , $membername   VARCHAR(40)
  , $queue_name   VARCHAR(128)
  , $interface    VARCHAR(128)
  , $penalty      INT(11)
  , $paused       INT(11)
  , $isActive     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsQueueMembers');
  ELSE
    INSERT INTO ast_queue_members (
      quemID
      , Aid
      , emID
      , queID
      , membername
      , queue_name
      , interface
      , penalty
      , paused
      , isActive
      , HIID
    )
    VALUES (
      $quemID
      , $Aid
      , $emID
      , $queID
      , $membername
      , $queue_name
      , $interface
      , $penalty
      , $paused
      , $isActive
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
