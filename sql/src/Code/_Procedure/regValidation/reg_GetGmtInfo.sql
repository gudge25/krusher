DROP FUNCTION IF EXISTS reg_GetGmtInfo;
DELIMITER $$
CREATE FUNCTION reg_GetGmtInfo(
    $Aid            INT
    , $phone        BIGINT
)
RETURNS INT
BEGIN
  DECLARE $gmt   INT;
  --
  SELECT gmt INTO $gmt FROM reg_validation WHERE Aid IN (0, $Aid) AND isActive = TRUE AND $phone BETWEEN prefixBegin AND prefixEnd ORDER BY LENGTH(prefix) DESC LIMIT 1;
  --
  IF $gmt IS NULL THEN
    SET $gmt = 102214;
  END IF;
  RETURN $gmt;
END $$
DELIMITER ;
--
