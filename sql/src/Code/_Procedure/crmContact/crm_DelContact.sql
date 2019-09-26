DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelContact;
CREATE PROCEDURE crm_DelContact(
    $token        VARCHAR(100)
    , $ccID       INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_DelContact');
  ELSE
    if $ccID is NULL then
      -- 'Параметр ID контакта должен иметь значение';
      call raise(77008, NULL);
    end if;
    --
    delete from crmContact
    where ccID = $ccID;
  END IF;
END $$
DELIMITER ;
--
