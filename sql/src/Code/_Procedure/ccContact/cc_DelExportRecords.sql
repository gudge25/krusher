DELIMITER $$
DROP PROCEDURE IF EXISTS cc_DelExportRecords;
CREATE PROCEDURE cc_DelExportRecords(
    $token          VARCHAR(100)
    , $idCR         INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_DelExportRecords');
  ELSE
    delete from ccContactRecords
    where idCR = $idCR AND Aid = $Aid;
    --
  END IF;
END $$
DELIMITER ;
--
