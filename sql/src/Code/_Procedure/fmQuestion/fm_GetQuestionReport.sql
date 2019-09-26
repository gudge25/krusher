DROP PROCEDURE IF EXISTS fm_GetQuestionReport;
DELIMITER $$
CREATE PROCEDURE fm_GetQuestionReport(
    $token          VARCHAR(100)
    , $tpID         int
    , $DateFrom     datetime
    , $DateTo       datetime
    , $Step         int
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_GetQuestionReport');
  ELSE
    if ($tpID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    /*set $DateFrom = DATE_ADD(IFNULL($DateFrom, '2000-01-01'), INTERVAL 1 DAY);
    set $DateTo = IFNULL((STR_TO_DATE($dateTo, '%Y-%m-%d') + INTERVAL 24 HOUR),NOW());*/
    set $step = IFNULL($step, 0);
    --
    select
      q.tpID        as tpID
      , q.qID         as qID
      , q.qName       as qName
      , ROUND(AVG(i.qiAnswer),2) as QtyAvg
      , COUNT(i.qiAnswer) as QtyAnswer
      , case $step
          when 1 then CONCAT(CONVERT(d.Created,date),' ',HOUR(d.Created),':00:00')
          when 2 then CONVERT(d.Created,date)
          when 3 then WEEK(d.Created)
          when 4 then MONTH(d.Created)
          when 5 then YEAR(d.Created)
          else 0
        end            as Period
       , q.isActive
    from fmQuestion q
      left outer join fmFormItem i on i.qID = q.qID
      left outer join dcDoc d on d.dcID = i.dcID
    where q.tpID = $tpID
      and q.isActive = 1
      and d.Created between $dateFrom and $dateTo
      AND q.Aid = $Aid
    group by
      q.tpID
      , q.qID
      , q.qName
      , case $step
          when 1 then HOUR(d.Created)
          when 2 then DAY(d.Created)
          when 3 then WEEK(d.Created)
          when 4 then MONTH(d.Created)
          when 5 then YEAR(d.Created)
          else 0
         end;
  END IF;
END $$
DELIMITER ;
--
