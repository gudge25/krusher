DROP FUNCTION IF EXISTS reg_GetAreaInfo;
DELIMITER $$
CREATE FUNCTION reg_GetAreaInfo(
      $Aid            INT
    , $phone        BIGINT
)
RETURNS INT
BEGIN
  DECLARE $id   INT;
  --
  SELECT id_area INTO $id FROM reg_validation WHERE Aid IN (0, $Aid) AND isActive = TRUE AND $phone BETWEEN prefixBegin AND prefixEnd ORDER BY LENGTH(prefix) DESC LIMIT 1;
  --
  RETURN $id;
END $$
DELIMITER ;
--
