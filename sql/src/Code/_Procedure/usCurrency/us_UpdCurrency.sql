DELIMITER $$
DROP PROCEDURE IF EXISTS us_UpdCurrency;
CREATE PROCEDURE us_UpdCurrency(
   $crID       int
  ,$crName     varchar(4)
  ,$crFullName varchar(25)
  ,$isActive   bit
) DETERMINISTIC MODIFIES SQL DATA
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
  update usCurrency set
     crName     = $crName
    ,crFullName = $crFullName
    ,isActive   = NULLIF($isActive,0)
    ,ChangedBy   = $UserEmID
  where crID = $crID;
END $$
DELIMITER ;
--
