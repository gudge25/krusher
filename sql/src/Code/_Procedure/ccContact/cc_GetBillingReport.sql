DROP PROCEDURE IF EXISTS cc_GetBillingReport;
DELIMITER $$
CREATE PROCEDURE cc_GetBillingReport(
    $token          VARCHAR(100)
    , $dateTo       DATETIME
)
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_GetBillingReport');
  ELSE
    select
      c.channel          as `Номер тел.вход`
      ,CONVERT(DATE(d.Created),char(10))  as `Дата поступления звонка`
      ,TIME(d.Created)  as `Время поступления звонка`
      ,c.ccName           as `Номер тел. звонящего`
      ,0                  as `Время пребывания IVR`
      ,0                  as `Выбор IVR`
      ,c.serviceLevel     as `Длительность ожидания соединения (в очереди)`
      ,v.Name             as `Результат звонка`
      ,c.holdtime         as `ringing time`
      ,0                  as `hold`
      ,c.billsec          as `Длительность разговора`
      ,c.duration         as `Общая длительность звонка`
      ,20                 as `Wrap-Up Time`
      ,c.SIP              as `Оператор`
    from ccContact c
      inner join dcDoc d on d.dcID = c.dcID
      inner join emEmploy em on em.emID = d.emID
      left outer join usEnumValue v on v.tvID = d.dcStatus
    where d.dcDate = $dateTo
      and c.IsOut = 0 AND c.Aid = $Aid;
    --
    select
      CONVERT(DATE(d.Created),char(10))  as `Дата поступления звонка`
      ,TIME(d.Created)  as `Время поступления звонка`
      ,c.channel          as `Номер тел.вход`
      ,if(c.isAutocall = 1,'autocall', 'by hand') as `Направление звонка`
      ,c.ccName           as `Номер тел. Абонента`
      ,c.serviceLevel     as `Длительность ожидания ответа`
      ,v.Name             as `Результат звонка`
      ,c.billsec          as `Длительность разговора`
      ,0                  as `hold`
      ,c.duration         as `Общая длительность звонка`
      ,20                 as `Wrap-Up Time`
      ,c.SIP              as `Оператор`
    from ccContact c
      inner join dcDoc d on d.dcID = c.dcID
      inner join emEmploy em on em.emID = d.emID
      left outer join usEnumValue v on v.tvID = d.dcStatus
    where d.dcDate = $dateTo
      and c.IsOut = 1 AND c.Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
