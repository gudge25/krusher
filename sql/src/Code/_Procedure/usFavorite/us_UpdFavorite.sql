DROP PROCEDURE IF EXISTS us_UpdFavorite;
DELIMITER $$
CREATE PROCEDURE us_UpdFavorite (
    $token            VARCHAR(100)
    , $uID            VARCHAR(20)
    , $faComment      VARCHAR(200)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $emID   INT;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_UpdFavorite');
  ELSE
    SET $emID = fn_GetEmployID($token);
    SET $faComment = NULLIF(TRIM($faComment),'');
    --
    SELECT $faComment;
    --
    UPDATE usFavorite SET
      faComment = $faComment
      , isActive = $isActive
    WHERE uID = $uID
      AND emID = $emID
      AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
