DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsCallback;
CREATE PROCEDURE ast_InsCallback(
    $token                          VARCHAR(100)
    , $cbID                         INT(11)
    , $cbName                       VARCHAR(50)
    , $timeout                      INT(11)
    , $isFirstClient                BIT
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsCallback');
  ELSE
    INSERT INTO ast_callback (
      HIID
      , cbID
      , Aid
      , cbName
      , timeout
      , isFirstClient
      , destination
      , destdata
      , destdata2
      , isActive
    )
    VALUES (
      fn_GetStamp()
      , $cbID
      , $Aid
      , $cbName
      , $timeout
      , $isFirstClient
      , $destination
      , $destdata
      , $destdata2
      , $isActive
    );
  END IF;
END $$
DELIMITER ;
--
