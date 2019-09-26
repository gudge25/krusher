DROP PROCEDURE IF EXISTS crm_UpdContact;
DELIMITER $$
CREATE PROCEDURE crm_UpdContact(
    $token        VARCHAR(100)
    , $HIID       BIGINT
    , $ccID       INT
    , $clID       INT
    , $ccName     VARCHAR(250)
    , $ccType     INT
    , $isPrimary  BIT
    , $ccStatus   INT
    , $ccComment  VARCHAR(100)
    , $isActive   BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdContact');
  ELSE
    set $ccName = NULLIF(TRIM($ccName),'');
    --
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение;
      call RAISE(77004, NULL);
    end if;
    if $ccID is NULL then
      -- 'Параметр "ID контакта" должен иметь значение';
      call RAISE(77008, NULL);
    end if;
    if $ccType is NULL then
      -- 'Параметр "Тип" должен иметь значение';
      call RAISE(77009, NULL);
    end if;
    if $ccName is NULL then
      -- 'Параметр "Контакт" должен иметь значение';
      call RAISE(77010, NULL);
    end if;
    --
    if not exists (
      select 1
      from crmContact
      where HIID = $HIID
        and ccID = $ccID) then
      -- Запись была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    SET $ccName = TRIM($ccName);
      --
    update crmContact set
      ccID        = $ccID
      , ccName    = $ccName
      , ccType    = $ccType
      , isPrimary = IFNULL($isPrimary, 0)
      , isActive  = IFNULL($isActive, 0)
      , ccStatus  = $ccStatus
      , ccComment = $ccComment
      , HIID      = fn_GetStamp()
      , gmt       = if($ccType = 36, reg_GetGmtInfo($Aid, $ccName), NULL)
      , MCC       = if($ccType = 36, reg_GetMCCInfo($Aid, $ccName), NULL)
      , MNC       = if($ccType = 36, reg_GetMNCInfo($Aid, $ccName), NULL)
      , id_country= if($ccType = 36, reg_GetCountryInfo($Aid, $ccName), NULL)
      , id_region = if($ccType = 36, reg_GetRegionInfo($Aid, $ccName), NULL)
      , id_area   = if($ccType = 36, reg_GetAreaInfo($Aid, $ccName), NULL)
      , id_city   = if($ccType = 36, reg_GetCityInfo($Aid, $ccName), NULL)
      , id_mobileProvider = if($ccType = 36, reg_GetOperatorInfo($Aid, $ccName), NULL)
    where ccID = $ccID
      and clID = $clID
      AND Aid = $Aid;
    --
    if $ccType = 36 then
      call crm_IPUpdStatus($clID);
      call cc_IPUpdContactByPhone($token, $ccName, $clID);
    end if;
  END IF;
END $$
DELIMITER ;
--
