DROP PROCEDURE IF EXISTS crm_IPUpdStatusFile;
DELIMITER $$
CREATE PROCEDURE crm_IPUpdStatusFile (
   $ffID  int
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Обновляет все статусы клиента'
BEGIN
  DELETE FROM crmStatus WHERE ffID = $ffID;
    --
  INSERT crmStatus (
    clID
    , ccStatus
    , clStatus
    , isFixed
    , Aid
    , ffID
  )
  SELECT
    fc.clID
    , (SELECT crm_IPGetCallStatus(fc.clID))
    , (SELECT crm_IPGetClientStatus(fc.clID))
    , 0
    , Aid
    , fc.ffID
  FROM crmClient fc
  WHERE fc.ffID = $ffID /* AND fc.clID NOT IN (SELECT clID FROM crmStatus WHERE ffID = $ffID)*/;
  --
  UPDATE fsFile SET
    clients_count = (SELECT count(*) FROM crmClient WHERE ffID = $ffID),
    phones_count = (SELECT count(*) FROM crmContact WHERE clID IN (SELECT clID FROM crmClient WHERE ffID = $ffID) AND ccType=36),
    trash_count = (SELECT count(*) FROM crmStatus WHERE clID IN (SELECT clID FROM crmClient WHERE ffID = $ffID) AND clStatus=103),
    status_answered_and_comment = (SELECT count(*) FROM crmStatus WHERE clID IN (SELECT clID FROM crmClient WHERE ffID = $ffID) AND ccStatus=201),
    status_answered = (SELECT count(*) FROM crmStatus WHERE clID IN (SELECT clID FROM crmClient WHERE ffID = $ffID) AND ccStatus=202),
    status_no_answered = (SELECT count(*) FROM crmStatus WHERE clID IN (SELECT clID FROM crmClient WHERE ffID = $ffID) AND ccStatus=203),
    status_busy = (SELECT count(*) FROM crmStatus WHERE clID IN (SELECT clID FROM crmClient WHERE ffID = $ffID) AND ccStatus=204),
    status_not_successfull = (SELECT count(*) FROM crmStatus WHERE clID IN (SELECT clID FROM crmClient WHERE ffID = $ffID) AND ccStatus=205)
  WHERE ffID = $ffID;
END $$
DELIMITER ;
--
