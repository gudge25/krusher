DROP PROCEDURE IF EXISTS us_UpdMeasure;
DELIMITER $$
CREATE PROCEDURE us_UpdMeasure (
    $token            VARCHAR(100)
    , $HIID           bigint
    , $msID           int
    , $msName         varchar(200)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_UpdMeasure');
  ELSE
    set $msName = NULLIF(TRIM($msName),'');
    --
    if ($msName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    if not exists (
      select 1
      from usMeasure
      where HIID = $HIID
        and msID = $msID AND Aid = $Aid) then
      -- Запись была изменена или удалена другим пользователем. Обновите данные без сохраненис и выполните действис еще раз
      call RAISE(77003,NULL);
    end if;
    --
    update usMeasure set
       HIID   = fn_GetStamp()
      , msName = $msName
      , isActive = $isActive
    where msID = $msID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
