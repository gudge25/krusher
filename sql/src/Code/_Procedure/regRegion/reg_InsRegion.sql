DROP PROCEDURE IF EXISTS reg_InsRegion;
DELIMITER $$
CREATE PROCEDURE reg_InsRegion(
    $token            VARCHAR(100)
    , $rgID           int
    , $rgName         VARCHAR(250)
    , $cID            int
    , $langID         INT
    , $isActive       bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $language     VARCHAR(2);
  DECLARE $sql        VARCHAR(1000);
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_InsRegion');
  ELSE
    SET $language = fn_GetLanguage($Aid, $langID);
    --
    if ($rgID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    if ($rgName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    SET $sql = CONCAT('insert INTO reg_regions (
        region_id
        , country_id
        , title_', $language, '
        , Aid
        , isActive
        , HIID
      )
      values (',
        $rgID,'
        , ', $cID, '
        , "', $rgName, '"
        , ', $Aid, '
        , ',IF($isActive = TRUE, 1, 0),'
         , fn_GetStamp()
      );');
    --
    SET @s = CONCAT($sql);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
