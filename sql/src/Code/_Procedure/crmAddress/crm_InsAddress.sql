DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsAddress;
CREATE PROCEDURE crm_InsAddress(
    $token          VARCHAR(100)
    , $adsID        INT
    , $adsName      VARCHAR(200)
    , $adtID        INT
    , $Postcode     VARCHAR(10)
    , $clID         INT
    , $pntID        INT
    , $Region       VARCHAR(100)
    , $RegionDesc   VARCHAR(200)
    , $isActive     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsAddress');
  ELSE
    set $adsName = NULLIF(TRIM($adsName), '');
    --
    if ($adsID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($adsName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    if $adtID is NULL then
      -- Параметр "Тип адреса" должен иметь значение
      call raise(77046, NULL);
    end if;
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение
      call raise(77004, NULL);
    end if;
    --
    INSERT INTO crmAddress (
      HIID
      , clID
      , adsID
      , adsName
      , adtID
      , Postcode
      , pntID
      , Region
      , RegionDesc
      , isActive
      , Aid
    )
    VALUES (
      fn_GetStamp()
      , $clID
      , $adsID
      , $adsName
      , $adtID
      , $Postcode
      , $pntID
      , $Region
      , $RegionDesc
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
