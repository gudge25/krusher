DELIMITER $$
DROP PROCEDURE IF EXISTS cc_DelContact;
CREATE PROCEDURE cc_DelContact(
    $token          VARCHAR(100)
    , $dcID         INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_DelContact');
  ELSE
    delete from ccContact
    where dcID = $dcID AND Aid = $Aid;
    --
    call dc_IPDelDoc($Aid, $dcID);
  END IF;
END $$
DELIMITER ;
--
