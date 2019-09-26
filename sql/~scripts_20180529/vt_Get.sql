DELIMITER $$
DROP PROCEDURE IF EXISTS vt_Get;
DROP FUNCTION IF EXISTS fn_SplitStr;
--
CREATE FUNCTION fn_SplitStr(
   $str   text
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
CREATE PROCEDURE vt_Get (
  $isActive  bit
) BEGIN
  declare $pos       int;
  declare $sip       varchar(50);
  declare $n         int;
  declare $i         int;
  declare $cf_999    varchar(1000);
  declare $id        int;
  --
  DROP TABLE IF EXISTS _sip;
  CREATE TEMPORARY TABLE _sip(
     id    int         NOT NULL
    ,sip   varchar(50) NOT NULL
  )ENGINE=MEMORY;
  --
  DROP TABLE IF EXISTS _result;
  CREATE TABLE _result(
     id           int             NOT NULL AUTO_INCREMENT
    ,accountname  varchar(100)
    ,cf_999       varchar(1000)
    ,cf_1005      varchar(1000)
    ,accountid    int
    ,PRIMARY KEY(id)
  )ENGINE=MEMORY DEFAULT CHARSET=utf8;
  --
  insert _result (accountname, cf_999, cf_1005,accountid)
  select
     a.accountname
    ,s.cf_999
    ,s.cf_1005
    ,a.accountid
  from vtiger_accountscf s
    left outer join vtiger_account a on a.accountid = s.accountid
  where cf_999 is NOT NULL;
  --
  set $n = ROW_COUNT();
  set $i = 1;
  --
  while $i <= $n do
    select
       id
      ,cf_999
    into
       $id
      ,$cf_999
    from _result
    where id = $i;
    --
    set $pos = 1;
    set $sip = 'sip';
    while $pos < 1000 and $sip is NOT NULL do
      set $sip = NULLIF(TRIM(fn_SplitStr($cf_999,'|##|',$pos)),'');
      if $sip is NOT NULL then
        insert into _sip (id,sip) values ($id,$sip);
      end if;
      set $pos = $pos + 1;
    end while;
    --
    set $i = $i + 1;
  end while;
  --
  if $isActive = 1 then
    select
       r.accountname
      ,r.cf_1005
      ,r.accountid
      ,s.sip
      ,g.pass
    from _result r
      left outer join _sip s on s.id = r.id
      left outer join gsm g on g.lineid = s.sip
    order by s.sip;
  else
    select
       g.lineid
      ,g.pass
    from gsm g
    where not exists (
      select 1
      from _sip
      where sip = g.lineid)
    order by g.lineid;
  end if;
END $$
DELIMITER ;
--
