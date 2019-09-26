DROP FUNCTION IF EXISTS fn_GetLanguage;
DELIMITER $$
CREATE FUNCTION fn_GetLanguage(
    $Aid          INT
    , $langID     INT
)
RETURNS VARCHAR(2)
BEGIN
  DECLARE $language   VARCHAR(2) ;
  SELECT `Name` INTO $language FROM usEnumValue WHERE tyID = 1023 AND tvID = $langID AND Aid = $Aid LIMIT 1;
  --
  IF ($language IS NULL) THEN
    SET $language = 'ru';
  END IF;
  --
  RETURN $language;
END $$
DELIMITER ;
--
