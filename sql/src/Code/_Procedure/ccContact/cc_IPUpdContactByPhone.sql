DROP PROCEDURE IF EXISTS cc_IPUpdContactByPhone;
DELIMITER $$
CREATE PROCEDURE cc_IPUpdContactByPhone(
    $token          VARCHAR(100)
    , $ccName       varchar(50)
    , $clID         INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid              INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_IPUpdContactByPhone');
  ELSE
    /*update dcDoc d
      inner join ccContact c on c.dcID = d.dcID
      inner join crmContact crm on crm.ccName = c.ccName
      set d.clID = crm.clID
    where crm.ccName = $ccName
      and crm.ccType = 36
      and d.clID = 0
      and d.dctID = 1;    21 06 2018*/
    UPDATE ccContact SET clID = $clID WHERE (clID = 0 OR clID IS NULL) AND ccName = $ccName AND Aid = $Aid;
    UPDATE dcDoc SET clID = $clID WHERE dcID IN (SELECT dcID FROM ccContact WHERE clID = $clID AND ccName = $ccName AND Aid = $Aid);
  END IF;
END $$
DELIMITER ;
--
