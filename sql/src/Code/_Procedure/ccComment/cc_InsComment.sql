DELIMITER $$
DROP PROCEDURE IF EXISTS cc_InsComment;
CREATE PROCEDURE cc_InsComment(
    $token            VARCHAR(100)
    , $cccID          INT
    , $dcID           INT
    , $comID          INT
    , $comName        VARCHAR(200)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_InsComment');
  ELSE
    INSERT INTO ccComment (
      cccID
      , dcID
      , comID
      , comName
      , Aid
      , isActive
      , HIID
    )
    VALUES (
      $cccID
      , $dcID
      , $comID
      , $comName
      , $Aid
      , $isActive
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
