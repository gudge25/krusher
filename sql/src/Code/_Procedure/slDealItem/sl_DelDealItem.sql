DELIMITER $$
DROP PROCEDURE IF EXISTS sl_DelDealItem;
CREATE PROCEDURE sl_DelDealItem(
    $token            VARCHAR(100)
    , $diID           int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sl_DelDealItem');
  ELSE
    if ($diID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from slDealItem
    where diID = $diID AND Aid = $Aid;
  END IF;
END $$
DElIMITER ;
--
