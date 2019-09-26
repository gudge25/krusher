DELIMITER $$
DROP PROCEDURE IF EXISTS sl_UpdDealItem;
CREATE PROCEDURE sl_UpdDealItem(
    $token            VARCHAR(100)
    , $HIID           bigint        -- версия
    , $dcID           int
    , $diID           int
    , $psID           int
    , $psName         varchar(1020)
    , $iPrice         decimal(14,2)
    , $iQty           decimal(14,4)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sl_UpdDealItem');
  ELSE
    if $HIID is NULL then
      -- Параметр "Версия" должен иметь значение
      call RAISE(77034,NULL);
    end if;
    if $diID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if $psID is NULL or $psName is NULL then
      -- Параметр "Продукт" должен иметь значение
      call raise(77049, NULL);
    end if;
    if $iPrice is NULL then
      -- Параметр "Цена" должен иметь значение
      call RAISE(77057,NULL);
    end if;
    --
    if not exists (
      select 1
      from slDealItem
      where HIID = $HIID
        and diID = $diID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    update slDealItem set
       psID   = $psID
      ,psName = $psName
      ,iPrice = $iPrice
      ,iQty   = $iQty
      , isActive = $isActive
    where diID = $diID
      and dcID = $dcID
      AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
