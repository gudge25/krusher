DELIMITER $$
DROP PROCEDURE IF EXISTS fs_InsTemplateItem;
CREATE PROCEDURE fs_InsTemplateItem (
    $token            VARCHAR(100)
    , $ftiID          int
    , $ftID           int
    , $ftType         int
    , $ColNumber      varchar(200)
    , $ftDelim        varchar(12)
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $pos       int;
  declare $Number    int;
  declare $Col       int;
  declare $ftTypeEx  int;
  declare $Error     varchar(200);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_InsTemplateItem');
  ELSE
    --
    DROP TABLE IF EXISTS __temp;
    CREATE TEMPORARY TABLE __temp(
      ColNumber int PRIMARY KEY
    )ENGINE=MEMORY;
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
    if $ftType = 46
      and exists (
        select 1
        from __temp t
        having COUNT(t.ColNumber) > 1)
    then
      -- Для "Порядковый номер" может быть указана только одна колонка
      call RAISE(77043,NULL);
    end if;
    --
    select
       c.ColNumber
      ,i.ftType
    into
       $Col
      ,$ftTypeEx
    from __temp t
      inner join fsTemplateItemCol c on t.ColNumber = c.ColNumber
      inner join fsTemplateItem i on c.ftiID = i.ftiID
    where i.ftID = $ftID AND i.Aid = $Aid
    limit 1;
    --
    if $Col is NOT NULL then
      select
        CONCAT($Col,' в списке ',`Name`)
      into
        $Error
      from usEnumValue
      where tvID = $ftTypeEx AND Aid = $Aid;
      --
      -- В шаблоне уже указана колонка %s
      call RAISE(77044, $Error);
    end if;
    --
    insert fsTemplateItem (
       ftiID
      ,ftID
      ,ftType
      ,ftDelim
      , isActive
      , Aid
      , HIID
    )
    values (
       $ftiID
      ,$ftID
      ,$ftType
      ,$ftDelim
      , $isActive
      , $Aid
      , fn_GetStamp()
    );
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
