DROP PROCEDURE IF EXISTS crm_UpdEvent;
DELIMITER $$
CREATE PROCEDURE crm_UpdEvent(
   $HIID         bigint        -- версия
  ,$dcID         int           -- ID документа
  ,$dcNo         varchar(35)   -- Номер документа
  ,$dcDate       date          -- дата документа
  ,$dcLink       int           -- ID документа основания
  ,$dcComment    varchar(200)  -- комментарий
  ,$dcStatus     int           -- статус документа
  ,$clID         int           -- ID клиента
  ,$emID         int           -- ID владельца
  ,$metaID       int
  ,$title        varchar(200)
  ,$endsAt       datetime
  ,$location     varchar(200)
  ,$repeats      int
  ,$isClosed     bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  /*if $HIID is NULL then
    -- Параметр "Версия" должен иметь значение
    call RAISE(77034,NULL);
  end if;
  --
  if $dcID is NULL then
    -- Параметр ID документа должен иметь значение
    call raise(77001, NULL);
  end if;
  if $dcDate is NULL then
    -- Параметр "Дата документа" должен иметь значение
    call raise(77033, NULL);
  end if;
  if $clID is NULL then
    -- Параметр "ID клинта" должен иметь значение
    call raise(77004, NULL);
  end if;
  if $emID is NULL then
    -- Параметр "ID сотрудника" должен иметь значение
    call raise(77007, NULL);
  end if;
  --
  if not exists (
    select 1
    from crmEvent
    where HIID = $HIID
      and dcID = $dcID) then
    -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
    call RAISE(77003,NULL);
  end if;
  --
  call dc_IPUpdDoc($token, $dcID ,9,$dcNo, 0, $dcDate ,$dcLink ,$dcComment ,NULL ,$dcStatus ,$clID ,$emID, 1);
  set $HIID = fn_GetStamp();
  --
  update crmEvent set
     HIID     = $HIID
    ,metaID   = $metaID
    ,title    = $title
    ,endsAt   = $endsAt
    ,location = $location
    ,repeats  = $repeats
    ,isClosed = IFNULL($isClosed,false)
  where dcID = $dcID;*/
END $$
DELIMITER ;
--
