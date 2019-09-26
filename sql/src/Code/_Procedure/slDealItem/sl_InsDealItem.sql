DELIMITER $$
DROP PROCEDURE IF EXISTS sl_InsDealItem;
CREATE PROCEDURE sl_InsDealItem(
    $token            VARCHAR(100)
    , $dcID           int
    , $diID           int
    , $psID           int
    , $psName         varchar(1020)
    , $iPrice         decimal(14,2)
    , $iQty           decimal(14,4)
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sl_InsDealItem');
  ELSE
    if ($dcID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($diID is NULL) then
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
    insert slDealItem (
       HIID
      ,diID
      ,dcID
      ,psID
      ,psName
      ,iPrice
      ,iQty
      , isActive
      , Aid
    )
    values (
       fn_GetStamp()
      ,$diID
      ,$dcID
      ,$psID
      ,$psName
      ,$iPrice
      ,$iQty
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
