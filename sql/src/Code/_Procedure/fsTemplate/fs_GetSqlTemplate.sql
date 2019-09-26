DROP PROCEDURE IF EXISTS fs_GetSqlTemplate;
DELIMITER $$
CREATE PROCEDURE fs_GetSqlTemplate (
    $token            VARCHAR(100)
    , $ftID           int
    , $ffID           int
    , $ffPath         varchar(500)
    , $ffName         varchar(200)
    , $dbID           int
)
BEGIN
  declare $sql        text;
  declare $colTable   text;
  declare $colSel     text;
  declare $colIns     text;
  declare $colIsNot   text;
  declare $colSelCl   text;
  declare $colSelCom  text;
  declare $colSelCc   text;
  declare $colFile    varchar(100);
  declare $from       varchar(100);
  declare $sn         int;
  declare $n          int;
  declare $i          int;
  declare $ColNumber  int;
  declare $delimiter  char(1);
  declare $CurDate    datetime;
  declare $Encoding   varchar(32);
  declare $CompanyID  int;
  declare $ShortName  int;
  declare $TaxCode    int;
  declare $KVED       int;
  declare $KVEDName   int;
  declare $Address    int;
  declare $isPerson   bit;
  declare $headPost   int;
  declare $headFIO    int;
  declare $headFam    int;
  declare $headIO     int;
  declare $headSex    int;
  declare $phoneCode  int;
  declare $timeZone   int;
  declare $ActDate    int;
  declare $Operator   int;
  declare $curID      int;
  declare $langID     int;
  declare $sum        int;
  declare $ttsText    int;
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_GetSqlTemplate');
  ELSE
    if exists (
      select 1
      from fsTemplateItem t
        inner join fsTemplateItemCol c on c.ftiID = t.ftiID
      where t.ftID = $ftID AND c.Aid = $Aid
      group by c.ColNumber
      having COUNT(c.ColNumber) > 1)
    then
      -- Неправильно оформлен шаблон для загрузки файлов
      call RAISE(77045, NULL);
    end if;
    --
    SET group_concat_max_len = 10000;
    SET max_heap_table_size =  167772160;
    SET tmp_table_size =  167772160;
    --
    set $sql = CONCAT(
    'DROP TABLE IF EXISTS _temp_', $Aid,';
    CREATE TEMPORARY TABLE  _temp_', $Aid,' (
      %colTbl%
    )ENGINE=MyISAM;
    --
    DROP TABLE IF EXISTS _draft_', $Aid, ';
    CREATE TEMPORARY TABLE _draft_', $Aid, ' (
      fclID  int  NOT NULL,
      Aid  int  NOT NULL,
      %colTbl%,
      PRIMARY KEY (fclID),
      INDEX `Aid` (`Aid`)
    )ENGINE=MyISAM;
    --
    LOAD DATA INFILE ''%filePath%''
    INTO TABLE _temp_',$Aid, '
    CHARACTER SET %encoding%
    COLUMNS TERMINATED BY ''%delimiter%''
    ENCLOSED BY ''~'';
    --
    insert into _draft_', $Aid, '(
      Aid, fclID,
      %colIns%
    )
    select distinct
    ', $Aid, ',
    /*us_GetNextSequence("fclID"), 11 04 2019*/
    NEXTVAL(fclID),
    %colSel%
    from _temp_', $Aid, '
    where %colIsNot%;
    --
    insert fsFile (
        ffID
        , ffName
        , Priority
        , isActive
        , dbID
        , Aid
        , HIID
    )
    values (
      %ffID%
      , %ffName%
      , 0
      , 1
      , %dbID%
      , ', $Aid, '
      , fn_GetStamp()
    );
    --
    insert into fsClient (
      fclID
      , sn
      , fclName
      , ffID
      , isPerson
      , Comments
      , TaxCode
      , ShortName
      , CompanyID
      , timeZone
      , isActive
      , Aid
      , langID
      , curID
      , sum
      , ttsText
    )
    select
      fclID
      , sn
      , fclName
      , ffID
      , isPerson
      , Comments
      , TaxCode
      , ShortName
      , CompanyID
      , timeZone
      , 1
      , ', $Aid,'
      , langID
      , curID
      , `sum`
      , ttsText
    from (
      select
        %colSelCl%
      from _draft_', $Aid, ') c;
    --
    insert into fsContact (
      fclID
      , fccName
      , ftType
      , ftDelim
      , Aid
      , isActive
    )
    select
      fclID
      , fccName
      , ftType
      , ftDelim
      , ', $Aid, '
      , 1
    from (%colSelCc%) c
    where c.fccName is NOT NULL
      and exists (
        select 1
        from fsClient
        where fclID = c.fclID AND Aid = ', $Aid, ');');
    --
    select
       delimiter
      ,Encoding
      ,isPerson
    into
       $delimiter
      ,$Encoding
      ,$isPerson
    from fsTemplate ft
    where ft.ftID = $ftID AND ft.Aid = $Aid;
    --
    select
      MAX(fti1.ColNumber)
    into $n
    from fsTemplateItem fti
      inner join fsTemplateItemCol fti1 on fti.ftiID = fti1.ftiID
    where fti.ftID = $ftID AND fti.Aid = $Aid;
    --
    set $colTable = '';
    if($delimiter IS NULL) THEN
      SET $delimiter = ';';
    END IF;
    set $colSel = '';
    set $colIsNot = '';
    set $colIns = '';
    set $i = 1;
    while ($i <= $n) do
      set $colTable = CONCAT($colTable,if ($i = 1, 'col', '  col'), $i, ' ', 'varchar(200) NULL DEFAULT NULL', if($i = $n, '', CONCAT(',', CHAR(10))));
      set $colIns = CONCAT($colIns,if ($i = 1,'col','  col'),$i,if($i = $n,'',CONCAT(',',CHAR(10))));
      set $colSel = CONCAT($colSel,if ($i = 1,'NULLIF(TRIM(REPLACE(col','  NULLIF(TRIM(REPLACE(col'),$i,',CHAR(13),'''')),'''')',if($i = $n,'',CONCAT(',',CHAR(10))));
      set $colIsNot = CONCAT($colIsNot,if ($i = 1,'NULLIF(TRIM(REPLACE(col','  or NULLIF(TRIM(REPLACE(col'),$i,',CHAR(13),'''')),'''') is NOT NULL',CHAR(10));
      set $i = $i + 1;
    end while;
    --
    -- названиe колонок для имени клиента
    select
      GROUP_CONCAT(CONCAT('IFNULL(TRIM(col',j.ColNumber,'),'''')') order by j.ColNumber asc separator ','' '',')
    into $colSelCl
    from fsTemplateItem i
      inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID
      and i.ftType = 45
      AND i.Aid = $Aid
    group by i.ftType;
    --
    -- названиe колонок для комментария
    select
      GROUP_CONCAT(CONCAT('IFNULL(TRIM(col',j.ColNumber,'),'''')') order by j.ColNumber asc separator ','' '',')
    into $colSelCom
    from fsTemplateItem i
      inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID
      and i.ftType = 56
      AND i.Aid = $Aid
    group by i.ftType;
    --
    select j.ColNumber into $sn
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 46 AND i.Aid = $Aid;
    --
    select j.ColNumber into $TaxCode
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 57 AND i.Aid = $Aid;
    --
    select j.ColNumber into $ShortName
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 59 AND i.Aid = $Aid;
    --
    select j.ColNumber into $CompanyID
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 60 AND i.Aid = $Aid;
    --
    select j.ColNumber into $timeZone
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 72 AND i.Aid = $Aid;
    --
    select j.ColNumber into $curID
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 75 AND i.Aid = $Aid;
    --
    select j.ColNumber into $langID
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 76 AND i.Aid = $Aid;
    --
    select j.ColNumber into $sum
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 77 AND i.Aid = $Aid;
    --
    select j.ColNumber into $ttsText
    from fsTemplateItem i inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID and i.ftType = 78 AND i.Aid = $Aid;
    --
    -- определяем номера колонок для типов контакта
    set $from = CONCAT(CHAR(10),' from _draft_', $Aid, ' d');
    select
      GROUP_CONCAT(CONCAT(CHAR(10)
        ,'select fclID, '
        ,CONCAT('NULLIF(LEFT(TRIM(col',j.ColNumber,'), 250), '''') as fccName, ')
        ,CONCAT(
          case i.ftType
            when 47 then 36
            when 48 then 37
            when 49 then 38
            when 50 then 39
            when 51 then 40
            when 52 then 41
            when 53 then 42
            when 54 then 43
            when 55 then 44
            else 0
          end,' as ftType, ')
        ,CONCAT(IFNULL(QUOTE(i.ftDelim),'NULL'), ' as ftDelim ')
        ,$from)
        order by j.ColNumber asc separator ' UNION ALL ')
    into $colSelCc
    from fsTemplateItem i
      inner join fsTemplateItemCol j on j.ftiID = i.ftiID
    where i.ftID = $ftID
       AND i.Aid = $Aid
      and i.ftType between 47 and 55;
    --
    set $colSelCl = CONCAT(
      'fclID as fclID, '
      ,if($sn is NULL, 'NULL', CONCAT('NULLIF(TRIM(col',$sn,'),'''')'))
      ,' as sn, IFNULL(NULLIF(TRIM(CONCAT(',$colSelCl,')),''''),''noname'') as fclName, '
      ,$ffID,' as ffID, '
      ,IFNULL($isPerson,0),' as isPerson, '
      ,if($colSelCom is NULL, 'NULL', CONCAT('NULLIF(TRIM(CONCAT(',$colSelCom,')),'''')')),' as Comments, '
      ,if($TaxCode is NULL, 'NULL', CONCAT('NULLIF(TRIM(col',$TaxCode,'),'''')')),' as TaxCode, '
      ,if($ShortName is NULL, 'NULL', CONCAT('NULLIF(TRIM(col',$ShortName,'),'''')')),' as ShortName, '
      ,if($CompanyID is NULL, 'NULL', CONCAT('NULLIF(TRIM(col',$CompanyID,'),'''')')),' as CompanyID, '
      ,if($timeZone is NULL, 'NULL', CONCAT('NULLIF(TRIM(col',$timeZone,'),'''')')),' as timeZone, '
      ,if($curID is NULL, 'NULL', CONCAT('(SELECT tvID FROM usEnumValue WHERE `Name` = NULLIF(TRIM(col',$curID,'),'''') AND Aid IN (0, ', $Aid, ') ORDER BY Aid DESC LIMIT 1)')),' as curID, '
      ,if($langID is NULL, 'NULL', CONCAT('(SELECT tvID FROM usEnumValue WHERE `Name` = NULLIF(TRIM(col',$langID,'),'''') AND Aid IN (0, ', $Aid, ') ORDER BY Aid DESC LIMIT 1)')),' as langID, '
      ,if($sum is NULL, 'NULL', CONCAT('NULLIF(TRIM(col',$sum,'),'''')')),' as `sum`, '
      ,if($ttsText is NULL, 'NULL', CONCAT('NULLIF(TRIM(col',$ttsText,'),'''')')),' as ttsText '
    );
    --
    set $sql = REPLACE($sql, '%colIns%', IFNULL($colIns,''));
    set $sql = REPLACE($sql, '%colSelCl%', IFNULL($colSelCl,''));
    set $sql = REPLACE($sql, '%colSelCc%', IFNULL($colSelCc,''));
    set $sql = REPLACE($sql, '%colTbl%', IFNULL($colTable,''));
    set $sql = REPLACE($sql, '%colSel%', IFNULL($colSel,''));
    set $sql = REPLACE($sql, '%colIsNot%', IFNULL($colIsNot,''));
    set $sql = REPLACE($sql, '%filePath%', $ffPath);
    set $sql = REPLACE($sql, '%delimiter%', $delimiter);
    set $sql = REPLACE($sql, '%encoding%', $Encoding);
    set $sql = REPLACE($sql, '%ffID%', $ffID);
    set $sql = REPLACE($sql, '%ffName%', CONCAT('''',$ffName,''''));
    set $sql = REPLACE($sql, '%dbID%', CONCAT('''',$dbID,''''));
    --
    select $sql Value;
  END IF;
END $$
DELIMITER ;
--
