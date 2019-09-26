DELIMITER $$
DROP PROCEDURE IF EXISTS prc_UpdEntity;
CREATE PROCEDURE prc_UpdEntity(
   $HIID        bigint
  ,$pfxID       int
  ,$pfxName     varchar(50)
  ,$isActive    bit
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
  if not exists (
    select 1
    from prcEntity
    where HIID = $HIID
      and pfxID = $pfxID) then
    -- Запись была изменена или удалена другим пользователем. Обновите данные без сохранения и выполните действия еще раз
    call RAISE(77003,NULL);
  end if;
  --
  set $CurDate = NOW(3);
  set $CurEmID = fn_GetEmID();
  set $NewHIID = fn_GetStamp();
  --
  update prcEntity set
     HIID      = $NewHIID
    ,pfxName   = $pfxName
    ,isActive  = IFNULL($isActive,0)
    ,EditedAt  = $CurDate
    ,EditedBy  = $CurEmID;
  where pfxID = $pfxID
END $$
DELIMITER ;
--
