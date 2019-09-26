DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelScenario;
CREATE PROCEDURE ast_DelScenario(
    $token          VARCHAR(100)
    , $id_scenario  INT
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelScenario');
  ELSE
    DELETE FROM ast_scenario
    WHERE id_scenario = $id_scenario AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
