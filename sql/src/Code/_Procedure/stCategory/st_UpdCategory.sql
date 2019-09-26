DELIMITER $$
DROP PROCEDURE IF EXISTS st_UpdCategory;
CREATE PROCEDURE st_UpdCategory (
    $HIID             BIGINT
    ,$token          VARCHAR(100)
    , $pctID        int
    , $pctName      varchar(50)
    , $ParentID     int
    , $isActive     bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'st_UpdCategory');
  ELSE
    set $pctName = NULLIF(TRIM($pctName),'');
    --
    if ($pctID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($pctName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    --
    if not exists (
      select 1
      from stCategory
      where HIID = $HIID
        and pctID = $pctID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update stCategory set
      pctName     = $pctName
      , ParentID  = $ParentID
      , isActive  = $isActive
      , HIID        = fn_GetStamp()
    where pctID = $pctID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
