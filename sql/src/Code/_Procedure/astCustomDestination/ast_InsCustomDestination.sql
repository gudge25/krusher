DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsCustomDestination;
CREATE PROCEDURE ast_InsCustomDestination(
    $token                          VARCHAR(100)
    , $cdID                         INT(11)
    , $cdName                       VARCHAR(50)
    , $context                      VARCHAR(250)
    , $exten                        VARCHAR(50)
    , $description                  VARCHAR(250)
    , $notes                        TEXT
    , $return                       BIT
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $priority                     INT(11)
    , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsCustomDestination');
  ELSE
    INSERT INTO ast_custom_destination (
      HIID
      , cdID
      , cdName
      , context
      , Aid
      , description
      , notes
      , `return`
      , destination
      , destdata
      , destdata2
      , isActive
      , exten
      , priority
    )
    VALUES (
      fn_GetStamp()
      , $cdID
      , $cdName
      , $context
      , $Aid
      , $description
      , $notes
      , $return
      , $destination
      , $destdata
      , $destdata2
      , $isActive
      , $exten
      , $priority
    );
  END IF;
END $$
DELIMITER ;
--
