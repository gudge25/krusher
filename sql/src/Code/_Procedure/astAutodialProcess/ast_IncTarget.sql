DELIMITER $$
DROP PROCEDURE IF EXISTS ast_IncTarget;
CREATE PROCEDURE ast_IncTarget(
    $token              VARCHAR(100)
    , $id_autodial      INT(11)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_IncTarget');
  ELSE
    SET $id_autodial = IFNULL($id_autodial, 0);
    --
    IF ($id_autodial > 0) THEN
      UPDATE ast_autodial_process SET
        targetCalls = targetCalls + 1
      WHERE id_autodial = $id_autodial;
    END IF;
  END IF;
END $$
DELIMITER ;
--
