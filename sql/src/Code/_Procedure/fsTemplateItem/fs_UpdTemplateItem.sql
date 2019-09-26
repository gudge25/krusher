DELIMITER $$
DROP PROCEDURE IF EXISTS fs_UpdTemplateItem;
CREATE PROCEDURE fs_UpdTemplateItem(
  $HIID           BIGINT
  , $token            VARCHAR(100)
  , $ftiID          int
  , $ftID           int
  , $ftType         int
  , $ColNumber      varchar(200)
  , $ftDelim        varchar(12)
  , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $pos    int;
  declare $Number int;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_UpdTemplateItem');
  ELSE
    DROP TABLE IF EXISTS __temp;
    CREATE TEMPORARY TABLE __temp(
      ColNumber int PRIMARY KEY
    );
    --
    set $pos = 1;
    set $Number = 1;
    while $pos < 50 and $Number > 0 do
      set $Number = CONVERT(NULLIF(fn_SplitStr($ColNumber,',',$pos),''),unsigned);
      if ($Number > 0) then
        insert into __temp values ($Number);
      end if;
      set $pos = $pos + 1;
    end while;
    --
    if not exists (
      select 1
      from fsTemplateItem
      where HIID = $HIID
        and ftiID = $ftiID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update fsTemplateItem set
       ftiID   = $ftiID
      ,ftID    = $ftID
      ,ftType  = $ftType
      ,ftDelim = $ftDelim
      , isActive = $isActive
      , HIID        = fn_GetStamp()
    where ftiID = $ftiID AND Aid = $Aid;
    --
    delete c
    from fsTemplateItemCol c
    where c.ftiID = $ftiID AND Aid = $Aid;
    --
    insert fsTemplateItemCol(
       ftiID
      ,ColNumber
      , isActive
      , Aid
      , HIID)
    select
       $ftiID
      ,ColNumber
      , $isActive
      , $Aid
      , fn_GetStamp()
    from __temp;
  END IF;
END $$
DELIMITER ;
--
