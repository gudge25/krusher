DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdRecord;
CREATE PROCEDURE ast_UpdRecord(
    $token            VARCHAR(100)
    , $HIID           BIGINT
    , $record_id      INT(11)
    , $record_name    VARCHAR(255)
    , $record_source  VARCHAR(1000)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdRecord');
  ELSE
    if not exists (
      select 1
      from ast_record
      where HIID = $HIID
        and record_id = $record_id
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_record SET
      record_name       = $record_name
      , record_source   = $record_source
      , isActive        = $isActive
      , HIID            = fn_GetStamp()
    WHERE record_id = $record_id AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
