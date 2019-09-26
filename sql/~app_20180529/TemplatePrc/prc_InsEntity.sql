DELIMITER $$
DROP PROCEDURE IF EXISTS prc_InsEntity;
CREATE PROCEDURE prc_InsEntity(
   $pfxID        int
  ,$pfxName      varchar(50)
  ,$isActive     bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $CurDate datetime;
  declare $CurEmID int;
  declare $NewHIID bigint;
  --
  set $pfxName = NULLIF(TRIM($pfxName),'');
  --
  if ($pfxID is NULL) then
    -- Параметр "ID записи" должен иметь значение
    call RAISE(77021,NULL);
  end if;
  if ($pfxName is NULL) then
    -- Параметр "Название" должен иметь значение
    call RAISE(77022,NULL);
  end if;
  --
  set $CurDate = NOW(3);
  set $CurEmID = fn_GetEmID();
  set $NewHIID = fn_GetStamp();
  --
  insert prcEntity (
     HIID
    ,pfxID
    ,pfxName
    ,isActive
    ,CreatedAt
    ,CreatedBy
  )
  values (
     $NewHIID
    ,$pfxID
    ,$pfxName
    ,IFNULL($isActive,0)
    ,$CurDate
    ,$CurEmID
  );
  --
END $$
DELIMITER ;
--
