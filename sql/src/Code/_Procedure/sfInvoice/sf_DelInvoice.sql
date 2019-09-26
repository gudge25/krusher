DROP PROCEDURE IF EXISTS sf_DelInvoice;
DELIMITER $$
CREATE PROCEDURE sf_DelInvoice(
    $token            VARCHAR(100)
    , $dcID           int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sf_DelInvoice');
  ELSE
    if $dcID is NULL then
      -- Параметр "ID документа" должен иметь значение
      call RAISE(77001,NULL);
    end if;
    --
    delete from sfInvoiceItem
    where dcID = $dcID AND Aid = $Aid;
    --
    delete from sfInvoice
    where dcID = $dcID AND Aid = $Aid;
    --
    call dc_IPDelDoc($Aid, $dcID);
  END IF;
END $$
DELIMITER ;
--
