DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdQueue;
CREATE PROCEDURE ast_UpdQueue(
  $token                          VARCHAR(100)
  , $HIID                         BIGINT
  , $queID                        INT(11)
  , $name                         VARCHAR(128)
  , $musiconhold                  VARCHAR(128)
  , $announce                     VARCHAR(128)
  , $context                      VARCHAR(128)
  , $timeout                      INT(11)
  , $monitor_join                 INT(11)
  , $monitor_format               VARCHAR(128)
  , $queue_youarenext             VARCHAR(128)
  , $queue_thereare               VARCHAR(128)
  , $queue_callswaiting           VARCHAR(128)
  , $queue_holdtime               VARCHAR(128)
  , $queue_minutes                VARCHAR(128)
  , $queue_seconds                VARCHAR(128)
  , $queue_lessthan               VARCHAR(128)
  , $queue_thankyou               VARCHAR(128)
  , $queue_reporthold             VARCHAR(128)
  , $announce_frequency           INT(11)
  , $announce_round_seconds       INT(11)
  , $announce_holdtime            VARCHAR(128)
  , $retry                        INT(11)
  , $wrapuptime                   INT(11)
  , $maxlen                       INT(11)
  , $servicelevel                 INT(11)
  , $strategy                     VARCHAR(128)
  , $joinempty                    VARCHAR(128)
  , $leavewhenempty               VARCHAR(128)
  , $eventmemberstatus            TINYINT(1)
  , $eventwhencalled              TINYINT(1)
  , $reportholdtime               TINYINT(1)
  , $memberdelay                  INT(11)
  , $weight                       INT(11)
  , $timeoutrestart               TINYINT(1)
  , $periodic_announce            VARCHAR(50)
  , $periodic_announce_frequency  INT(11)
  , $ringinuse                    TINYINT(1)
  , $setinterfacevar              TINYINT(1)
  , $max_wait_time                INT(11)
  , $fail_destination             INT(11)
  , $fail_destdata                INT(11)
  , $fail_destdata2               VARCHAR(100)
  , $isActive                     INT(11)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdQueue');
  ELSE
    if not exists (
      select 1
      from ast_queues
      where HIID = $HIID
        and queID = $queID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_queues SET
      `name`                            = $name
      , musiconhold                     = $musiconhold
      , announce                        = $announce
      , context                         = $context
      , timeout                         = $timeout
      , monitor_join                    = $monitor_join
      , monitor_format                  = $monitor_format
      , queue_youarenext                = $queue_youarenext
      , queue_thereare                  = $queue_thereare
      , queue_callswaiting              = $queue_callswaiting
      , queue_holdtime                  = $queue_holdtime
      , queue_minutes                   = $queue_minutes
      , queue_seconds                   = $queue_seconds
      , queue_lessthan                  = $queue_lessthan
      , queue_thankyou                  = $queue_thankyou
      , queue_reporthold                = $queue_reporthold
      , announce_frequency              = $announce_frequency
      , announce_round_seconds          = $announce_round_seconds
      , announce_holdtime               = $announce_holdtime
      , retry                           = $retry
      , wrapuptime                      = $wrapuptime
      , maxlen                          = $maxlen
      , servicelevel                    = $servicelevel
      , strategy                        = $strategy
      , joinempty                       = $joinempty
      , leavewhenempty                  = $leavewhenempty
      , eventmemberstatus               = $eventmemberstatus
      , eventwhencalled                 = $eventwhencalled
      , reportholdtime                  = $reportholdtime
      , memberdelay                     = $memberdelay
      , weight                          = $weight
      , timeoutrestart                  = $timeoutrestart
      , periodic_announce               = $periodic_announce
      , periodic_announce_frequency     = $periodic_announce_frequency
      , ringinuse                       = $ringinuse
      , setinterfacevar                 = $setinterfacevar
      , isActive                        = $isActive
      , HIID                            = fn_GetStamp()
      , max_wait_time                   = $max_wait_time
      , fail_destination                = $fail_destination
      , fail_destdata                   = $fail_destdata
      , fail_destdata2                  = $fail_destdata2
    WHERE queID = $queID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
