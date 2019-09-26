DROP FUNCTION IF EXISTS reg_GetMCCInfo;
DELIMITER $$
CREATE FUNCTION reg_GetMCCInfo(
    $Aid            INT
    , $phone        BIGINT
)
RETURNS INT
BEGIN
  DECLARE $MCC   INT;
  --
  SELECT MCC INTO $MCC FROM reg_validation WHERE Aid IN (0, $Aid) AND isActive = TRUE AND $phone BETWEEN prefixBegin AND prefixEnd ORDER BY LENGTH(prefix) DESC LIMIT 1;
  --
  RETURN $MCC;
END $$
DELIMITER ;
--
