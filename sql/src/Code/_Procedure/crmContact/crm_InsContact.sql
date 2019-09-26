DROP PROCEDURE IF EXISTS crm_InsContact;
DELIMITER $$
CREATE PROCEDURE crm_InsContact(
    $token        VARCHAR(100)
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
    call RAISE(77068, 'crm_InsContact');
  ELSE
    if $ccID is NULL then
      -- 'Параметр "ID контакта" должен иметь значение';
      call raise(77008, NULL);
    end if;
    if $clID is NULL then
      -- 'Параметр "ID клиента" должен иметь значение';
      call raise(77004, NULL);
    end if;
    if $ccType is NULL then
      -- 'Параметр "Тип" должен иметь значение';
      call raise(77009, NULL);
    end if;
    --
    set $ccName = TRIM($ccName);
    --
    if NULLIF($ccName, '') is NULL then
      -- 'Параметр "Контакт" должен иметь значение';
      call raise(77010, NULL);
    end if;
    --
    insert INTO crmContact (
      HIID
      , ccID
      , Aid
      , clID
      , ccName
      , ccType
      , isPrimary
      , isActive
      , ccStatus
      , ccComment
      , gmt
      , MCC
      , MNC
      , id_country
      , id_region
      , id_area
      , id_city
      , id_mobileProvider
      , ffID
    )
    values (
      fn_GetStamp()
      , $ccID
      , $Aid
      , $clID
      , $ccName
      , $ccType
      , IFNULL($isPrimary,0)
      , IF($isActive = TRUE, 1, 0)
      , $ccStatus
      , $ccComment
      , if($ccType = 36, reg_GetGmtInfo($Aid, $ccName), NULL)
      , if($ccType = 36, reg_GetMCCInfo($Aid, $ccName), NULL)
      , if($ccType = 36, reg_GetMNCInfo($Aid, $ccName), NULL)
      , if($ccType = 36, reg_GetCountryInfo($Aid, $ccName), NULL)
      , if($ccType = 36, reg_GetRegionInfo($Aid, $ccName), NULL)
      , if($ccType = 36, reg_GetAreaInfo($Aid, $ccName), NULL)
      , if($ccType = 36, reg_GetCityInfo($Aid, $ccName), NULL)
      , if($ccType = 36, reg_GetOperatorInfo($Aid, $ccName), NULL)
      , (SELECT ffID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
    );
    --
    if $ccType = 36 then
      /*call crm_IPUpdateRegionByClient($token, $clID);*/
      call crm_IPUpdStatus(/*$token, */$clID);
      call cc_IPUpdContactByPhone($token, $ccName, $clID);
    end if;
  END IF;
END $$
DELIMITER ;
--
