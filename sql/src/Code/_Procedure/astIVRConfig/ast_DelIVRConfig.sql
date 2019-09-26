DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelIVRConfig;
CREATE PROCEDURE ast_DelIVRConfig(
    $token            VARCHAR(100)
    , $id_ivr_config  INT
)
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelIVRConfig');
  ELSE
    DELETE FROM ast_ivr_config
    WHERE id_ivr_config = $id_ivr_config AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
