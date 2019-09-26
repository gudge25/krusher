DROP PROCEDURE IF EXISTS us_GetFavorite;
DELIMITER $$
CREATE PROCEDURE us_GetFavorite(
    $token            VARCHAR(100)
    , $uID            BIGINT
    , $faComment      VARCHAR(200)
    , $isActive       BIT
    , $faID           INT(11)
    , $faModel        VARCHAR(20)
    , $faInfo         VARCHAR(200)
    , $sorting        VARCHAR(5)
    , $field          VARCHAR(50)
    , $offset         INT(11)
    , $limit          INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(1000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  DECLARE $Aid            INT;
  DECLARE $emID           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_GetFavorite');
  ELSE
    SET $emID = fn_GetEmployID($token);
    SET $offset = IFNULL($offset, 0);
    SET $limit  = IFNULL($limit, 500);
    SET $limit = if($limit > 10000, 10000, $limit);
    SET $sqlWhereCode = 'WHERE ';
    SET $sqlWhere = '';
    IF($sorting IS NULL) THEN
      SET $sorting_ = 'ASC';
    ELSE
      SET $sorting_ = $sorting;
    END IF;
    IF($field IS NULL) THEN
      SET $field_ = 'Created';
    ELSE
      SET $field_ = $field;
    END IF;
    --
    CREATE TEMPORARY TABLE IF NOT EXISTS `Favourites`(
      `uID` VARCHAR(20) NOT NULL,
      `faID` INT NOT NULL,
      `faModel` VARCHAR(20) NOT NULL,
      `faInfo` VARCHAR(200) NOT NULL,
      `faComment` VARCHAR(200) NOT NULL,
      `isActive` BIT NOT NULL DEFAULT b'0',
      `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `Changed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `Aid` INT NOT NULL,
      INDEX (`uID`),
      INDEX `Aid` (`Aid`),
      INDEX `Created` (`Created`),
      INDEX `isActive` (`isActive`),
      INDEX `faComment` (`faComment`),
      INDEX `faInfo` (`faInfo`),
      INDEX `faModel` (`faModel`),
      INDEX `faID` (`faID`)
    )
    ENGINE=MEMORY;
    --
    INSERT INTO `Favourites`
      (uID, faID, faModel, faInfo, faComment, isActive, Aid)
    SELECT
      CONVERT(f.uID,char(20))     uID
      , d.dcID                    faID
      , 'Doc'                     faModel
      , CONCAT(t.dctName, IFNULL(CONCAT(' №', d.dcNo),''),' от ', DATE_FORMAT(d.dcDate, '%d.%m.%Y')) faInfo
      , f.faComment               faComment
      , f.isActive                isActive
      , f.Aid                     Aid
    FROM usFavorite f
      INNER JOIN dcDoc d ON d.uID = f.uID
      INNER JOIN dcType t ON t.dctID = d.dctID
    WHERE f.emID = $emID AND f.Aid = $Aid;
    --
    INSERT INTO `Favourites`
      (uID, faID, faModel, faInfo, faComment, isActive, Aid)
    SELECT
      CONVERT(f.uID,char(20))     uID
      , cl.clID                   faID
      , 'Client'                  faModel
      , cl.clName                 faInfo
      , f.faComment               faComment
      , f.isActive                isActive
      , f.Aid                     Aid
    FROM usFavorite f
      INNER JOIN crmClient cl ON cl.uID = f.uID
    WHERE f.emID = $emID AND f.Aid = $Aid;
    --
    INSERT INTO `Favourites`
      (uID, faID, faModel, faInfo, faComment, isActive, Aid)
    SELECT
      CONVERT(f.uID,char(20))     uID
      , em.emID                   faID
      , 'Employ'                  faModel
      , em.emName                 faInfo
      , f.faComment               faComment
      , f.isActive                isActive
      , f.Aid                     Aid
    FROM usFavorite f
      INNER JOIN emEmploy em ON em.uID = f.uID
    WHERE f.emID = $emID AND f.Aid = $Aid;
    --
    INSERT INTO `Favourites`
      (uID, faID, faModel, faInfo, faComment, isActive, Aid)
    SELECT
      CONVERT(f.uID,char(20))     uID
      , p.psID                    faID
      , 'Product'                 faModel
      , p.psName                  faInfo
      , f.faComment               faComment
      , f.isActive                isActive
      , f.Aid                     Aid
    FROM usFavorite f
      INNER JOIN stProduct p ON p.uID = f.uID
    WHERE f.emID = $emID AND f.Aid = $Aid;
    --
    SET $sqlCount = 'SELECT COUNT(*)    Qty FROM Favourites ';
    --
    SET $sql = 'SELECT
                    uID
                    , faID
                    , faModel
                    , faInfo
                    , faComment
                    , isActive
                    , Created
                    , Changed
                  FROM Favourites ';
    --
    IF $uID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'uID = ', $uID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $faID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'faID = ', $faID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $faModel is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'faModel = ', QUOTE($faModel));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $faInfo is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'faInfo = ', QUOTE($faInfo));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $faComment is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'faComment ', QUOTE($faComment));
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
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    DELETE FROM `Favourites` WHERE Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
