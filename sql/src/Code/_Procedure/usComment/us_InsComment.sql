DELIMITER $$
DROP PROCEDURE IF EXISTS us_InsComment;
CREATE PROCEDURE us_InsComment (
    $token            VARCHAR(100)
    , $uID            VARCHAR(20)
    , $uComment       VARCHAR(200)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $emID INT;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_InsComment');
  ELSE
    SET $emID = fn_GetEmployID($token);
    SET $uComment = NULLIF(TRIM($uComment),'');
    --
    IF ($uID is NULL) THEN
      -- Параметр "ID записи" должен иметь значение
      CALL RAISE(77021,NULL);
    END IF;
    IF ($uComment is NULL) THEN
      -- Параметр "Название" должен иметь значение
      CALL RAISE(77022,NULL);
    END IF;
    --
    INSERT INTO usComment (
       uID
      ,uComment
      ,isActive
      ,CreatedBy
      , Aid
      , HIID
    )
    VALUES (
       $uID
      ,$uComment
      ,$isActive
      ,$emID
      , $Aid
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
