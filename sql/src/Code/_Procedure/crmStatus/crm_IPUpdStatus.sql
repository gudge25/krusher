DELIMITER $$
DROP PROCEDURE IF EXISTS crm_IPUpdStatus;
CREATE PROCEDURE crm_IPUpdStatus (
   $clID      INT
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Обновляет статусы клиента'
BEGIN
  DECLARE $clStatus SMALLINT;
  DECLARE $ccStatus SMALLINT;
  --
  SET $clStatus = (SELECT crm_IPGetClientStatus($clID));
  --
  SET $ccStatus = (SELECT crm_IPGetCallStatus($clID));
  --
  UPDATE crmStatus SET
    clStatus = $clStatus
    , ccStatus = $ccStatus
  WHERE clID = $clID;
  --
  IF($clID > 0) THEN
    IF($ccStatus = 201) THEN
      UPDATE fsFile SET
        status_answered_and_comment = status_answered_and_comment + 1
      WHERE ffID IN (SELECT ffID FROM crmClient WHERE clID = $clID);
    ELSEIF($ccStatus = 202) THEN
      UPDATE fsFile SET
        status_answered = status_answered + 1
      WHERE ffID IN (SELECT ffID FROM crmClient WHERE clID = $clID);
    ELSEIF($ccStatus = 203) THEN
      UPDATE fsFile SET
        status_no_answered = status_no_answered + 1
      WHERE ffID IN (SELECT ffID FROM crmClient WHERE clID = $clID);
    ELSEIF($ccStatus = 204) THEN
      UPDATE fsFile SET
        status_busy = status_busy + 1
      WHERE ffID IN (SELECT ffID FROM crmClient WHERE clID = $clID);
    ELSE
      UPDATE fsFile SET
        status_not_successfull = status_not_successfull + 1
      WHERE ffID IN (SELECT ffID FROM crmClient WHERE clID = $clID);
    END IF;
  END IF;
END $$
DELIMITER ;
--
