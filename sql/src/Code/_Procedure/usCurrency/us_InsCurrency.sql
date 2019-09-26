DELIMITER $$
DROP PROCEDURE IF EXISTS us_InsCurrency;
CREATE PROCEDURE us_InsCurrency(
   $crID       int
  ,$crName     varchar(4)
  ,$crFullName varchar(25)
  ,$isActive   bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $CurDate  datetime;
  declare $UserEmID int;
  --
  set $crName = NULLIF(TRIM($crName),'');
  set $crFullName = NULLIF(TRIM($crFullName),'');
  --
  if ($crID is NULL) then
    -- Параметр "ID записи" должен иметь значение
    call RAISE(77021,NULL);
  end if;
  if ($crName is NULL or $crFullName is NULL) then
    -- Параметр "Название" должен иметь значение
    call RAISE(77022,NULL);
  end if;
  --
  set $CurDate  = NOW();
  set $UserEmID = fn_GetEmID();
  --
  insert usCurrency (
     crName
    ,crFullName
    ,isActive
    ,CreatedBy
  )
  values (
     $crName
    ,$crFullName
    ,NULLIF($isActive,0)
    ,$UserEmID
  );
END $$
DELIMITER ;
--
