DELIMITER $$
DROP PROCEDURE IF EXISTS sl_DelDeal;
CREATE PROCEDURE sl_DelDeal(
    $token            VARCHAR(100)
    , $dcID           int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sl_DelDeal');
  ELSE
    if $dcID is NULL then
      -- Параметр "ID документа" должен иметь значение
      call RAISE(77001,NULL);
    end if;
    --
    delete from slDealItem
    where dcID = $dcID AND Aid = $Aid;
    --
    delete from slDeal
    where dcID = $dcID AND Aid = $Aid;
    --
    call dc_IPDelDoc($Aid, $dcID);
  END IF;
END $$
DELIMITER ;
--
