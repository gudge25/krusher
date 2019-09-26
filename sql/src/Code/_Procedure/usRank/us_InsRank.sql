DELIMITER $$
DROP PROCEDURE IF EXISTS us_InsRank;
CREATE PROCEDURE us_InsRank (
    $token            VARCHAR(100)
    , $uID            VARCHAR(20)
    , $uRank          VARCHAR(200)
    , $type           INT
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $emID           INT;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_InsRank');
  ELSE
    SET $emID = fn_GetEmployID($token);
    SET $uRank = NULLIF(TRIM($uRank), '');
    --
    IF ($uID is NULL) THEN
      -- Параметр "ID записи" должен иметь значение
      CALL RAISE(77021, NULL);
    END IF;
    IF ($uRank is NULL) THEN
      -- Параметр "Название" должен иметь значение
      CALL RAISE(77022, NULL);
    END IF;
    --
    INSERT INTO usRank (
      uID
      , uRank
      , isActive
      , emID
      , Aid
      , HIID
      , `type`
    )
    VALUES (
      $uID
      , $uRank
      , $isActive
      , $emID
      , $Aid
      , fn_GetStamp()
      , $type
    );
  END IF;
END $$
DELIMITER ;
--
