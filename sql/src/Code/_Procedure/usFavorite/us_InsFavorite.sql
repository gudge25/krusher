DROP PROCEDURE IF EXISTS us_InsFavorite;
DELIMITER $$
CREATE PROCEDURE us_InsFavorite (
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
    call RAISE(77068, 'us_InsFavorite');
  ELSE
    SET $emID = fn_GetEmployID($token);
    IF ($uID is NULL) THEN
      -- Параметр "ID записи" должен иметь значение
      CALL RAISE(77021,NULL);
    END IF;
    --
    SET $faComment = NULLIF(TRIM($faComment),'');
    --
    INSERT INTO usFavorite (
       emID
      ,uID
      ,faComment
      , isActive
      , Aid
    )
    VALUES (
       $emID
      ,$uID
      ,$faComment
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
