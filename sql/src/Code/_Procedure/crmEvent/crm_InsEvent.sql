DROP PROCEDURE IF EXISTS crm_InsEvent;
DELIMITER $$
CREATE PROCEDURE crm_InsEvent(
   $dcID         int           -- ID документа
  ,$dcNo         varchar(35)   -- Номер документа
  ,$dcDate       date          -- дата документа
  ,$dcLink       int           -- ID документа основания
  ,$dcComment    varchar(200)  -- комментарий
  ,$dcSum        decimal(14,2) -- сумма документа
  ,$dcStatus     int           -- статус документа
  ,$clID         int           -- ID клиента
  ,$emID         int           -- ID владельца
  ,$metaID       int
  ,$title        varchar(200)
  ,$endsAt       datetime
  ,$location     varchar(200)
  ,$repeats      int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  /*declare $HIID     bigint;
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
  set $HIID = fn_GetStamp();
  --
  call dc_IPInsDoc($Aid, $dcID ,9,$dcNo, 0, $dcDate ,$dcLink ,$dcComment ,NULL,$dcStatus ,$clID ,$emID,0, 1);
  --
  insert crmEvent (
     HIID
    ,dcID
    ,metaID
    ,title
    ,endsAt
    ,location
    ,repeats
  )
  values (
     $HIID
    ,$dcID
    ,$metaID
    ,$title
    ,$endsAt
    ,$location
    ,$repeats
  );*/
END $$
DELIMITER ;
--
