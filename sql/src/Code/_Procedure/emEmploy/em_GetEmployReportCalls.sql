DROP PROCEDURE IF EXISTS em_GetEmployReportCalls;
DELIMITER $$
CREATE PROCEDURE em_GetEmployReportCalls(
   $dateFrom    date
  ,$dateTo      date
) BEGIN
  --
  declare $diff int;
  declare $i    int;
  CREATE TEMPORARY TABLE _temp (
     step     date        NOT NULL
    ,name     varchar(30) NOT NULL
    ,PRIMARY KEY(step)
  )ENGINE=MEMORY;
  --
  set $dateFrom = IFNULL($dateFrom,CURDATE() - INTERVAL 50 DAY);
  set $dateTo = IFNULL($dateTo,$dateFrom + INTERVAL 50 DAY);
  set $diff = DATEDIFF($dateTo,$dateFrom);
  --
  set $i = 0;
  while $i <= $diff do
    insert _temp (step, name)
    values($dateFrom + INTERVAL $i DAY, DAYNAME($dateFrom + INTERVAL $i DAY));
    set $i = $i + 1;
  end while;
  --
  select
     e.emID        as emID
    ,e.emName      as emName
    -- ,CONCAT('[',GROUP_CONCAT(CONCAT(
    --       '{ "step": "',t.step,'", ',
    --         '"qtyDial": ',IFNULL(d.qtyDial,'null'),' }') order by t.step asc separator ',')
    --   ,']') as items
    ,CONCAT('[',GROUP_CONCAT(CONCAT(
          '{ "',t.step,'": ',IFNULL(cl.qtyDial,'null'),' }') order by t.step asc separator ',')
      ,']') as items
  from emEmploy e
    cross join _temp t
    left outer join (
      select
         DATE(Changed)   as step
        ,COUNT(clID)      as qtyDial
        ,ChangedBy         as emID
      from crmClient
      where Changed between $dateFrom and $dateTo
        and ActualStatus = 101101
        and isActual = 1
      group by DATE(crmClient)) cl on (cl.step = t.step and cl.emID = e.emID)
  where e.isActive = 1
  group by e.emID;
END $$
DELIMITER ;
--
