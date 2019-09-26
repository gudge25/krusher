DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdTtsFields;
CREATE PROCEDURE ast_UpdTtsFields (
    $token            VARCHAR(100)
    , $HIID           BIGINT
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
    call RAISE(77068, 'ast_UpdTtsFields');
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
    --
    if not exists (
      select 1
      from ast_tts_fields
      where HIID = $HIID
        and ttsfID = $ttsfID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    SET $sql = CONCAT('update ast_tts_fields set
       field     = "', $field, '"
       , fieldName_', $language,' = "', $fieldName, '"
       , HIID        = ', fn_GetStamp(), '
       , isActive        = ', IF($isActive =  TRUE, 1, 0), '
    WHERE ttsfID = ', $ttsfID, ' AND Aid = ', $Aid,' ;');
    CALL query_exec($sql);
  END IF;
END $$
DELIMITER ;
--
