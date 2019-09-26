DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdQueueMembers;
CREATE PROCEDURE ast_UpdQueueMembers(
    $token          VARCHAR(100)
    , $HIID         BIGINT
    , $quemID       INT(11)
    , $emID         INT(11)
    , $queID        INT(11)
    , $membername   VARCHAR(40)
    , $queue_name   VARCHAR(128)
    , $interface    VARCHAR(128)
    , $penalty      INT(11)
    , $paused       INT(11)
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdQueueMembers');
  ELSE
    if not exists (
      select 1
      from ast_queue_members
      where HIID = $HIID
        and quemID = $quemID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_queue_members SET
      emID            = $emID
      , queID         = $queID
      , membername    = $membername
      , queue_name    = $queue_name
      , interface     = $interface
      , penalty       = $penalty
      , paused        = $paused
      , isActive      = $isActive
      , HIID          = fn_GetStamp()
    WHERE quemID = $quemID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
