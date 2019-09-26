DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsResponsible;
CREATE PROCEDURE crm_InsResponsible(
    $token            VARCHAR(100)
    , $clID           INT
    , $responsibleID  INT
    , $isActive       BIT
)
DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsResponsible');
  ELSE
    UPDATE crmClient
    SET responsibleID = $responsibleID
        , isActive    = $isActive
    WHERE clID=$clID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
