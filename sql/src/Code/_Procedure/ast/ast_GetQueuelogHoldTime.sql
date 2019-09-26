DROP PROCEDURE IF EXISTS ast_GetQueuelogHoldTime;
DELIMITER $$
CREATE PROCEDURE ast_GetQueuelogHoldTime(
  $queuename varchar(20)
) BEGIN
  declare $CurDate datetime default NOW();
  --
  select
     agent                   as Agent
    ,$CurDate - MAX(created) as HoldTime
  from ast_queuelog
  where event in ('COMPLETEAGENT','COMPLETECALLER')
    and queuename = $queuename
  group by agent;
  --
  select
    CONVERT(AVG(s.HoldTime),int) as `IWT`
  from (
    select
       $CurDate - MAX(created) as HoldTime
    from ast_queuelog
    where event in ('COMPLETEAGENT','COMPLETECALLER')
      and queuename = $queuename
    group by agent) s;
END $$
DELIMITER ;
--
