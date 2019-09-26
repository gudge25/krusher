DELIMITER $$
DROP PROCEDURE IF EXISTS crm_GetClientByName;
CREATE PROCEDURE crm_GetClientByName(
    $token        VARCHAR(100)
    , $clName     VARCHAR(50)
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetClientByName');
  ELSE
    SELECT
       clID,
       clName
    FROM crmClient
    WHERE clName LIKE CONCAT($clName, '%') AND Aid = $Aid
    GROUP BY clName
    LIMIT 50;
  END IF;
END $$
DELIMITER ;
--
