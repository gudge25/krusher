DROP PROCEDURE IF EXISTS sf_InsInvoiceItem;
DELIMITER $$
CREATE PROCEDURE sf_InsInvoiceItem(
    $token            VARCHAR(100)
    , $dcID           int             -- ID документа
    , $iiID           int             -- PK
    , $OwnerID        int             -- главная позиция
    , $psID           int             -- ID материала
    , $iNo            smallint        -- номер позиции
    , $iName          varchar(1020)   -- наименование позиции
    , $iPrice         decimal(14,4)   --
    , $iQty           decimal(14,4)   -- количетсво
    , $iComments      varchar(255)    -- комментарии
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sf_InsInvoiceItem');
  ELSE
    if ($dcID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($iiID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if $iPrice is NULL then
      -- Параметр "Цена" должен иметь значение
      call RAISE(77057,NULL);
    end if;
    --
    insert sfInvoiceItem (
       HIID
      ,iiID
      ,OwnerID
      ,dcID
      ,psID
      ,iNo
      ,iName
      ,iPrice
      ,iQty
      ,iComments
      , isActive
      , Aid
    )
    values (
       fn_GetStamp()
      ,$iiID
      ,$OwnerID
      ,$dcID
      ,$psID
      ,$iNo
      ,$iName
      ,$iPrice
      ,$iQty
      ,$iComments
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
