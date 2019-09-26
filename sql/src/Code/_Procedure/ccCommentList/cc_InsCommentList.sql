DELIMITER $$
DROP PROCEDURE IF EXISTS cc_InsCommentList;
CREATE PROCEDURE cc_InsCommentList(
    $token          VARCHAR(100)
    , $comID        INT
    , $comName      VARCHAR(200)
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_InsCommentList');
  ELSE
    INSERT INTO ccCommentList (
        comID
        , comName
        , isActive
        , Aid
        , HIID
    )
    VALUES (
        $comID
        , $comName
        , $isActive
        , $Aid
        , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
