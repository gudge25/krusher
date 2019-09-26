DELIMITER $$
DROP PROCEDURE IF EXISTS crm_IPInsClientStatus;
CREATE PROCEDURE crm_IPInsClientStatus (
    $clID       INT
    , $Aid      INT
    , $ffID     INT
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Добавляем статус клиента'
BEGIN
  INSERT INTO crmStatus
  (
    clID
    , ccStatus
    , clStatus
    , isFixed
    , Aid
    , ffID
  )
  VALUES
  (
    $clID
    , (SELECT crm_IPGetCallStatus($clID))
    , (SELECT crm_IPGetClientStatus($clID))
    , 0
    , $Aid
    , $ffID);
END $$
DELIMITER ;
--
