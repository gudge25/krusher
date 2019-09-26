DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsTtsFields;
CREATE PROCEDURE ast_InsTtsFields (
   $token             VARCHAR(100)
    , $ttsfID         INT(11)
    , $field          VARCHAR(50)
    , $langID         INT
    , $fieldName      VARCHAR(100)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $sql            VARCHAR(2000);
  DECLARE $language       VARCHAR(2);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsTtsFields');
  ELSE
    SET $language = fn_GetLanguage($Aid, $langID);
    --
    if ($ttsfID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($field is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    if ($fieldName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    SET $sql = CONCAT('INSERT INTO ast_tts_fields (
      ttsfID
      , field
      , fieldName_', $language,'
      , Aid
      , HIID
    )
    values (',
      $ttsfID, '
      , "', $field, '"
      , "', $fieldName, '"
      , ', $Aid, '
      , ', fn_GetStamp(), ' );');
    CALL query_exec($sql);
  END IF;
END $$
DELIMITER ;
--
