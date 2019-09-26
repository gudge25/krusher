DROP FUNCTION IF EXISTS reg_GetMNCInfo;
DELIMITER $$
CREATE FUNCTION reg_GetMNCInfo(
    $Aid            INT
    , $phone        BIGINT
)
RETURNS INT
BEGIN
  DECLARE $MNC   INT;
  --
  SELECT MNC INTO $MNC FROM reg_validation WHERE Aid IN (0, $Aid) AND isActive = TRUE AND $phone BETWEEN prefixBegin AND prefixEnd ORDER BY LENGTH(prefix) DESC LIMIT 1;
  --
  RETURN $MNC;
END $$
DELIMITER ;
--
