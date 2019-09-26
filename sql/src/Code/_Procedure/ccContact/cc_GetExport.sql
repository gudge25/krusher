DROP PROCEDURE IF EXISTS cc_GetExport;
DELIMITER $$
CREATE PROCEDURE cc_GetExport(
    $token          VARCHAR(100)
    , $DateFrom     DATETIME
    , $DateTo       DATETIME
    , $emIDs        TINYTEXT
    , $dcStatuss    TINYTEXT
    , $ffIDs        TINYTEXT
    , $isMissed     BIT
    , $isUnique     BIT
    , $CallTypes    TINYTEXT
    , $ccNames      TINYTEXT      # фильт по номеру телефона
    , $channels     TINYTEXT      # фильтр по каналу
    , $comparison   VARCHAR(10)   # символ сравнения длительности разговора
    , $billsec      INT           # продолжительность разговора, которую необходимо сравнивать по показателю из предыдущего параметра
    , $clIDs        TINYTEXT      # фильтр по клиенту
    , $IsOut        BIT           # признак Входящий звонок или исходящий
    , $id_autodials TINYTEXT
    , $id_scenarios TINYTEXT
    , $target       VARCHAR(255)
    , $url          VARCHAR(300)
    , $isActive     BIT
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(10);
  DECLARE $sql            VARCHAR(8000);
  DECLARE $sqlHeader      VARCHAR(8000);
  DECLARE $sqlWhere       VARCHAR(8000);
  DECLARE $sqlOrder       VARCHAR(8000);
  DECLARE $sqlGroup       VARCHAR(8000);
  DECLARE $sqlCount       VARCHAR(1000);
  DECLARE $sqlMaker       VARCHAR(1000);
  DECLARE $sqlRes         VARCHAR(10000);
  DECLARE $sqlRes2        VARCHAR(8000);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_GetExport');
  ELSE
    SET $sqlWhere = '';
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlOrder = '';
    SET $sqlGroup = '';
    SET $comparison = IFNULL($comparison, '=');
    SET $sqlHeader = CONCAT('SELECT ccName "Номер"
                              , IsOut  "Направление"
                              , clName "Клиент"
                              , CallDate "Дата перезвона"
                              , ClientComment "Комментарий по клиенту"
                              , Created "Время создания"
                              , emName "Сотрудник"
                              , CallStatus "Статус звонка"
                              , ActualStatus "Статус Актуализации"
                              , SIP
                              , LinkFile
                              , dbBase "База"
                              , duration "Продолжительность звонка"
                              , billsec "Время разговора"
                              , serviceLevel "Время гудков"
                              , holdtime "Время ожидания"
                              , channel
                              , coName "Компания"
                              , Status "Статус"
                              , Comment "Комментарий"
                              , target "Цель"
                              , id_autodial "ID процесса"
                              , Scenario "Сценарий"
                              , IF(a.curID IS NOT NULL AND a.curID !=0, (SELECT Name FROM usEnumValue WHERE tvID=a.curID AND Aid = ', $Aid,'), "") "Валюта"
                              , IF(a.langID IS NOT NULL AND a.langID !=0, (SELECT Name FROM usEnumValue WHERE tvID=a.langID AND Aid = ', $Aid,'), "") "Язык"
                              , summa  "Сумма"
                              , ttsText "Текст" FROM ');
    SET $sql = CONCAT('SELECT
          c.ccName
          , IF(c.IsOut=1, "Outgoing", "Incoming")     "IsOut"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT clName FROM crmClient WHERE clID = c.clID AND Aid = ', $Aid,'), "")   "clName"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT CallDate FROM crmClientEx WHERE clID=c.clID AND Aid=', $Aid,'), "")    "CallDate"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT Comment FROM crmClient WHERE clID = c.clID AND Aid = ', $Aid,'), "")   "ClientComment"
          , c.Created                                 "Created"
          , IF(c.emID IS NOT NULL AND c.emID !=0, (SELECT emName FROM emEmploy WHERE emID = c.emID AND Aid = ', $Aid,'), "")   "emName"
          , IF(c.ccStatus IS NOT NULL AND c.ccStatus !=0, (SELECT Name FROM usEnumValue WHERE tvID = c.ccStatus AND Aid = ', $Aid,'), "") "CallStatus"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT Name FROM usEnumValue WHERE Aid = ', $Aid, ' AND tvID IN (SELECT ActualStatus FROM crmClient WHERE clID = c.clID AND Aid = ', $Aid,')), "")   "ActualStatus"
          , c.SIP                                     SIP
          , IF(c.ccStatus = 7001, CONCAT("', $url, '/monitor/", c.LinkFile, ".ogg"), "") LinkFile
          , IF(c.ffID IS NOT NULL AND c.ffID !=0, (SELECT ffName FROM fsFile WHERE ffID = c.ffID AND Aid = ', $Aid,'), "") "dbBase"
          , c.duration                                "duration"
          , c.billsec                                 "billsec"
          , c.serviceLevel                                "serviceLevel"
          , c.holdtime                                "holdtime"
          , c.channel                                 "channel"
          , IF(c.coID IS NULL or c.coID = 0, NULL, (SELECT coName FROM crmCompany WHERE coID = c.coID AND Aid = ', $Aid, ' LIMIT 1))                                "coName"
          , IF(c.ContactStatus IS NULL, NULL, (SELECT Name FROM usEnumValue WHERE Aid = ', $Aid, ' AND tvID = c.ContactStatus LIMIT 1))                                "Status"
          , c.Comment                                                   "Comment"
          , c.target                                  "target"
          , c.id_autodial                             "id_autodial"
          , IF(c.id_scenario IS NOT NULL AND c.id_scenario !=0, (SELECT name_scenario FROM ast_scenario WHERE id_scenario=c.id_scenario AND Aid = ', $Aid, '), "") "Scenario"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT curID FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "curID"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT langID FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "langID"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT `sum` FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "summa"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT ttsText FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "ttsText"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT cusID FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "ID"
        FROM ccContact c ');
    --
    IF $DateFrom is NOT NULL THEN
      SET $sqlWhere = CONCAT(CHAR(10), 'WHERE c.Created >= ', QUOTE($DateFrom));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DateTo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.Created <= ', QUOTE($DateTo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsOut is NOT NULL THEN
      IF $IsOut = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.IsOut = TRUE');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.IsOut = FALSE');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($emIDs is NOT NULL) AND (length(TRIM($emIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $emIDs)>0) OR (LOCATE('false', $emIDs)>0)) THEN
        IF (LOCATE(',', $emIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ',true', ') OR c.emID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.emID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'c.emID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'c.emID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (', $emIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ffIDs is NOT NULL) AND (length(TRIM($ffIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $ffIDs)>0) OR (LOCATE('false', $ffIDs)>0)) THEN
        IF (LOCATE(',', $ffIDs)>0) THEN
          SET $sqlMaker = REPLACE($ffIDs, ',true', ') OR c.ffID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.ffID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ffID IN (', $sqlMaker);
        ELSE
          IF $ffIDs = 'true' THEN
            SET $sqlMaker = 'c.ffID = 0';
          END IF;
          IF $ffIDs = 'false' THEN
            SET $sqlMaker = 'c.ffID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ffID IN (', $ffIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($id_autodials is NOT NULL) AND (length(TRIM($id_autodials))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $id_autodials)>0) OR (LOCATE('false', $id_autodials)>0)) THEN
        IF (LOCATE(',', $id_autodials)>0) THEN
          SET $sqlMaker = REPLACE($id_autodials, ',true', ') OR c.id_autodial = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.id_autodial != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_autodial IN (', $sqlMaker);
        ELSE
          IF $id_autodials = 'true' THEN
            SET $sqlMaker = 'c.id_autodial = 0';
          END IF;
          IF $id_autodials = 'false' THEN
            SET $sqlMaker = 'c.id_autodial != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_autodial IN (', $id_autodials, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($id_scenarios is NOT NULL) AND (length(TRIM($id_scenarios))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $id_scenarios)>0) OR (LOCATE('false', $id_scenarios)>0)) THEN
        IF (LOCATE(',', $id_scenarios)>0) THEN
          SET $sqlMaker = REPLACE($id_scenarios, ',true', ') OR c.id_scenario = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.id_scenario != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_scenario IN (', $sqlMaker);
        ELSE
          IF $id_scenarios = 'true' THEN
            SET $sqlMaker = 'c.id_scenario = 0';
          END IF;
          IF $id_scenarios = 'false' THEN
            SET $sqlMaker = 'c.id_scenario != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_scenario IN (', $id_scenarios, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($dcStatuss is NOT NULL) AND (length(TRIM($dcStatuss))>0)) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccStatus IN (', $dcStatuss, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($CallTypes is NOT NULL) AND (length(TRIM($CallTypes))>0)) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.CallType IN (', $CallTypes, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ccNames is NOT NULL) AND (length(TRIM($ccNames))>0)) THEN
      SET $sqlMaker = '';
      IF (LOCATE(',', $ccNames)>0) THEN
        SET $sqlMaker = REPLACE($ccNames, '"', '');
        SET $sqlMaker = CONCAT('"', REPLACE($sqlMaker, ',', '", "'), '"');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccName IN (', $sqlMaker, ')');
      ELSE
        SET $sqlMaker = REPLACE($ccNames, '"', '');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccName  = "', $sqlMaker, '"');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($channels is NOT NULL) AND (length(TRIM($channels))>0)) THEN
      SET $sqlMaker = '';
      IF (LOCATE(',', $channels)>0) THEN
        SET $sqlMaker = REPLACE($channels, '"', '');
        SET $sqlMaker = CONCAT('"', REPLACE($sqlMaker, ',', '", "'), '"');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel IN (', $sqlMaker, ')');
      ELSE
        SET $sqlMaker = REPLACE($channels, '"', '');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel  = "', $sqlMaker, '"');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($clIDs is NOT NULL) AND (length(TRIM($clIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $clIDs)>0) OR (LOCATE('false', $clIDs)>0)) THEN
        IF (LOCATE(',', $clIDs)>0) THEN
          SET $sqlMaker = REPLACE($clIDs, ',true', ') OR c.clID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.clID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.clID IN (', $sqlMaker);
        ELSE
          IF $clIDs = 'true' THEN
            SET $sqlMaker = 'c.clID = 0';
          END IF;
          IF $clIDs = 'false' THEN
            SET $sqlMaker = 'c.clID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.clID IN (', $clIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isMissed = 1 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsMissed = TRUE');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $billsec is NOT NULL THEN
      IF $comparison = '=' THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.billsec = ', $billsec);
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.billsec ', $comparison, '=', $billsec);
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $target is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.target = ', QUOTE($target));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsActive is NOT NULL THEN
      IF $IsActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.Aid = ', $Aid, ' AND c.CallType != 101320 AND c.SIP IS NOT NULL AND c.isActive = TRUE');
    --
    IF $isMissed = 1 or $isUnique = 1 then
      SET $sqlGroup = CONCAT(CHAR(10), 'GROUP BY c.ccName');
    END IF;
    --
    SET $sqlOrder = CONCAT(CHAR(10), 'ORDER BY c.Created DESC ');
    --
    SET @s = CONCAT($sql, $sqlWhere, $sqlGroup, $sqlOrder);
    --
    SET $sqlRes2 = CONCAT('(', $sqlCount, ' FROM ccContact c ', $sqlWhere, $sqlGroup, ')');
    /*---------------------------------------------------------------------------------------------------------------------------------------------------*/
    SET $sqlWhere = '';
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlOrder = '';
    SET $sqlGroup = '';
    SET $sql = CONCAT('
        SELECT
         c.ccName
          , IF(c.IsOut=1, "Outgoing", "Incoming")     "IsOut"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT clName FROM crmClient WHERE clID = c.clID AND Aid = ', $Aid,'), "")   "clName"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT CallDate FROM crmClientEx WHERE clID=c.clID AND Aid=', $Aid,'), "")    "CallDate"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT Comment FROM crmClient WHERE clID = c.clID AND Aid = ', $Aid,'), "")   "ClientComment"
          , c.Created                                 "Created"
          , IF(c.emID IS NOT NULL AND c.emID !=0, (SELECT emName FROM emEmploy WHERE emID = c.emID AND Aid = ', $Aid,'), "")   "emName"
          , IF(c.ccStatus IS NOT NULL AND c.ccStatus !=0, (SELECT Name FROM usEnumValue WHERE tvID = c.ccStatus AND Aid = ', $Aid,'), "") "CallStatus"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT Name FROM usEnumValue WHERE Aid = ', $Aid, ' AND tvID IN (SELECT ActualStatus FROM crmClient WHERE clID = c.clID AND Aid = ', $Aid,')), "")   "ActualStatus"
          , c.SIP                                     SIP
          , IF(c.ccStatus = 7001, CONCAT("', $url, '/monitor/", c.LinkFile, ".ogg"), "") LinkFile
          , IF(c.ffID IS NOT NULL AND c.ffID !=0, (SELECT ffName FROM fsFile WHERE ffID = c.ffID AND Aid = ', $Aid,'), "") "dbBase"
          , c.duration                                "duration"
          , c.billsec                                 "billsec"
          , c.serviceLevel                                "serviceLevel"
          , c.holdtime                                "holdtime"
          , c.channel                                 "channel"
          , IF(c.coID IS NULL or c.coID = 0, NULL, (SELECT coName FROM crmCompany WHERE coID = c.coID AND Aid = ', $Aid, ' LIMIT 1))                                "coName"
          , IF(c.ContactStatus IS NULL, NULL, (SELECT Name FROM usEnumValue WHERE Aid = ', $Aid, ' AND tvID = c.ContactStatus LIMIT 1))                                "Status"
          , c.Comment                                                   "Comment"
          , c.target                                  "target"
          , c.id_autodial                             "id_autodial"
          , IF(c.id_scenario IS NOT NULL AND c.id_scenario !=0, (SELECT name_scenario FROM ast_scenario WHERE id_scenario=c.id_scenario AND Aid = ', $Aid, '), "") "Scenario"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT curID FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "curID"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT langID FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "langID"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT `sum` FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "summa"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT ttsText FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "ttsText"
          , IF(c.clID IS NOT NULL AND c.clID !=0, (SELECT cusID FROM crmClientEx WHERE clID=c.clID AND Aid = ', $Aid, '), "") "ID"
        FROM ccContact c ');
    --
    IF $DateFrom is NOT NULL THEN
      SET $sqlWhere = CONCAT(CHAR(10), 'WHERE c.Created >= ', QUOTE($DateFrom));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $DateTo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.Created <= ', QUOTE($DateTo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsOut is NOT NULL THEN
      IF $IsOut = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.IsOut = TRUE');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.IsOut = FALSE');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($emIDs is NOT NULL) AND (length(TRIM($emIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $emIDs)>0) OR (LOCATE('false', $emIDs)>0)) THEN
        IF (LOCATE(',', $emIDs)>0) THEN
          SET $sqlMaker = REPLACE($emIDs, ',true', ') OR c.emID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.emID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (', $sqlMaker);
        ELSE
          IF $emIDs = 'true' THEN
            SET $sqlMaker = 'c.emID = 0';
          END IF;
          IF $emIDs = 'false' THEN
            SET $sqlMaker = 'c.emID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.emID IN (', $emIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ffIDs is NOT NULL) AND (length(TRIM($ffIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $ffIDs)>0) OR (LOCATE('false', $ffIDs)>0)) THEN
        IF (LOCATE(',', $ffIDs)>0) THEN
          SET $sqlMaker = REPLACE($ffIDs, ',true', ') OR c.ffID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.ffID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ffID IN (', $sqlMaker);
        ELSE
          IF $ffIDs = 'true' THEN
            SET $sqlMaker = 'c.ffID = 0';
          END IF;
          IF $ffIDs = 'false' THEN
            SET $sqlMaker = 'c.ffID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ffID IN (', $ffIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($id_autodials is NOT NULL) AND (length(TRIM($id_autodials))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $id_autodials)>0) OR (LOCATE('false', $id_autodials)>0)) THEN
        IF (LOCATE(',', $id_autodials)>0) THEN
          SET $sqlMaker = REPLACE($id_autodials, ',true', ') OR c.id_autodial = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.id_autodial != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_autodial IN (', $sqlMaker);
        ELSE
          IF $id_autodials = 'true' THEN
            SET $sqlMaker = 'c.id_autodial = 0';
          END IF;
          IF $id_autodials = 'false' THEN
            SET $sqlMaker = 'c.id_autodial != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_autodial IN (', $id_autodials, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($id_scenarios is NOT NULL) AND (length(TRIM($id_scenarios))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $id_scenarios)>0) OR (LOCATE('false', $id_scenarios)>0)) THEN
        IF (LOCATE(',', $id_scenarios)>0) THEN
          SET $sqlMaker = REPLACE($id_scenarios, ',true', ') OR c.id_scenario = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.id_scenario != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_scenario IN (', $sqlMaker);
        ELSE
          IF $id_scenarios = 'true' THEN
            SET $sqlMaker = 'c.id_scenario = 0';
          END IF;
          IF $id_scenarios = 'false' THEN
            SET $sqlMaker = 'c.id_scenario != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.id_scenario IN (', $id_scenarios, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($dcStatuss is NOT NULL) AND (length(TRIM($dcStatuss))>0)) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccStatus IN (', $dcStatuss, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($CallTypes is NOT NULL) AND (length(TRIM($CallTypes))>0)) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.CallType IN (', $CallTypes, ')');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($ccNames is NOT NULL) AND (length(TRIM($ccNames))>0)) THEN
      SET $sqlMaker = '';
      IF (LOCATE(',', $ccNames)>0) THEN
        SET $sqlMaker = REPLACE($ccNames, '"', '');
        SET $sqlMaker = CONCAT('"', REPLACE($sqlMaker, ',', '", "'), '"');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccName IN (', $sqlMaker, ')');
      ELSE
        SET $sqlMaker = REPLACE($ccNames, '"', '');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.ccName  = "', $sqlMaker, '"');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($channels is NOT NULL) AND (length(TRIM($channels))>0)) THEN
      SET $sqlMaker = '';
      IF (LOCATE(',', $channels)>0) THEN
        SET $sqlMaker = REPLACE($channels, '"', '');
        SET $sqlMaker = CONCAT('"', REPLACE($sqlMaker, ',', '", "'), '"');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel IN (', $sqlMaker, ')');
      ELSE
        SET $sqlMaker = REPLACE($channels, '"', '');
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.channel  = "', $sqlMaker, '"');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF (($clIDs is NOT NULL) AND (length(TRIM($clIDs))>0)) THEN
      SET $sqlMaker = '';
      IF ((LOCATE('true', $clIDs)>0) OR (LOCATE('false', $clIDs)>0)) THEN
        IF (LOCATE(',', $clIDs)>0) THEN
          SET $sqlMaker = REPLACE($clIDs, ',true', ') OR c.clID = 0');
          SET $sqlMaker = REPLACE($sqlMaker, ',false', ') OR c.clID != 0');
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.clID IN (', $sqlMaker);
        ELSE
          IF $clIDs = 'true' THEN
            SET $sqlMaker = 'c.clID = 0';
          END IF;
          IF $clIDs = 'false' THEN
            SET $sqlMaker = 'c.clID != 0';
          END IF;
          SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, $sqlMaker);
        END IF;
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.clID IN (', $clIDs, ')');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isMissed = 1 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsMissed = TRUE');
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $billsec is NOT NULL THEN
      IF $comparison = '=' THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.billsec = ', $billsec);
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.billsec ', $comparison, '=', $billsec);
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $target is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.target = ', QUOTE($target));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsActive is NOT NULL THEN
      IF $IsActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.isActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.isActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'c.Aid = ', $Aid, ' AND c.CallType != 101320 AND c.SIP IS NULL AND c.isActive = TRUE');
    --
    IF $isMissed = 1 or $isUnique = 1 then
      SET $sqlGroup = CONCAT(CHAR(10), 'GROUP BY c.ccName');
    END IF;
    --
    SET $sqlOrder = CONCAT(CHAR(10), 'ORDER BY c.Created DESC ');
    --
    SET @s2 = CONCAT($sql, $sqlWhere, $sqlGroup, $sqlOrder);
    --
    SET $sqlRes = CONCAT($sqlHeader, ' ((', @s, ') UNION ALL (', @s2, '))a
                          ', 'ORDER BY a.Created DESC');
    SET @s3 = $sqlRes;
    -- select @s3;
    PREPARE stmt FROM @s3;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
