DELIMITER $$
DROP FUNCTION IF EXISTS crm_IPGetClientStatus;
CREATE FUNCTION crm_IPGetClientStatus (
    $clID VARCHAR(50)
) RETURNS VARCHAR(50)
BEGIN
  DECLARE $status SMALLINT DEFAULT 103;
  --
  IF exists (
        SELECT 1
          FROM crmContact c
        WHERE c.clID = $clID
          AND c.ccType = 36
          AND c.id_country IS NOT NULL
      )
  THEN
    SET $status = 101;
  ELSE
    SET $status = 103;
  END IF;
  RETURN $status;
END $$
DELIMITER ;
--
