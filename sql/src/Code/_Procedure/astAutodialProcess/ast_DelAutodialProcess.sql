DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelAutodialProcess;
CREATE PROCEDURE ast_DelAutodialProcess(
    $token          VARCHAR(100)
    , $id_autodial  INT
)
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelAutodialProcess');
  ELSE
    DELETE FROM ast_autodial_process
    WHERE id_autodial = $id_autodial AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
