DROP FUNCTION IF EXISTS reg_GetCountryInfo;
DELIMITER $$
CREATE FUNCTION reg_GetCountryInfo(
    $Aid            INT
    , $phone        BIGINT
)
RETURNS INT
BEGIN
  DECLARE $id   INT;
  --
  SELECT id_country INTO $id FROM reg_validation WHERE Aid IN (0, $Aid) AND isActive = TRUE AND $phone BETWEEN prefixBegin AND prefixEnd ORDER BY LENGTH(prefix) DESC LIMIT 1;
  --
  RETURN $id;
END $$
DELIMITER ;
--
