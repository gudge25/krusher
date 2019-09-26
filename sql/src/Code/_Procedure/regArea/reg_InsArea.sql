DELIMITER $$
DROP PROCEDURE IF EXISTS reg_InsArea;
CREATE PROCEDURE reg_InsArea(
    $token            VARCHAR(100)
    , $arID            INT
    , $aName          VARCHAR(150)
    , $cID            INT
    , $rgID           INT
    , $langID         INT
    , $isActive       bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $language     VARCHAR(2);
  DECLARE $sql        VARCHAR(1000);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_InsArea');
  ELSE
    set $aName = NULLIF(TRIM($aName),'');
    SET $language = fn_GetLanguage($Aid, $langID);
    --
    if (($cID is NULL) OR ($rgID is NULL) OR ($arID is NULL))then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($aName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    SET $sql = CONCAT('insert INTO reg_cities (
      city_id
      , country_id
      , region_id
      , Aid
      , area_', $language, '
      , isActive
      , HIID
      , important
    )
    values (
      ',$arID,'
      , ',$cID,'
      , ',$rgID,'
      , ',$Aid,'
      , "',$aName,'"
      , ',IF($isActive = TRUE, 1, 0),'
      , fn_GetStamp()
      , 0
    );');
    --
    SET @s = CONCAT($sql);
   /* select @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
