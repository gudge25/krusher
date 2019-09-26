DELIMITER $$
DROP PROCEDURE IF EXISTS mp_UpdIntegrationInstall;
CREATE PROCEDURE mp_UpdIntegrationInstall(
    $HIID                           BIGINT
    , $token                        VARCHAR(100)
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
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
    DECLARE $Aid            INT;
    --
    SET $token = NULLIF(TRIM($token), '');
    SET $Aid = fn_GetAccountID($token);
    IF ($Aid = -999) THEN
        call RAISE(77068, 'mp_UpdIntegrationInstall');
    ELSE
        if not exists (
                select 1
                from mp_IntegrationInstall
                WHERE HIID = $HIID
                  AND mpiID = $mpiID
                  AND Aid = $Aid) then
            -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
            call RAISE(77003, NULL);
        end if;
        IF ($mpiID is NULL) THEN
            call RAISE(77076, 'mpiID');
        END IF;
        IF ($mpID is NULL) THEN
            call RAISE(77076, 'mpID');
        END IF;
        --
        IF($pass IS NULL OR LENGTH(TRIM($pass)) =0) THEN
            UPDATE mp_IntegrationInstall SET
                login            = $login
                , isActive         = $isActive
                , token            = $token
                , link             = $link
                , token            = $tokenAccess
                , data1            = $data1
                , data2            = $data2
                , data3            = $data3
            WHERE mpiID = $mpiID AND Aid = $Aid;
        ELSE
            UPDATE mp_IntegrationInstall SET
                login            = $login
                , pass             = $pass
                , isActive         = $isActive
                , token            = $token
                , link             = $link
                , token            = $tokenAccess
                , data1            = $data1
                , data2            = $data2
                , data3            = $data3
            WHERE mpiID = $mpiID AND Aid = $Aid;
        END IF;
        UPDATE mp_IntegrationList SET countInstalls = (SELECT count(*) FROM mp_IntegrationInstall WHERE mpID = $mpID) WHERE mpID = $mpID;
    END IF;
END $$
DELIMITER ;
--
