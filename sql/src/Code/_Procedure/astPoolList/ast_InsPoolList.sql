DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsPoolList;
CREATE PROCEDURE ast_InsPoolList(
    $token                          VARCHAR(100)
    , $plID                         INT(11)
    , $poolID                       INT(11)
    , $trID                         INT(11)
    , $percent                      INT(11)
    , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsPoolList');
  ELSE
    INSERT INTO ast_pool_list (
      HIID
      , poolID
      , Aid
      , plID
      , trID
      , percent
      , isActive
    )
    VALUES (
      fn_GetStamp()
      , $poolID
      , $Aid
      , $plID
      , $trID
      , $percent
      , $isActive
    );
  END IF;
END $$
DELIMITER ;
--
