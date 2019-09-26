DROP PROCEDURE IF EXISTS fs_InsFileForce;
DELIMITER $$
CREATE PROCEDURE fs_InsFileForce(
    $token            VARCHAR(100)
    , $ffID           INT
    , $ffName         VARCHAR(200)
    , $dbID           INT
    , $Priority       INT
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid      INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_InsFileForce');
  ELSE
    INSERT fsFile (
      HIID
      , ffID
      , Aid
      , ffName
      , Priority
      , dbID
      , isActive
    )
    VALUES(
      fn_GetStamp()
      , $ffID
      , $Aid
      , $ffName
      , $Priority
      , $dbID
      , $isActive
    );
  END IF;
END $$
DELIMITER ;
--
