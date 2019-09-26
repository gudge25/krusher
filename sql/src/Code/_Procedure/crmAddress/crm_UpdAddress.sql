DELIMITER $$
DROP PROCEDURE IF EXISTS crm_UpdAddress;
CREATE PROCEDURE crm_UpdAddress(
    $token          VARCHAR(100)
    , $HIID         BIGINT
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
    call RAISE(77068, 'crm_UpdAddress');
  ELSE
    set $adsName = NULLIF(TRIM($adsName),'');
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
      call RAISE(77046, NULL);
    end if;
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение
      call RAISE(77004, NULL);
    end if;
    --
    if not exists (
      select 1
      from crmAddress
      where HIID = $HIID
        and adsID = $adsID AND Aid = $Aid) then
      -- Запись была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    update crmAddress set
      adsName       = $adsName
      , adtID       = $adtID
      , Postcode    = $Postcode
      , pntID       = $pntID
      , Region      = $Region
      , RegionDesc  = $RegionDesc
      , isActive    = $isActive
    where adsID = $adsID
      AND Aid = $Aid
      AND clID = $clID;
  END IF;
END $$
DELIMITER ;
--
