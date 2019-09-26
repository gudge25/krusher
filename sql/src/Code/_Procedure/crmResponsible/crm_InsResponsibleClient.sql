DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsResponsibleClient;
CREATE PROCEDURE crm_InsResponsibleClient (
    $token          VARCHAR(100)
    , $emID         INT
    , $arrClients   MEDIUMTEXT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsResponsibleClient');
  ELSE
    DROP TABLE IF EXISTS __temp;
    CREATE TEMPORARY TABLE __temp(
      clID int
      , Aid  int  NOT NULL
      , PRIMARY KEY (clID)
      , INDEX `Aid` (`Aid`)
    )ENGINE=MEMORY;
    --
    call sp_split($arrClients, ',', '__temp', $Aid);
    --
    UPDATE crmClient
    SET responsibleID = $emID
    WHERE clID IN (SELECT clID FROM __temp WHERE Aid = $Aid) AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
