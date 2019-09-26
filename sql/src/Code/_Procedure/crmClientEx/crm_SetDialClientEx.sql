DROP PROCEDURE IF EXISTS crm_SetDialClientEx;
DELIMITER $$
CREATE PROCEDURE crm_SetDialClientEx(
    $clID           int
    , $isdial       bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $emID           INT;
  --
  IF($clID IS NOT NULL) THEN
    SET $isdial = IFNULL($isdial, 0);
    --
    UPDATE crmClientEx SET
        isDial        = $isdial
    WHERE clID = $clID;
  END IF;
END $$
DELIMITER ;
--
