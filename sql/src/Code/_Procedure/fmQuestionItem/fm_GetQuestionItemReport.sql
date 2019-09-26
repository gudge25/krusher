DROP PROCEDURE IF EXISTS fm_GetQuestionItemReport;
DELIMITER $$
CREATE PROCEDURE fm_GetQuestionItemReport(
    $token              VARCHAR(100)
    , $qID              int
    , $DateFrom         datetime
    , $DateTo           datetime
    , $Step             int
    , $isStepPercent    bit
)
BEGIN
    declare $qtyDoc int;
    DECLARE $Aid            INT;
    --
    SET $token = NULLIF(TRIM($token), '');
    SET $Aid = fn_GetAccountID($token);
    IF ($Aid = -999) THEN
        call RAISE(77068, 'fm_GetQuestionItemReport');
    ELSE
        if ($qID is NULL) then
            -- Параметр "ID записи" должен иметь значение
            call RAISE(77021,NULL);
        end if;
        /*set $DateFrom = DATE_ADD(IFNULL($DateFrom, '2000-01-01'), interval 1 DAY);
        set $DateTo = IFNULL($DateTo, NOW());*/
        set $step = IFNULL($step, 0);
        --
        DROP TABLE IF EXISTS _temp;
        --
        CREATE TEMPORARY TABLE _temp(
            Period VARCHAR(255)  NOT NULL
            , qty    int  NOT NULL
            , PRIMARY KEY(Period)
        )ENGINE=MEMORY;
        --
        insert _temp
        select
            case $step
                when 1 then CONCAT(CONVERT(d.Created,date),' ',HOUR(d.Created),':00:00')
                when 2 then CONVERT(d.Created,date)
                when 3 then WEEK(d.Created)
                when 4 then MONTH(d.Created)
                when 5 then YEAR(d.Created)
                else 0
                end            as Period
             ,COUNT(fiID)    as qtyDoc
        from fmFormItem i
                 inner join dcDoc d on d.dcID = i.dcID
        where qID = $qID AND d.Aid = $Aid
          and d.Created between $dateFrom and $dateTo
        group by
            case $step
                when 1 then HOUR(d.Created)
                when 2 then DAY(d.Created)
                when 3 then WEEK(d.Created)
                when 4 then MONTH(d.Created)
                when 5 then YEAR(d.Created)
                else 0
                end;
        --
        select
            s.qID
             , s.qiAnswer
             , ROUND(s.qty / t.qty * 100, 2) as Percent
             , s.Period
        from (
                 select
                     i.qID
                      , i.qiAnswer
                      , COUNT(i.qiID) as qty
                      , case $step
                           when 1 then CONCAT(CONVERT(d.Created,date),' ',HOUR(d.Created),':00:00')
                           when 2 then CONVERT(d.Created,date)
                           when 3 then WEEK(d.Created)
                           when 4 then MONTH(d.Created)
                           when 5 then YEAR(d.Created)
                           else 0
                     end            as Period
                 from fmFormItem i
                          inner join dcDoc d on d.dcID = i.dcID
                 where i.qID = $qID AND d.Aid = $Aid
                   and d.Created between $dateFrom and $dateTo
                 group by
                     i.qiAnswer
                        , case $step
                             when 1 then HOUR(d.Created)
                             when 2 then DAY(d.Created)
                             when 3 then WEEK(d.Created)
                             when 4 then MONTH(d.Created)
                             when 5 then YEAR(d.Created)
                             else 0
                     end) s inner join _temp t on t.Period = s.Period;
        --
    END IF;
END $$
DELIMITER ;
--
