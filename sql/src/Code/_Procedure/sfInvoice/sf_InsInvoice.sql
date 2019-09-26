DROP PROCEDURE IF EXISTS sf_InsInvoice;
DELIMITER $$
CREATE PROCEDURE sf_InsInvoice(
    $token            VARCHAR(100)
    , $dcID           int           -- ID документа
    , $dcNo           varchar(35)   -- Номер документа
    , $dcDate         date          -- дата документа
    , $dcLink         int           -- ID документа основания
    , $dcComment      varchar(200)  -- комментарий
    , $dcSum          decimal(14,2) -- сумма документа
    , $dcStatus       int           -- статус документа
    , $clID           int           -- ID клиента
    , $emID           int           -- ID владельца
    , $isActive       BIT
    , $Delivery       varchar(255)  -- адрес доставки
    , $VATSum         decimal(14,2) -- НДС
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  declare $isHasDoc bit;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sf_InsInvoice');
  ELSE
    if $dcID is NULL then
      -- Параметр ID документа должен иметь значение
      call raise(77001, NULL);
    end if;
    if $dcDate is NULL then
      -- Параметр "Дата документа" должен иметь значение
      call raise(77033, NULL);
    end if;
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение
      call raise(77004, NULL);
    end if;
    if $emID is NULL then
      -- Параметр "ID сотрудника" должен иметь значение
      call raise(77007, NULL);
    end if;
    --
    call dc_IPInsDoc($Aid, $dcID ,5,$dcNo, 0, $dcDate ,$dcLink ,$dcComment ,$dcSum ,$dcStatus ,$clID ,$emID, 0, 1);
    --
    insert sfInvoice (
       HIID
      ,dcID
      ,Delivery
      ,VATSum
      , isActive
      , Aid
    )
    values (
       fn_GetStamp()
      ,$dcID
      ,$Delivery
      ,$VATSum
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
