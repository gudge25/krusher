DELIMITER $$
DROP PROCEDURE IF EXISTS us_GetNextID;
CREATE PROCEDURE us_GetNextID (
    $token            VARCHAR(100)
    , $seqName        VARCHAR(30)
)
BEGIN
    DECLARE $Aid            INT;
    --
    SET $token = NULLIF(TRIM($token), '');
    SET $Aid = fn_GetAccountID($token);
    IF ($Aid = -999) THEN
        call RAISE(77068, 'us_GetNextID');
    ELSE
        SET @s = CONCAT('SELECT NEXTVAL(', $seqName, ') seqValue, "', $seqName, '" seqName;');
        PREPARE stmt FROM @s;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$
DELIMITER ;
--
