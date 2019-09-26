DROP PROCEDURE IF EXISTS fm_GetFormTypeLookup;
DELIMITER $$
CREATE PROCEDURE fm_GetFormTypeLookup(
    $token          VARCHAR(100)
)
BEGIN
  declare $emID     int;
  declare $emName   varchar(200);
  DECLARE $Aid      INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_GetFormTypeLookup');
  ELSE
    set $emID = fn_GetEmployID($token);
    --
    select
      emName into $emName
    from emEmploy
    where emID = $emID AND Aid = $Aid;
    --
    select
       t.tpID       as tpID
      ,t.tpName     as tpName
      ,t.ffID       as ffID
      ,fs.ffName    as ffName
      ,CONCAT('Добрый день! Меня зовут ', $emName) as tpHint
      ,(select
          ROUND(AVG(i.qiAnswer),2)
        from fmQuestionItem qi
          inner join fmQuestion q on q.qID = qi.qID
          inner join fmFormItem i on i.qiID = qi.qiID
        where q.tpID = t.tpID AND qi.Aid = $Aid
          and CONVERT(i.qiAnswer, SIGNED INTEGER) > 0
          and q.isActive = 1) as QtyAvg
    from fmFormType t
      left outer join fsFile fs on (fs.ffID = t.ffID AND t.ffID>0)
    where t.isActive = 1 AND t.Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
