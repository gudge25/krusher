DELIMITER $$
DROP PROCEDURE IF EXISTS mp_DelIntegrationInstall;
CREATE PROCEDURE mp_DelIntegrationInstall(
    $token          VARCHAR(100)
    , $mpiID         INT
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $mpID            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'mp_DelIntegrationInstall');
  ELSE
    SELECT mpID
    INTO $mpID
    FROM mp_IntegrationInstall
    WHERE mpiID = $mpiID AND Aid = $Aid;
    --
    DELETE FROM mp_IntegrationInstall
    WHERE mpiID = $mpiID AND Aid = $Aid;
    --
    UPDATE mp_IntegrationList SET countInstalls = (SELECT count(*) FROM mp_IntegrationInstall WHERE mpID = $mpID) WHERE mpID = $mpID;
  END IF;
END $$
DELIMITER ;
--
