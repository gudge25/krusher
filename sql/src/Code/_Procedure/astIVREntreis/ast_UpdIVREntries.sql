DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdIVREntries;
CREATE PROCEDURE ast_UpdIVREntries(
    $token              VARCHAR(100)
    , $HIID             BIGINT
    , $entry_id         INT(11)
    , $id_ivr_config    INT(11)
    , $extension        VARCHAR(20)
    , $destination      INT(11)
    , $destdata         INT(11)
    , $destdata2        VARCHAR(100)
    , $return           BIT
    , $isActive         BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdIVREntries');
  ELSE
    if not exists (
      select 1
      from ast_ivr_entries
      where HIID = $HIID
        and entry_id = $entry_id
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_ivr_entries SET
      id_ivr_config     = $id_ivr_config
      , extension       = $extension
      , destination     = $destination
      , destdata        = $destdata
      , destdata2       = $destdata2
      , `return`        = $return
      , isActive        = $isActive
      , HIID            = fn_GetStamp()
    WHERE entry_id = $entry_id AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
