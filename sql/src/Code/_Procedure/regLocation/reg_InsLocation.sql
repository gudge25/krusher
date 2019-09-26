DELIMITER $$
DROP PROCEDURE IF EXISTS reg_InsLocation;
CREATE PROCEDURE reg_InsLocation(
    $token            VARCHAR(100)
    , $lID            INT
    , $lName          VARCHAR(150)
    , $cID            INT
    , $rgID           INT
    , $isActive       bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  /*DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_InsLocation');
  ELSE
    set $aName = NULLIF(TRIM($aName),'');
    if (($cID is NULL) OR ($rgID is NULL) OR ($aID is NULL))then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($aName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    insert IGNORE INTO reg_cities (
      city_id
      , country_id
      , region_id
      , Aid
      , area_ru
      , isActive
      , HIID
    )
    values (
      $aID
      , $cID
      , $rgID
      , $Aid
      , $aName
      , $isActive
      , fn_GetStamp()
    );
  END IF;*/
END $$
DELIMITER ;
--
