DELIMITER $$
DROP PROCEDURE IF EXISTS em_InsNewRole;
CREATE PROCEDURE em_InsNewRole(
    $roleName       VARCHAR(50)
    , $Permission   INT
)
BEGIN
    DECLARE $Aid            INT;
    DECLARE $Aid_cur        INT;
    --
    SELECT MAX(id_client)
    INTO $Aid
    FROM emClient
    WHERE isActive = TRUE;
    SET $Aid_cur = 0;
    WHILE $Aid_cur < $Aid DO
        SELECT id_client
        INTO $Aid_cur
        FROM emClient
        WHERE isActive = TRUE
            AND id_client > $Aid_cur
        ORDER BY id_client
        LIMIT 1;
        IF((SELECT COUNT(1)
            FROM emRole
            WHERE Aid = $Aid_cur AND Permission = $Permission
            ) = 0)THEN
            INSERT INTO emRole (HIID, roleID, roleName, isActive, Permission, Aid)
                    VALUES(fn_GetStamp(), NEXTVAL(roleID), $roleName, 1, $Permission, $Aid_cur);
        END IF;
    END WHILE;
END $$
DELIMITER ;
--
