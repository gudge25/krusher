DELIMITER $$
DROP PROCEDURE IF EXISTS sf_UpdInvoiceItem;
CREATE PROCEDURE sf_UpdInvoiceItem(
    $token            VARCHAR(100)
    , $HIID           bigint        -- версия
    , $dcID           int           -- ID документа
    , $iiID           int            -- PK
    , $OwnerID        int            -- главная позиция
    , $psID           int            -- ID материала
    , $iNo            smallint       -- номер позиции
    , $iName          varchar(1020)  -- наименование позиции
    , $iPrice         decimal(14,4)   --
    , $iQty           decimal(14,4)  -- количество
    , $iComments      varchar(255)   -- комментарии
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sf_UpdInvoiceItem');
  ELSE
    if $HIID is NULL then
      -- Параметр "Версия" должен иметь значение
      call RAISE(77034,NULL);
    end if;
    if $iiID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if $iPrice is NULL then
      -- Параметр "Цена" должен иметь значение
      call RAISE(77057,NULL);
    end if;
    --
    if not exists (
      select 1
      from sfInvoiceItem
      where HIID = $HIID
        and iiID = $iiID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    set $HIID = fn_GetStamp();
    update sfInvoiceItem set
       HIID      = fn_GetStamp()
      ,OwnerID   = $OwnerID
      ,psID      = $psID
      ,iNo       = $iNo
      ,iName     = $iName
      ,iPrice    = $iPrice
      ,iQty      = $iQty
      ,iComments = $iComments
      , isActive = $isActive
    where iiID = $iiID
      and dcID = $dcID
      AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
