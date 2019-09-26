DROP FUNCTION IF EXISTS reg_GetCityInfo;
DELIMITER $$
CREATE FUNCTION reg_GetCityInfo(
      $Aid            INT
    , $phone        BIGINT
)
RETURNS INT
BEGIN
  DECLARE $id   INT;
  --
  SELECT id_city INTO $id FROM reg_validation WHERE Aid IN (0, $Aid) AND isActive = TRUE AND $phone BETWEEN prefixBegin AND prefixEnd ORDER BY LENGTH(prefix) DESC LIMIT 1;
  --
  RETURN $id;
END $$
DELIMITER ;
--
