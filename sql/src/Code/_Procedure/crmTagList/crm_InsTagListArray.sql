DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsTagListArray;
CREATE PROCEDURE crm_InsTagListArray (
    $token          VARCHAR(100)
    , $clID         INT
    , $arrTagID     VARCHAR(200)
    , $isActive     INT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $pos       int;
  declare $Number    int;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsTagListArray');
  ELSE
    DROP TABLE IF EXISTS __temp;
    CREATE TEMPORARY TABLE __temp(
      tagID int PRIMARY KEY
    )ENGINE=MEMORY;
    --
    set $pos = 1;
    set $Number = 1;
    while $pos < 50 and $Number > 0 do
      set $Number = CONVERT(NULLIF(fn_SplitStr($arrTagID, ',', $pos), ''), unsigned);
      if ($Number > 0)
        and not exists (
          select 1
          from __temp
          where tagID = $Number) then
        insert into __temp values ($Number);
      end if;
      set $pos = $pos + 1;
    end while;
    --
    delete c from crmTagList c
    where c.clID = $clID AND Aid = $Aid;
    --
    /*call us_IPGetNextID('ctgID', @row); 03 04 2019
    set @row := @row - 1;*/
    --
    insert crmTagList (
      ctgID
      , tagID
      , clID
      , Aid
      , isActive
      , HIID
    )
    select
      /*@row := @row + 1 03 04 2019*/
      /*us_GetNextSequence("ctgID")   11 04 2019*/
        NEXTVAL(ctgID)
      , tagID
      , $clID
      , $Aid
      , $isActive
      , fn_GetStamp()
    from __temp;
    --
    /*if ROW_COUNT() > 0 then 03 04 2019
      update usSequence s
        set s.seqValue = @row
      where s.seqName = 'ctgID';
    end if;*/
  END IF;
END $$
DELIMITER ;
--
