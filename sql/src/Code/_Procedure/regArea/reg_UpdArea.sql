DELIMITER $$
DROP PROCEDURE IF EXISTS reg_UpdArea;
CREATE PROCEDURE reg_UpdArea(
    $HIID           BIGINT
    , $token            VARCHAR(100)
    , $arID           INT
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
    call RAISE(77068, 'reg_UpdArea');
  ELSE
    set $aName = NULLIF(TRIM($aName),'');
    SET $language = fn_GetLanguage($Aid, $langID);
    --
    if (($cID is NULL) OR ($rgID is NULL) OR ($arID is NULL)) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($aName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    if not exists (
      select 1
      from reg_cities
      where HIID = $HIID
        and city_id = $arID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    SET $sql = CONCAT('update reg_cities set
      area_', $language, '       = "', $aName,'"
      , country_id  = ', $cID, '
      , region_id   = ', $rgID, '
      , isActive = ',IF($isActive = TRUE, 1, 0),'
      , HIID        = fn_GetStamp()
    where city_id = ', $arID, ' AND Aid = ', $Aid, ';');
    --
    SET @s = CONCAT($sql);
    /*SELECT @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DElIMITER ;
--
