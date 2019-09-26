/*
DROP TABLE IF EXISTS _temp;
DROP TABLE IF EXISTS _draft;
CREATE TEMPORARY TABLE  _temp (
  col1 varchar(200),
  col2 varchar(200),
  col3 varchar(200),
  col4 varchar(200),
  col5 varchar(200),
  col6 varchar(200)
)ENGINE=MEMORY;
--
DROP TABLE IF EXISTS _draft;
CREATE TABLE _draft (
  fclID  int  NOT NULL,
  col1 varchar(200),
  col2 varchar(200),
  col3 varchar(200),
  col4 varchar(200),
  col5 varchar(200),
  col6 varchar(200),
  PRIMARY KEY (fclID)
)ENGINE=MEMORY;
--
LOAD DATA LOCAL INFILE 'C:/Users/dima/Documents/crmua/sql/other/baza4000.csv'
INTO TABLE _temp
CHARACTER SET cp1251
COLUMNS TERMINATED BY ';';
--
set @row = 0;
call us_IPGetNextID('fclID',@row);
--
insert into _draft(
fclID,
col1,
  col2,
  col3,
  col4,
  col5,
  col6
)
select distinct
(@row:=@row + 1) as fclID,
NULLIF(TRIM(REPLACE(col1,CHAR(13),'')),''),
  NULLIF(TRIM(REPLACE(col2,CHAR(13),'')),''),
  NULLIF(TRIM(REPLACE(col3,CHAR(13),'')),''),
  NULLIF(TRIM(REPLACE(col4,CHAR(13),'')),''),
  NULLIF(TRIM(REPLACE(col5,CHAR(13),'')),''),
  NULLIF(TRIM(REPLACE(col6,CHAR(13),'')),'')
from _temp
where NULLIF(TRIM(REPLACE(col1,CHAR(13),'')),'') is NOT NULL
  or NULLIF(TRIM(REPLACE(col2,CHAR(13),'')),'') is NOT NULL
  or NULLIF(TRIM(REPLACE(col3,CHAR(13),'')),'') is NOT NULL
  or NULLIF(TRIM(REPLACE(col4,CHAR(13),'')),'') is NOT NULL
  or NULLIF(TRIM(REPLACE(col5,CHAR(13),'')),'') is NOT NULL
  or NULLIF(TRIM(REPLACE(col6,CHAR(13),'')),'') is NOT NULL
;
--
insert fsFile (
  ffID
 ,ffName)
values (
   -1
  ,'baza4000'
);
--
insert into fsClient (
   fclID
  ,sn
  ,fclName
  ,ffID)
select
   fclID
  ,sn
  ,fclName
  ,ffID
from (
  select
    fclID as fclID, NULLIF(TRIM(col1),'') as sn, IFNULL(NULLIF(TRIM(CONCAT(IFNULL(TRIM(col2),''))),''),'noname') as fclName, -1 as ffID
  from _draft) c;
--
insert into fsContact (
   fclID
  ,fccName
  ,ftType
)
select
   fclID
  ,fccName
  ,ftType
from (
select fclID, fn_GetNumberByString(col3) as fccName, 36 as ftType
 from _draft d UNION ALL
select fclID, NULLIF(LEFT(TRIM(col6),50),'') as fccName, 37 as ftType
 from _draft d) c
where c.fccName is NOT NULL
  and exists (
    select 1
    from fsClient
    where fclID = c.fclID);
--
update usSequence set
  seqValue = @row
where seqName = 'fclID';
--
call fs_InsFile(-1);
--
DROP TABLE IF EXISTS _draft;
*/
