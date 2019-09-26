DELIMITER $$
DROP PROCEDURE IF EXISTS sf_DelInvoiceItem;
CREATE PROCEDURE sf_DelInvoiceItem(
    $token            VARCHAR(100)
    , $iiID           int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sf_DelInvoiceItem');
  ELSE
    if ($iiID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from sfInvoiceItem
    where iiID = $iiID AND Aid = $Aid;
  END IF;
END $$
DElIMITER ;
--
