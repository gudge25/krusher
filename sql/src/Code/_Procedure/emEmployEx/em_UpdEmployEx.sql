DELIMITER $$
DROP PROCEDURE IF EXISTS em_UpdEmployEx;
CREATE PROCEDURE em_UpdEmployEx(
    $token          VARCHAR(100)
    , $HIID         BIGINT
    , $emID         int
    , $Settings     varchar(8000)
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_UpdEmployEx');
  ELSE
    if $emID is NULL then
      -- Параметр "ID сотрудника" должен иметь значение
      call RAISE(77007,NULL);
    end if;
    set $Settings = NULLIF(TRIM($Settings),'');
    --
    if not exists (
      select 1
      from emEmployEx
      where HIID = $HIID
        and emID = $emID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update emEmployEx set
       emID     = $emID
      ,Settings = $Settings
      , isActive = $isActive
      , HIID        = fn_GetStamp()
    where emID = $emID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
