DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsQueue;
CREATE PROCEDURE ast_InsQueue(
  $token                          VARCHAR(100)
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
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsQueue');
  ELSE
    INSERT INTO ast_queues (
      queID
      , Aid
      , name
      , musiconhold
      , announce
      , context
      , timeout
      , monitor_join
      , monitor_format
      , queue_youarenext
      , queue_thereare
      , queue_callswaiting
      , queue_holdtime
      , queue_minutes
      , queue_seconds
      , queue_lessthan
      , queue_thankyou
      , queue_reporthold
      , announce_frequency
      , announce_round_seconds
      , announce_holdtime
      , retry
      , wrapuptime
      , maxlen
      , servicelevel
      , strategy
      , joinempty
      , leavewhenempty
      , eventmemberstatus
      , eventwhencalled
      , reportholdtime
      , memberdelay
      , weight
      , timeoutrestart
      , periodic_announce
      , periodic_announce_frequency
      , ringinuse
      , setinterfacevar
      , isActive
      , HIID
      , max_wait_time
      , fail_destination
      , fail_destdata
      , fail_destdata2
    )
    VALUES (
      $queID
      , $Aid
      , $name
      , $musiconhold
      , $announce
      , $context
      , $timeout
      , $monitor_join
      , $monitor_format
      , $queue_youarenext
      , $queue_thereare
      , $queue_callswaiting
      , $queue_holdtime
      , $queue_minutes
      , $queue_seconds
      , $queue_lessthan
      , $queue_thankyou
      , $queue_reporthold
      , $announce_frequency
      , $announce_round_seconds
      , $announce_holdtime
      , $retry
      , $wrapuptime
      , $maxlen
      , $servicelevel
      , $strategy
      , $joinempty
      , $leavewhenempty
      , $eventmemberstatus
      , $eventwhencalled
      , $reportholdtime
      , $memberdelay
      , $weight
      , $timeoutrestart
      , $periodic_announce
      , $periodic_announce_frequency
      , $ringinuse
      , $setinterfacevar
      , $isActive
      , fn_GetStamp()
      , $max_wait_time
      , $fail_destination
      , $fail_destdata
      , $fail_destdata2
    );
  END IF;
END $$
DELIMITER ;
--
