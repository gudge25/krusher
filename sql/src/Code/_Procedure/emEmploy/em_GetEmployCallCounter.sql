DROP PROCEDURE IF EXISTS em_GetEmployCallCounter;
DELIMITER $$
CREATE PROCEDURE em_GetEmployCallCounter(
    $token          VARCHAR(100)
    , $DateFrom     DATETIME
    , $DateTo       DATETIME
    , $emIDs        TINYTEXT
    , $sorting      VARCHAR(5)
    , $field        VARCHAR(50)
    , $offset       INT(11)
    , $limit        INT(11)
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $sql1           VARCHAR(5000);
  DECLARE $sql2           VARCHAR(5000);
  DECLARE $sqlMaker       VARCHAR(3000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_GetEmployCallCounter');
  ELSE
    IF ($dateFrom is NULL) THEN
      -- Параметр "Дата от" должен иметь значение
      call RAISE(77016, NULL);
    END IF;
    IF ($DateTo is NULL) THEN
      -- Параметр "Дата до" должен иметь значение
      call RAISE(77017, NULL);
    END IF;
    --
    IF($sorting IS NULL) THEN
      SET $sorting_ = 'DESC';
    ELSE
      SET $sorting_ = $sorting;
    END IF;
    IF($field IS NULL) THEN
      SET $field_ = '`Period`';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    /*SET $dateTo = DATE_ADD($dateTo, INTERVAL 24 HOUR); 22 04 2019*/
    --
    IF (($emIDs is NOT NULL) AND (length(TRIM($emIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $emIDs)>0) OR (LOCATE('false', $emIDs)>0)) THEN
        IF (LOCATE(',', $emIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ', ', ',');
          SET $sqlMaker = REPLACE($sqlMaker, ',true', ') OR cc.emID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR cc.emID != 0');
          SET $emIDs = CONCAT('AND cc.emID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'cc.emID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'cc.emID != 0';
          END IF;
          SET $emIDs = CONCAT(CHAR(10), 'AND ', $sqlMaker);
        END IF;
      ELSE
        SET $emIDs = CONCAT('AND cc.emID IN (', $emIDs, ')');
      END IF;
    ELSE
      SET $emIDs = 'AND 1 = 1';
    END IF;
    --
    CREATE TEMPORARY TABLE IF NOT EXISTS `_counter`(
        `emID` INT(11) NULL DEFAULT '0',
        `Period` DATE NULL DEFAULT NULL,
        `OutFull` INT(11) NULL DEFAULT '0',
        `InFull` INT(11) NULL DEFAULT '0',
        `Full` INT(11) NULL DEFAULT '0',
        `OutAnswered` INT(11) NULL DEFAULT '0',
        `InAnswered` INT(11) NULL DEFAULT '0',
        `Answered` INT(11) NULL DEFAULT '0',
        `OutNoAnswered` INT(11) NULL DEFAULT '0',
        `InNoAnswered` INT(11) NULL DEFAULT '0',
        `NoAnswered` INT(11) NULL DEFAULT '0',
        `Aid` INT(11) NULL,
        INDEX `Period` (`Period`),
        INDEX `Aid` (`Aid`)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
    --
    SET $sql1 = CONCAT('INSERT INTO `_counter`', '
                        SELECT
                          cc.emID                                                           emID
                          , SUBSTR(cc.Created, 1, 10)                                       Period
                          , sum(IF(IsOut=TRUE, 1, 0))                                       OutFull
                          , sum(IF(IsOut=FALSE, 1, 0))                                      InFull
                          , sum(IF(IsOut IS NOT NULL, 1, 0))                                `Full`
                          , sum(IF(IsOut=TRUE AND ccStatus=7001, 1, 0))                     OutAnswered
                          , sum(IF(IsOut=FALSE AND ccStatus=7001, 1, 0))                    InAnswered
                          , sum(IF(ccStatus=7001, 1, 0))                                    Answered
                          , sum(IF(IsOut=TRUE AND ccStatus!=7001, 1, 0))                    OutNoAnswered
                          , sum(IF(IsOut=FALSE AND ccStatus!=7001, 1, 0))                   InNoAnswered
                          , sum(IF(ccStatus!=7001, 1, 0))                                   NoAnswered
                          , ', $Aid,' Aid
                        FROM ccContact cc
                        WHERE cc.Created >= "', $dateFrom, '"
                              AND "', $dateTo, '" >= cc.Created ', $emIDs, '
                              AND cc.Aid = ', $Aid, '
                              AND cc.emID > 0
                              AND cc.CallType != 101320
                        GROUP BY
                          Period
                          , cc.emID;');
    --
    SET @s = CONCAT($sql1);
    /*select @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $sql2 = CONCAT('SELECT emID, Period, OutFull, InFull, `Full`, OutAnswered, InAnswered, Answered, OutNoAnswered, InNoAnswered, NoAnswered FROM `_counter` WHERE Aid = ', $Aid, ' ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit, ';');
    SET @s = CONCAT($sql2);
    /*select @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $sql2 = CONCAT('SELECT count(*) Qty FROM `_counter` WHERE Aid = ', $Aid, ';');
    SET @s = CONCAT($sql2);
    /*select @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    DELETE FROM `_counter` WHERE Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
