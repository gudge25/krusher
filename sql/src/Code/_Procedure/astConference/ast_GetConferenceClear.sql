DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetConferenceClear;
CREATE PROCEDURE ast_GetConferenceClear(
    $cfID                           INT(11)
    , $Aid                          INT(11)
    , $cfName                       VARCHAR(250)
    , $cfDesc                       VARCHAR(250)
    , $userPin                      INT(11)
    , $adminPin                     INT(11)
    , $langID                       INT(11)
    , $record_id                    INT(11)
    , $leaderWait                   BIT
    , $leaderLeave                  BIT
    , $talkerOptimization           BIT
    , $talkerDetection              BIT
    , $quiteMode                    BIT
    , $userCount                    BIT
    , $userJoinLeave                BIT
    , $moh                          BIT
    , $mohClass                     INT(11)
    , $allowMenu                    BIT
    , $recordConference             BIT
    , $maxParticipants              INT(11)
    , $muteOnJoin                   BIT
    , $isActive                     BIT
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
  DECLARE $Aid            INT;
  --
  SET $offset = IFNULL($offset, 0);
  SET $limit  = IFNULL($limit, 100);
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
    SET $field_ = 'Created';
  ELSE
    SET $field_ = $field;
  END IF;
  --
  SET $sqlCount = 'SELECT count(*) Qty FROM ast_conference s ';
  --
  SET $sql = '
          SELECT
            s.HIID
            , s.cfID
            , s.Aid
            , s.cfName
            , s.cfDesc
            , s.userPin
            , s.adminPin
            , s.langID
            , s.record_id
            , s.leaderWait
            , s.leaderLeave
            , s.talkerOptimization
            , s.talkerDetection
            , s.quiteMode
            , s.userCount
            , s.userJoinLeave
            , s.moh
            , s.mohClass
            , s.allowMenu
            , s.recordConference
            , s.maxParticipants
            , s.muteOnJoin
            , s.isActive
            , s.Created
            , s.Changed
          FROM ast_conference s ';
  --
  IF $cfID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.cfID = ', $cfID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $cfName is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.cfName = ', QUOTE($cfName));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $cfDesc is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.cfDesc = ', QUOTE($cfDesc));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $userPin is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.userPin = ', $userPin);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $adminPin is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.adminPin = ', $adminPin);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $langID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.langID = ', $langID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $record_id is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.record_id = ', $record_id);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $mohClass is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.mohClass = ', $mohClass);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $maxParticipants is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.maxParticipants = ', $maxParticipants);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $Aid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.Aid = ', $Aid);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $isActive is NOT NULL THEN
    IF $isActive = TRUE THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.isActive = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $leaderWait is NOT NULL THEN
    IF $leaderWait = TRUE THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.leaderWait = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 's.leaderWait = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $leaderLeave is NOT NULL THEN
   IF($leaderLeave = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.leaderLeave = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.leaderLeave = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $talkerOptimization is NOT NULL THEN
    IF($talkerOptimization = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.talkerOptimization = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.talkerOptimization = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $talkerDetection is NOT NULL THEN
     IF($talkerDetection = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.talkerDetection = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.talkerDetection = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $quiteMode is NOT NULL THEN
     IF($quiteMode = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.quiteMode = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.quiteMode = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $muteOnJoin is NOT NULL THEN
     IF($muteOnJoin = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.muteOnJoin = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.muteOnJoin = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $userCount is NOT NULL THEN
     IF($userCount = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.userCount = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.userCount = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $userJoinLeave is NOT NULL THEN
     IF($userCount = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.userJoinLeave = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.userJoinLeave = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $moh is NOT NULL THEN
     IF($moh = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.moh = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.moh = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $allowMenu is NOT NULL THEN
     IF($allowMenu = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.allowMenu = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.allowMenu = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $recordConference is NOT NULL THEN
     IF($recordConference = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.recordConference = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  's.recordConference = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  --
  SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY s.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
  /*select @s;*/
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
