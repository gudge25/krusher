DROP PROCEDURE IF EXISTS pch_DelPayment;
DELIMITER $$
CREATE PROCEDURE pch_DelPayment(
    $token            VARCHAR(100)
    , $dcID           int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'pch_DelPayment');
  ELSE
    if $dcID is NULL then
      -- Параметр "ID документа" должен иметь значение
      call RAISE(77001,NULL);
    end if;
    --
    delete from pchPayment
    where dcID = $dcID AND Aid = $Aid;
    --
    call dc_IPDelDoc($Aid, $dcID);
  END IF;
END $$
DELIMITER ;
--
