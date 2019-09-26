DELIMITER $$
DROP PROCEDURE IF EXISTS cdr_active;
DROP FUNCTION IF EXISTS fn_GetNumberByString;
--
CREATE FUNCTION fn_GetNumberByString (
  $str varchar(200)
) RETURNS VARCHAR(50)
BEGIN
  declare $len  tinyint unsigned;
  declare $res  varchar(50);
  declare $i    tinyint unsigned;
  declare $char char;
  --
  set $str = NULLIF(TRIM($str),'');
  if $str is NOT NULL
  then
    set $len = LENGTH($str);
    set $res = '';
    set $i = 1;
    while $i <= $len
    do
      set $char = SUBSTRING($str,$i,1);
      if (ASCII($char) between 48 and 57)
      then
        set $res = CONCAT($res,$char);
      end if;
      --
      set $i = $i + 1;
    end while;
    --
    if SUBSTRING($res,1,2) = '89'
    then
      set $res = CONCAT('7',RIGHT($res,LENGTH($res)-1));
    elseif SUBSTRING($res,1,4) = '3800' and LENGTH($res) = 13 then
      set $res = CONCAT('380',RIGHT($res,LENGTH($res)-4));
    end if;
    --
  end if;
  --
  RETURN NULLIF(LEFT($res,50),'');
END $$
--
CREATE PROCEDURE cdr_active()
BEGIN
<<<<<<< HEAD
  declare $CurDate datetime;
  --
  set $CurDate = CURDATE() - INTERVAL 0 DAY;
  --
  DROP TABLE IF EXISTS _cdr;
  CREATE TEMPORARY TABLE _cdr (
     src      varchar(50)
    ,calldate datetime
  )ENGINE=MEMORY;
  --
  DROP TABLE IF EXISTS _result;
  CREATE TEMPORARY TABLE _result (
     num         int
    ,src         varchar(80)
    ,calldate    datetime
    ,dst         varchar(80)
    ,channel     varchar(80)
    ,dstchannel  varchar(80)
    ,lastdata    varchar(80)
    ,disposition varchar(45)
    ,duration    int
  )ENGINE=MEMORY;
  --
  insert _cdr(src,calldate)
  select
     src
    ,calldate
  from cdr
  where disposition = 'ANSWERED'
    and calldate >= $CurDate
  UNION ALL
  select
     fn_GetNumberByString(dst)
    ,calldate
  from cdr
  where disposition = 'ANSWERED'
    and calldate >= $CurDate
  UNION ALL
  select
     fn_GetNumberByString(lastdata)
    ,calldate
  from cdr
  where disposition = 'ANSWERED'
    and calldate >= $CurDate;
  --
  set @src = '';
  insert _result(num, src,calldate, dst,duration,disposition ,dstchannel ,channel ,lastdata)
  select
     (if(@src = c.src, @row := @row + 1, @row := 1)) as num
    ,(@src := c.src) as src
    ,calldate
    ,dst
    ,duration
    ,disposition
    ,dstchannel
    ,channel
    ,lastdata
   from (
     select
       src
      ,calldate
      ,dst
      ,duration
      ,disposition
      ,dstchannel
      ,channel
      ,lastdata
    from asteriskcdrdb.cdr as c
    where LENGTH(src) > 6
      and disposition != 'ANSWERED'
      and calldate >= $CurDate
      and not exists (
        select 1
        from _cdr
        where src = c.src
          and calldate > c.calldate)
    order by c.calldate desc) c;
  --
  select *
    ,DATE_FORMAT(calldate,'%d %b %H:%i') AS nicedate
  from _result
  where num = 1;
END $$
DELIMITER ;
--
