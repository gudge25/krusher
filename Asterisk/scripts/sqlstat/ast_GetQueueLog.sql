DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetQueueLog;
CREATE PROCEDURE ast_GetQueueLog(
   $dateFrom date
  ,$dateTo   date
) BEGIN
select
   agent        as agent
  ,queuename    as queuename
  ,count(agent) as count
  ,sum(data1)   as sum
from queue_log
where event = 'CONNECT'
  and time between $dateFrom and $dateTo
group by
   agent
  ,queuename;
END $$
DELIMITER ;
--


