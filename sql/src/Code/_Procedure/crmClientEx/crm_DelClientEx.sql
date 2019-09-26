DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelClientEx;
CREATE PROCEDURE crm_DelClientEx(
    $token        VARCHAR(100)
    , $clID       INT
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Обновляет расширеную шапку клиента'
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_DelClientEx');
  ELSE
    IF $clID is NULL THEN
      -- Параметр "ID клинта" должен иметь значение;
      call RAISE(77004, NULL);
    END IF;
    --
    DELETE FROM crmClientEx
    WHERE clID = $clID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
