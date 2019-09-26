DROP PROCEDURE IF EXISTS ast_DelBulkSms;
DELIMITER $$
CREATE PROCEDURE ast_DelBulkSms(
    $token          VARCHAR(100)
    , $bulkID       INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid         INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid < 1) THEN
    call RAISE(77068, 'ast_DelBulkSms');
  ELSE
    if $bulkID is NULL then
      -- 'Параметр ID контакта должен иметь значение';
      call raise(77008, NULL);
    end if;
    --
    delete from cc_SmsBulk
    where bulkID = $bulkID;
  END IF;
END $$
DELIMITER ;
--
