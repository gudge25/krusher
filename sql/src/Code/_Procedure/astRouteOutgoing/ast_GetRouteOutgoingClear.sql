DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetRouteOutgoingClear;
CREATE PROCEDURE ast_GetRouteOutgoingClear(
    $Aid                  INT(11)
    , $roID               INT(11)
    , $roName             VARCHAR(50)
    , $roiID              INT(11)
    , $destination        INT(11)
    , $destdata           INT(11)
    , $destdata2          VARCHAR(100)
    , $category           INT(11)
    ,	$prepend            VARCHAR(50)
	  , $prefix             VARCHAR(50)
    , $rcallerID          VARCHAR(50)
    , $priority           INT(11)
    , $patten             VARCHAR(50)
    , $icallerID          VARCHAR(50)
    , $isActive           BIT
    , $sorting            VARCHAR(5)
    , $field              VARCHAR(50)
    , $offset             INT(11)
    , $limit              INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);  
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetPoolListClear');
  ELSE
    SET $offset = IFNULL($offset, 0);
    SET $limit  = IFNULL($limit, 100000);
    SET $limit = if($limit > 100000, 100000, $limit);
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
    SET $sql = '
            SELECT r.Aid
                , r.roID            roID
                , r.roName          roName
                , r.destination     destination
                , IF(r.destination IS NOT NULL, (SELECT Name FROM usEnumValue WHERE tvID = r.destination AND Aid = r.Aid), "NULL")        destinationName
                , r.destdata        destdata
                , r.destdata2       destdata2
                , r.category        category
                , r.prepend         prepend
                , r.prefix          prefix
                , IF(r.category IS NOT NULL, (SELECT Name FROM usEnumValue WHERE tvID = r.category AND Aid = r.Aid), "NULL")        categoryName
                , r.callerID        rcallerID
                , r.priority        priority
                , i.pattern         pattern
                , i.callerID        icallerID
                , r.coID            coID
            FROM ast_route_outgoing r
            INNER JOIN ast_route_outgoing_items i ON i.roID=r.roID ';
    --
    IF $roID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.roID = ', $roID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destination is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.destination = ', $destination);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.destdata = ', $destdata);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $destdata2 is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.destdata2 = ', QUOTE($destdata2));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $category is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.category = ', $category);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $priority is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.priority = ', $priority);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $prepend is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.prepend = ', QUOTE($prepend));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $prefix is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.$prefix = ', QUOTE($prefix));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $patten is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'i.patten = ', QUOTE($patten));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $rcallerID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'r.callerID = ', QUOTE($rcallerID));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $icallerID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'i.callerID = ', QUOTE($icallerID));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $priority is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'secret = ', QUOTE($secret));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $Aid is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'Aid = ', $Aid);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $isActive is NOT NULL THEN
      IF $IsActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.isActive = 1 AND r.isActive = 1 ');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'i.isActive = 0 AND r.isActive = 0 ');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), $sqlWhereCode, 'r.Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY r.Aid, r.priority, i.priority, r.roID, i.pattern  ASC', CHAR(10), 'LIMIT ', $offset, ',', $limit);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
