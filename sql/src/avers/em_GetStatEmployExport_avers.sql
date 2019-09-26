DROP PROCEDURE IF EXISTS em_GetStatEmployExport;
DELIMITER $$
CREATE PROCEDURE em_GetStatEmployExport(
    $token          VARCHAR(100)
    , $DateFrom     DATETIME
    , $DateTo       DATETIME
    , $emIDs        TINYTEXT
    , $Step         INT
    , $disposition  INT
    , $dctID        INT
    , $IsOut        BIT
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $sql1           VARCHAR(5000);
  DECLARE $sql2           VARCHAR(5000);
  DECLARE $sqlMaker       VARCHAR(3000);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_GetStatEmployExport');
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
    SET $step = IFNULL($step, 2);
    SET $disposition = NULLIF(TRIM($disposition), '');
    -- SET $dateTo = DATE_ADD($dateTo, INTERVAL 24 HOUR);
    --
    if(($step = 1) AND ((TO_DAYS($DateTo) - TO_DAYS($DateFrom)) > 1 ))THEN
      call RAISE(77107, NULL);
    ELSEIF(($step = 2) AND ((TO_DAYS($DateTo) - TO_DAYS($DateFrom)) > 32)) THEN
      call RAISE(77108, NULL);
    ELSEIF(($step = 3) AND ((TO_DAYS($DateTo) - TO_DAYS($DateFrom)) > 367)) THEN
      call RAISE(77109, NULL);
    ELSE
      IF (TO_DAYS($DateFrom) - TO_DAYS($DateTo)) > 5*367 THEN
        call RAISE(77110, NULL);
      END IF;
    END IF;
    --
    IF (($emIDs is NOT NULL) AND (length(TRIM($emIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $emIDs)>0) OR (LOCATE('false', $emIDs)>0)) THEN
        IF (LOCATE(',', $emIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ', ', ',');
          SET $sqlMaker = REPLACE($sqlMaker, ',true', ') OR ee.emID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR ee.emID != 0');
          SET $emIDs = CONCAT('AND ee.emID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'ee.emID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'ee.emID != 0';
          END IF;
          SET $emIDs = CONCAT(CHAR(10), 'AND ', $sqlMaker);
        END IF;
      ELSE
        SET $emIDs = CONCAT('AND ee.emID IN (', $emIDs, ')');
      END IF;
    ELSE
      SET $emIDs = 'AND 1 = 1';
    END IF;
    --
    IF($step = 1) THEN
      CREATE TEMPORARY TABLE IF NOT EXISTS `dashboard_datetime`(
          `emID` INT(11) NULL DEFAULT '0',
          `emName` VARCHAR(50) NULL,
          `disposition` VARCHAR(50) NULL,
          `IsOut` BIT(1) NULL DEFAULT NULL COMMENT 'исходящий или входящий',
          `QtyCall` INT(11) NULL,
          `Period` DATETIME NULL DEFAULT NULL,
          `MonthPeriod` INT(11) NULL DEFAULT NULL,
          `YearPeriod` INT(11) NULL DEFAULT NULL,
          `qtyVoiceMin` VARCHAR(10) NULL,
          `avgVoiceMin` VARCHAR(10) NULL,
          `avgWaitMin` VARCHAR(10) NULL,
          `avgBillMin` VARCHAR(10) NULL,
          `Aid` INT(11) NULL,
          INDEX `Period` (`Period`),
          INDEX `Aid` (`Aid`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
    ELSEIF($step = 2) THEN
      CREATE TEMPORARY TABLE IF NOT EXISTS `dashboard_date`(
          `emID` INT(11) NULL DEFAULT '0',
          `emName` VARCHAR(50) NULL,
          `disposition` VARCHAR(50) NULL,
          `IsOut` BIT(1) NULL DEFAULT NULL COMMENT 'исходящий или входящий',
          `QtyCall` INT(11) NULL,
          `Period` DATE NULL DEFAULT NULL,
          `MonthPeriod` INT(11) NULL DEFAULT NULL,
          `YearPeriod` INT(11) NULL DEFAULT NULL,
          `qtyVoiceMin` VARCHAR(10) NULL,
          `avgVoiceMin` VARCHAR(10) NULL,
          `avgWaitMin` VARCHAR(10) NULL,
          `avgBillMin` VARCHAR(10) NULL,
          `Aid` INT(11) NULL,
          INDEX `Period` (`Period`),
          INDEX `Aid` (`Aid`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
    ELSE
      CREATE TEMPORARY TABLE IF NOT EXISTS `dashboard_step`(
          `emID` INT(11) NULL DEFAULT '0',
          `emName` VARCHAR(50) NULL,
          `disposition` VARCHAR(50) NULL,
          `IsOut` BIT(1) NULL DEFAULT NULL COMMENT 'исходящий или входящий',
          `QtyCall` INT(11) NULL,
          `Period` INT(11) NULL DEFAULT NULL,
          `MonthPeriod` INT(11) NULL DEFAULT NULL,
          `YearPeriod` INT(11) NULL DEFAULT NULL,
          `qtyVoiceMin` VARCHAR(10) NULL,
          `avgVoiceMin` VARCHAR(10) NULL,
          `avgWaitMin` VARCHAR(10) NULL,
          `avgBillMin` VARCHAR(10) NULL,
          `Aid` INT(11) NULL,
          INDEX `Period` (`Period`),
          INDEX `Aid` (`Aid`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
    END IF;
    --
    SET $sql1 = CONCAT('INSERT INTO ', IF($step = 1, '`dashboard_datetime`', IF($step = 2, '`dashboard_date`', '`dashboard_step`')), '
      SELECT
      ee.emID                                                           emID
      , ee.emName                                                       emName
      , us.Name                                                         disposition
      , cc.IsOut                                                        IsOut
      , COUNT(cc.dcID)                                                  QtyCall
      , ', IF($step = 1, CONCAT('CONCAT(SUBSTRING(cc.Created, 1, 13), ":00:00") Period   # почасово'), IF($step = 2, 'SUBSTR(cc.Created, 1, 10) Period    # по дням', IF($step = 3, 'WEEK(cc.Created) Period # по неделям', IF($step = 4, 'MONTH(cc.Created)  Period  # по месяцам', 'YEAR(cc.Created)  Period  # по годам')))), '
      , IF(cc.Created IS NULL, NULL, MONTH(cc.Created)) MonthPeriod  # месяц
      , IF(cc.Created IS NULL, NULL, YEAR(cc.Created)) YearPeriod  # год
      , sec_to_time(SUM(cc.duration))                                   qtyVoiceMin
      , DATE_FORMAT(sec_to_time(AVG(cc.duration)), "%H:%i:%s")          avgVoiceMin
      , DATE_FORMAT(sec_to_time(AVG(cc.holdtime)), "%H:%i:%s")          avgWaitMin
      , DATE_FORMAT(sec_to_time(AVG(cc.billsec)), "%H:%i:%s")           avgBillMin
      , ', $Aid,' Aid
    FROM ccContact cc
      INNER JOIN emEmploy ee ON ee.emID = cc.emID
      INNER JOIN usEnumValue us on us.tvID = cc.ccStatus
    WHERE cc.Created >= "', $dateFrom, '"
      AND "', $dateTo, '" >= cc.Created ', $emIDs, '
      ', IF($disposition IS NOT NULL, CONCAT('AND us.tvID = ', $disposition), ''), '
      ', IF($IsOut IS NOT NULL, CONCAT('AND cc.IsOut = ', IF($IsOut = TRUE, 1, 0)), ''), '
      AND cc.Aid = ', $Aid, ' AND us.Aid = ', $Aid, '
      AND cc.CallType != 101320 AND LENGTH(cc.ccName)>5
    GROUP BY
      ee.emID
      , ee.emName
      , us.Name
      , cc.IsOut
      , Period;');

    SET $sql2 = CONCAT('INSERT INTO ', IF($step = 1, '`dashboard_datetime`', IF($step = 2, '`dashboard_date`', '`dashboard_step`')), '
      SELECT
        ee.emID                                                           emID
        , ee.emName                                                       emName
        , t.dctName                                                       disposition
        , cc.IsOut                                                        IsOut
        , COUNT(d.dcID)                                                   QtyCall
        , ', IF($step = 1, CONCAT('CONCAT(SUBSTRING(d.Created, 1, 13), ":00:00") Period   # почасово'), IF($step = 2, 'SUBSTR(d.Created, 1, 10)     Period         # по дням', IF($step = 3, 'WEEK(d.Created)     Period         # по неделям', IF($step = 4, 'MONTH(d.Created)  Period  # по месяцам', 'YEAR(d.Created)  Period  # по годам')))), '
        , IF(d.Created IS NULL, NULL, MONTH(d.Created)) MonthPeriod  # месяц
        , IF(d.Created IS NULL, NULL, YEAR(d.Created)) YearPeriod  # год
        , sec_to_time(SUM(cc.duration))                                   qtyVoiceMin
        , DATE_FORMAT(sec_to_time(AVG(cc.duration)), "%H:%i:%s")          avgVoiceMin
        , DATE_FORMAT(sec_to_time(AVG(cc.holdtime)), "%H:%i:%s")          avgWaitMin
        , DATE_FORMAT(sec_to_time(AVG(cc.billsec)), "%H:%i:%s")           avgBillMin
        , ', $Aid,' Aid
      FROM emEmploy ee
        INNER JOIN dcDoc d ON d.emID = ee.emID
        INNER JOIN dcType t ON t.dctID = d.dctID
        LEFT JOIN ccContact cc ON cc.dcID = d.dcID
      WHERE d.Created >= "', $dateFrom, '"
        AND "', $dateTo, '" >= d.Created
        ', $emIDs,'
        ', IF($dctID IS NOT NULL, CONCAT('AND t.dctID = ', $dctID), ''), '
        ', IF($IsOut IS NOT NULL, CONCAT('AND cc.IsOut = ', IF($IsOut = TRUE, 1, 0)), ''), '
        AND ee.Aid = ', $Aid, '
        AND cc.CallType != 101320 AND LENGTH(cc.ccName)>5
      GROUP BY
        ee.emID
        , ee.emName
        , t.dctName
        , cc.IsOut
        , Period;');
    --
    SET @s = CONCAT($sql1);
    /*select @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    IF($disposition IS NULL) THEN
      SET @s = CONCAT($sql2);
      /*select @s;*/
      PREPARE stmt FROM @s;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
    END IF;
    --
    IF($step = 1) THEN
      SELECT Period
           , emName
           , SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END) `Full`
           , SUM(CASE WHEN disposition = 'ANSWERED' AND IsOut=1 THEN QtyCall ELSE 0 END) 'AnsweredOut'
           , SUM(CASE WHEN disposition = 'ANSWERED' AND IsOut=0 THEN QtyCall ELSE 0 END) 'AnsweredIn'
           , ROUND((100/SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END))*SUM(CASE WHEN disposition = 'ANSWERED' THEN QtyCall ELSE 0 END), 2) 'PercentAnswerd'
           , SUM(CASE WHEN disposition = 'NO ANSWER' AND IsOut=1 THEN QtyCall ELSE 0 END) 'NoAnsweredOut'
           , SUM(CASE WHEN disposition = 'NO ANSWER' AND IsOut=0 THEN QtyCall ELSE 0 END) 'NoAnsweredIn'
           , ROUND((100/SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END))*SUM(CASE WHEN disposition = 'NO ANSWER' THEN QtyCall ELSE 0 END), 2) 'PercentNoAnswerd'
           , SUM(CASE WHEN disposition = 'BUSY' AND IsOut=1 THEN QtyCall ELSE 0 END) 'BusyOut'
           , SUM(CASE WHEN disposition = 'BUSY' AND IsOut=0 THEN QtyCall ELSE 0 END) 'BusyIn'
        FROM
        (SELECT emID
            , emName
            , disposition
            , IsOut
            , QtyCall
            , Period
            , MonthPeriod
            , YearPeriod
            , qtyVoiceMin
            , avgVoiceMin
            , avgWaitMin
            , avgBillMin
      FROM dashboard_datetime WHERE Aid = $Aid
      ORDER BY Period, emID) t
      GROUP BY Period
             , emID
             , emName;
      DELETE FROM dashboard_datetime WHERE Aid = $Aid;
    ELSEIF($step = 2) THEN
      SELECT Period
           , emName
           , SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END) `Full`
           , SUM(CASE WHEN disposition = 'ANSWERED' AND IsOut=1 THEN QtyCall ELSE 0 END) 'AnsweredOut'
           , SUM(CASE WHEN disposition = 'ANSWERED' AND IsOut=0 THEN QtyCall ELSE 0 END) 'AnsweredIn'
           , ROUND((100/SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END))*SUM(CASE WHEN disposition = 'ANSWERED' THEN QtyCall ELSE 0 END), 2) 'PercentAnswerd'
           , SUM(CASE WHEN disposition = 'NO ANSWER' AND IsOut=1 THEN QtyCall ELSE 0 END) 'NoAnsweredOut'
           , SUM(CASE WHEN disposition = 'NO ANSWER' AND IsOut=0 THEN QtyCall ELSE 0 END) 'NoAnsweredIn'
           , ROUND((100/SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END))*SUM(CASE WHEN disposition = 'NO ANSWER' THEN QtyCall ELSE 0 END), 2) 'PercentNoAnswerd'
           , SUM(CASE WHEN disposition = 'BUSY' AND IsOut=1 THEN QtyCall ELSE 0 END) 'BusyOut'
           , SUM(CASE WHEN disposition = 'BUSY' AND IsOut=0 THEN QtyCall ELSE 0 END) 'BusyIn'
        FROM
        (SELECT emID
              , emName
              , disposition
              , IsOut
              , QtyCall
              , Period
              , MonthPeriod
              , YearPeriod
              , qtyVoiceMin
              , avgVoiceMin
              , avgWaitMin
              , avgBillMin
        FROM dashboard_date WHERE Aid = $Aid
        ORDER BY Period, emID) t
        GROUP BY Period
                , emID
                , emName;
      DELETE FROM dashboard_date WHERE Aid = $Aid;
    ELSE
      SELECT Period
           , emName
           , SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END) `Full`
           , SUM(CASE WHEN disposition = 'ANSWERED' AND IsOut=1 THEN QtyCall ELSE 0 END) 'AnsweredOut'
           , SUM(CASE WHEN disposition = 'ANSWERED' AND IsOut=0 THEN QtyCall ELSE 0 END) 'AnsweredIn'
           , ROUND((100/SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END))*SUM(CASE WHEN disposition = 'ANSWERED' THEN QtyCall ELSE 0 END), 2) 'PercentAnswerd'
           , SUM(CASE WHEN disposition = 'NO ANSWER' AND IsOut=1 THEN QtyCall ELSE 0 END) 'NoAnsweredOut'
           , SUM(CASE WHEN disposition = 'NO ANSWER' AND IsOut=0 THEN QtyCall ELSE 0 END) 'NoAnsweredIn'
           , ROUND((100/SUM(CASE WHEN disposition = 'Обращение' THEN QtyCall ELSE 0 END))*SUM(CASE WHEN disposition = 'NO ANSWER' THEN QtyCall ELSE 0 END), 2) 'PercentNoAnswerd'
           , SUM(CASE WHEN disposition = 'BUSY' AND IsOut=1 THEN QtyCall ELSE 0 END) 'BusyOut'
           , SUM(CASE WHEN disposition = 'BUSY' AND IsOut=0 THEN QtyCall ELSE 0 END) 'BusyIn'
        FROM
        (SELECT emID
                , emName
                , disposition
                , IsOut
                , QtyCall
                , Period
                , MonthPeriod
                , YearPeriod
                , qtyVoiceMin
                , avgVoiceMin
                , avgWaitMin
                , avgBillMin
          FROM dashboard_step WHERE Aid = $Aid
          ORDER BY Period, emID) t
          GROUP BY Period
              , emID
              , emName;
      DELETE FROM dashboard_step WHERE Aid = $Aid;
    END IF;
  END IF;
END $$
DELIMITER ;
--
