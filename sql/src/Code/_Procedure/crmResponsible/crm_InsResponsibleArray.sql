DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsResponsibleArray;
CREATE PROCEDURE crm_InsResponsibleArray (
      $clID       INT
      , $arrEmID  VARCHAR(200)
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  /*declare $pos       int;
  declare $Number    int;
  declare $CurDate   datetime;
  --
  DROP TABLE IF EXISTS __temp;
  CREATE TEMPORARY TABLE __temp(
    emID int PRIMARY KEY
  )ENGINE=MEMORY;
  --
  set $pos = 1;
  set $Number = 1;
  while $pos < 50 and $Number > 0 do
    set $Number = CONVERT(NULLIF(fn_SplitStr($arrEmID,',',$pos),''),unsigned);
    if ($Number > 0)
      and not exists (
        select 1
        from __temp
        where emID = $Number) then
      insert into __temp values ($Number);
    end if;
    set $pos = $pos + 1;
  end while;
  --
  delete c from crmResponsible c
  where c.clID = $clID;
  --
  call us_IPGetNextID('crID',@row);
  set @row := @row - 1;
  set $CurDate = NOW();
  --
  insert crmResponsible (
     crID
    ,emID
    ,clID
    ,CreatedAt
  )
  select
     @row := @row + 1
    ,emID
    ,$clID
    ,$CurDate
  from __temp;
  --
  if ROW_COUNT() > 0 then
    update usSequence s
      set s.seqValue = @row
    where s.seqName = 'crID';
  end if;*/
END $$
DELIMITER ;
--
