DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetQueueClear;
CREATE PROCEDURE ast_GetQueueClear(
  $Aid                            INT(11)
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
  , $isActive                     INT(11)
  , $sorting                      VARCHAR(5)
  , $field                        VARCHAR(50)
  , $offset                       INT(11)
  , $limit                        INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --

  SET $offset = IFNULL($offset, 0);
  SET $limit = IFNULL($limit, 100);
  SET $limit = if($limit > 10000, 10000, $limit);
  SET $sqlWhereCode = 'WHERE ';
  SET $sqlWhere = '';
  --
  IF($sorting IS NULL) THEN
    SET $sorting_ = 'DESC';
  ELSE
    SET $sorting_ = $sorting;
  END IF;
  IF($field IS NULL) THEN
    SET $field_ = '`name`';
  ELSE
    SET $field_ = $field;
  END IF;
  --
  SET $sqlCount = 'SELECT count(*) Qty FROM ast_queues';
  --
  SET $sql = '
          SELECT
            HIID
            , Aid
            , queID
            , `name`
            , timeout
            , retry
            , wrapuptime
            , servicelevel
            , strategy
            , joinempty
            , leavewhenempty
            , memberdelay
            , timeoutrestart
            , ringinuse
            , announce
            , musiconhold
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
            , maxlen
            , eventmemberstatus
            , eventwhencalled
            , reportholdtime
            , weight
            , periodic_announce
            , periodic_announce_frequency
            , setinterfacevar
            , max_wait_time
            , fail_destination
            , fail_destdata
            , fail_destdata2
            , isActive
            , Created
            , Changed
          FROM ast_queues ';
  --
  IF $queID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queID = ', $queID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $name is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, '`name` = ', QUOTE($name));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeout is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeout = ', $timeout);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $monitor_join is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'monitor_join = ', $monitor_join);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $retry is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'retry = ', $retry);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $wrapuptime is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'wrapuptime = ', $wrapuptime);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $servicelevel is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'servicelevel = ', $servicelevel);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $strategy is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'strategy = ', QUOTE($strategy));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $context is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'context = ', QUOTE($context));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $leavewhenempty is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'leavewhenempty = ', QUOTE($leavewhenempty));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $joinempty is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'joinempty = ', QUOTE($joinempty));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $memberdelay is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'memberdelay = ', $memberdelay);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeoutrestart is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeoutrestart = ', $timeoutrestart);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $ringinuse is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ringinuse = ', $ringinuse);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $announce is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'announce = ', QUOTE($announce));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $musiconhold is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'musiconhold = ', QUOTE($musiconhold));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_youarenext is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_youarenext = ', QUOTE($queue_youarenext));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_thereare is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_thereare = ', QUOTE($queue_thereare));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_callswaiting is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_callswaiting = ', QUOTE($queue_callswaiting));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_holdtime is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_holdtime = ', QUOTE($queue_holdtime));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_minutes is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_minutes = ', QUOTE($queue_minutes));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_seconds is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_seconds = ', QUOTE($queue_seconds));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_lessthan is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_lessthan = ', QUOTE($queue_lessthan));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_thankyou is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_thankyou = ', QUOTE($queue_thankyou));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $queue_reporthold is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'queue_reporthold = ', QUOTE($queue_reporthold));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $announce_holdtime is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'announce_holdtime = ', QUOTE($announce_holdtime));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $periodic_announce is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'periodic_announce = ', QUOTE($periodic_announce));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $monitor_format is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'monitor_format = ', QUOTE($monitor_format));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $announce_frequency is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'announce_frequency = ', $announce_frequency);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $announce_round_seconds is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'announce_round_seconds = ', $announce_round_seconds);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $maxlen is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'maxlen = ', $maxlen);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $eventmemberstatus is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'eventmemberstatus = ', $eventmemberstatus);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $eventwhencalled is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'eventwhencalled = ', $eventwhencalled);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $reportholdtime is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'reportholdtime = ', $reportholdtime);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $weight is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'weight = ', $weight);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $periodic_announce_frequency is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'periodic_announce_frequency = ', $periodic_announce_frequency);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $setinterfacevar is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'setinterfacevar = ', $setinterfacevar);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $Aid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $isActive is NOT NULL THEN
    IF $isActive = TRUE THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  --
  SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), $sqlWhereCode, ' Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  --
  SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
--
