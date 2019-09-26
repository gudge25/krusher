DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsTimeGroup;
CREATE PROCEDURE ast_InsTimeGroup(
    $token                          VARCHAR(100)
    , $tgID                         INT(11)
    , $tgName                       VARCHAR(50)
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $invalid_destination          INT(11)
    , $invalid_destdata             INT(11)
    , $invalid_destdata2            VARCHAR(100)
    , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsTimeGroup');
  ELSE
    INSERT INTO ast_time_group (
      HIID
      , tgID
      , Aid
      , tgName
      , destination
      , destdata
      , destdata2
      , invalid_destination
      , invalid_destdata
      , invalid_destdata2
      , isActive
    )
    VALUES (
      fn_GetStamp()
      , $tgID
      , $Aid
      , $tgName
      , $destination
      , $destdata
      , $destdata2
      , $invalid_destination
      , $invalid_destdata
      , $invalid_destdata2
      , $isActive
    );
  END IF;
END $$
DELIMITER ;
--
