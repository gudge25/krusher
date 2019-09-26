DELIMITER $$
DROP PROCEDURE IF EXISTS fs_UpdTemplate;
CREATE PROCEDURE fs_UpdTemplate(
    $token            VARCHAR(100)
    , $HIID           BIGINT
    , $ftID           int
    , $ftName         varchar(50)
    , $delimiter      char(1)
    , $Encoding       varchar(32)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_UpdTemplate');
  ELSE
    if not exists (
      select 1
      from fsTemplate
      where HIID = $HIID
        and ftID = $ftID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update fsTemplate set
      ftName      = $ftName
      , delimiter = $delimiter
      , Encoding  = $Encoding
      , isActive  = $isActive
      , HIID        = fn_GetStamp()
    where ftID = $ftID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
