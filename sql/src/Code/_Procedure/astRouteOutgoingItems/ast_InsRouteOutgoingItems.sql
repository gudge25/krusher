DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsRouteOutgoingItems;
CREATE PROCEDURE ast_InsRouteOutgoingItems(
    $token                          VARCHAR(100)
    , $roiID                        INT(11)
    , $roID                         INT(11)
    , $pattern                      VARCHAR(50)
    , $callerID                     VARCHAR(50)
    , $prepend                      VARCHAR(50)
    , $prefix                       VARCHAR(50)
    , $priority                     INT(11)
    , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsRouteOutgoingItems');
  ELSE
    IF $roID IS NULL THEN
      call RAISE(77076, 'roID');
    END IF;
    --
    SET @s = CONCAT('DROP TABLE IF EXISTS __prefix_', $Aid, ';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    SET @s = CONCAT('CREATE TEMPORARY TABLE __prefix_', $Aid, '(
      pattern varchar(200)
      , Aid  int  NOT NULL
      , PRIMARY KEY (pattern)
      , INDEX `Aid` (`Aid`)
    )ENGINE=MEMORY;');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    call sp_split($pattern, ',', CONCAT('__prefix_', $Aid), $Aid);
    --
    SET @s = CONCAT('INSERT INTO ast_route_outgoing_items (
        HIID
        , roiID
        , pattern
        , Aid
        , roID
        , callerID
        , prepend
        , prefix
        , priority
        , isActive
    )
    SELECT
      fn_GetStamp()
      /*, us_GetNextSequence("roiID") 11 04 2019*/
      , NEXTVAL(roiID)
      , pattern
      , Aid
      , ', $roID, '
      , ', IF($callerID IS NOT NULL, QUOTE($callerID), 'NULL'), '
      , ', IF($prepend IS NOT NULL, QUOTE($prepend), 'NULL'), '
      , ', IF($prefix IS NOT NULL, QUOTE($prefix), 'NULL'), '
      , ', IF($priority IS NOT NULL, $priority, 'NULL'), '
      , ', IF($isActive IS NOT NULL, $isActive, 0), '
    FROM __prefix_', $Aid);
     /*SELECT @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
