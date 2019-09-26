DELIMITER $$
DROP PROCEDURE IF EXISTS em_DelRole;
CREATE PROCEDURE em_DelRole(
    $token        VARCHAR(100)
    , $roleID     INT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_DelRole');
  ELSE
    IF ($roleID is NULL) THEN
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    END IF;
    --
    DELETE FROM emRole
    WHERE roleID = $roleID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
