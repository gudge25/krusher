DROP PROCEDURE IF EXISTS reg_UpdRegion;
DELIMITER $$
CREATE PROCEDURE reg_UpdRegion(
    $HIID           BIGINT
    , $token            VARCHAR(100)
    , $rgID           int
    , $rgName         VARCHAR(250)
    , $cID            int
    , $langID         INT
    , $isActive       bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $isCalc bool;
  DECLARE $language     VARCHAR(2);
  DECLARE $sql        VARCHAR(1000);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_UpdRegion');
  ELSE
    SET $language = fn_GetLanguage($Aid, $langID);
    if ($cID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($rgName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    if ($rgID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
     if not exists (
      select 1
      from reg_regions
      where HIID = $HIID
        and region_id = $rgID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    SET $sql = CONCAT('
      update reg_regions set
         title_', $language,'     = "', $rgName, '"
         , country_id = ', $cID, '
         , isActive   = ', IF($isActive = TRUE, 1, 0), '
         , HIID        = fn_GetStamp()
      where region_id = ', $rgID, ' AND Aid = ', $Aid, ';');
    --
    SET @s = CONCAT($sql);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
  -- /*call crm_UpdAllClientStatus();*/
END $$
DELIMITER ;
--
