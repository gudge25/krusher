DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsPools;
CREATE PROCEDURE ast_InsPools(
    $token                          VARCHAR(100)
    , $poolID                       INT(11)
    , $poolName                     VARCHAR(50)
    , $priority                     INT(11)
    , $coID                         INT(11)
    , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsPools');
  ELSE
    INSERT INTO ast_pools (
      HIID,
      poolID,
      Aid,
      poolName,
      priority,
      isActive,
      coID
    )
    VALUES (
      fn_GetStamp()
      , $poolID
      , $Aid
      , $poolName
      , $priority
      , $isActive
      , $coID
    );
  END IF;
END $$
DELIMITER ;
--
