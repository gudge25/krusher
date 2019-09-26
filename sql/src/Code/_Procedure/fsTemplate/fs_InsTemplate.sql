DELIMITER $$
DROP PROCEDURE IF EXISTS fs_InsTemplate;
CREATE PROCEDURE fs_InsTemplate(
    $token            VARCHAR(100)
    , $ftID           int
    , $ftName         varchar(50)
    , $delimiter      char(1)
    , $Encoding       varchar(32)
    , $isActive       BIT
)
DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_InsTemplate');
  ELSE
    insert fsTemplate (
        ftID
        , ftName
        , delimiter
        , Encoding
        , isActive
        , Aid
        , HIID
    )
    values (
        $ftID
        , $ftName
        , $delimiter
        , $Encoding
        , $isActive
        , $Aid
        , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
