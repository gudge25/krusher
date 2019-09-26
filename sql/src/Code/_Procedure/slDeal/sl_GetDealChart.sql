DROP PROCEDURE IF EXISTS sl_GetDealChart;
DELIMITER $$
CREATE PROCEDURE sl_GetDealChart(
    $token            VARCHAR(100)
    , $clID           int
    , $dcStatus       int
)
BEGIN
  declare $Count decimal(14,4);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sl_GetDealChart');
  ELSE
    DROP TABLE IF EXISTS Items;
    CREATE TEMPORARY TABLE Items (
       psID   int             NOT NULL
      ,psName varchar(1020)   NOT NULL
      ,qty    decimal(14,4)   NOT NULL
    )ENGINE=MEMORY;
    --
    insert Items
    select distinct
       i.psID         as psID
      ,i.psName       as psName
      ,SUM(i.iQty)    as iQty
    from dcDoc d
      inner join slDeal sl on sl.dcID = d.dcID
      inner join slDealItem i on i.dcID = sl.dcID
    where d.clID = $clID
      and (d.dcStatus = $dcStatus or $dcStatus is NULL)
      AND d.Aid = $Aid
    group by i.psID, i.psName;
    --
    select
      SUM(qty) into $Count
    from Items;
    --
    select
       i.psID         as psID
      ,i.psName       as psName
      ,i.qty          as qty
      ,ROUND(i.qty / $Count * 100,2) as Percent
    from Items i;
  END IF;
END $$
DELIMITER ;
--
