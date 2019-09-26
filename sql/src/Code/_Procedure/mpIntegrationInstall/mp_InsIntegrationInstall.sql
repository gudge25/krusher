DELIMITER $$
DROP PROCEDURE IF EXISTS mp_InsIntegrationInstall;
CREATE PROCEDURE mp_InsIntegrationInstall(
        $token                          VARCHAR(100)
        , $mpiID                        INT(11)
        , $mpID                         INT(11)
        , $login                        VARCHAR(50)
        , $pass                         VARCHAR(50)
        , $tokenAccess                  VARCHAR(50)
        , $link                         VARCHAR(50)
        , $data1                        VARCHAR(250)
        , $data2                        VARCHAR(250)
        , $data3                        VARCHAR(250)
        , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'mp_InsIntegrationInstall');
  ELSE
    INSERT INTO mp_IntegrationInstall (
        mpiID
        , mpID
        , Aid
        , login
        , pass
        , token
        , link
        , isActive
        , HIID
        , data1
        , data2
        , data3
    )
    VALUES (
        $mpiID
        , $mpID
        , $Aid
        , $login
        , $pass
        , $tokenAccess
        , $link
        , $isActive
        , fn_GetStamp()
        , $data1
        , $data2
        , $data3
    );
    UPDATE mp_IntegrationList SET countInstalls = (SELECT count(*) FROM mp_IntegrationInstall WHERE mpID = $mpID) WHERE mpID = $mpID;
  END IF;
END $$
DELIMITER ;
--
