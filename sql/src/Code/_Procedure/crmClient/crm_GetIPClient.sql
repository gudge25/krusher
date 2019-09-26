DROP PROCEDURE IF EXISTS crm_GetIPClient;
DELIMITER $$
CREATE PROCEDURE crm_GetIPClient(
    $token        VARCHAR(100)
    , $ccName     VARCHAR(50)
)
BEGIN
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetIPClient');
  ELSE
    SELECT
      cl.clName     clName
    FROM crmClient cl
      INNER JOIN crmContact co ON co.clID = cl.clID
    WHERE cl.isActive = 1
      AND cl.isActual = 0
      AND co.ccType = 36
      AND cl.Aid = $Aid
      AND co.ccName LIKE CONCAT('%', $ccName)
    LIMIT 1;
  END IF;
END $$
DELIMITER ;
--
