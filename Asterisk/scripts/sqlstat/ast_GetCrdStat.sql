DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetCdrStat;
DROP FUNCTION IF EXISTS fn_SplitStr;
CREATE FUNCTION fn_SplitStr(
   $str   varchar(255)
  ,$delim varchar(12)
  ,$pos   int
) RETURNS varchar(255)
BEGIN
  declare $Result varchar(255);
  --
  set $Result = REPLACE(SUBSTRING(SUBSTRING_INDEX($str, $delim, $pos)
                  ,LENGTH(SUBSTRING_INDEX($str, $delim, $pos -1)) + 1)
                  ,$delim, '');
  --
  RETURN $Result;
END $$
--
CREATE PROCEDURE ast_GetCdrStat(
   $dateFrom date
  ,$dateTo   date
  ,$sipout   varchar(1000)
)
BEGIN
  declare $pos       int;
  declare $Number    varchar(50);
  --
  DROP TABLE IF EXISTS _Sip;
  CREATE TABLE _Sip(
    sip varchar(50) PRIMARY KEY
  )ENGINE=MEMORY;
  --
  set $pos = 1;
  set $Number = 1;
  while $pos < 50 and $Number > 0 do
    set $Number = NULLIF(fn_SplitStr($sipout,',',$pos),'');
    if ($Number > 0) then
      insert into _Sip values ($Number);
    end if;
    set $pos = $pos + 1;
  end while;
  --
  select *
    ,DATE_FORMAT(calldate,'%d %b %H:%i') AS nicedate
    ,duration - billsec as servicelevel
  from cdr
  where calldate between  $dateFrom and $dateTo
    and not exists (
      select 1
      from _Sip
      where src = sip)
    and not exists (
      select 1
      from _Sip
      where dst = sip)
    and dst not in ('h');
  --
  DROP TABLE _Sip;
END $$
DELIMITER ;
--


