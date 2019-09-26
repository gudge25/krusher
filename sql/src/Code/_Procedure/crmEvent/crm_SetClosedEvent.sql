DROP PROCEDURE IF EXISTS crm_SetClosedEvent;
DELIMITER $$
CREATE PROCEDURE crm_SetClosedEvent(
   $dcID  int   -- ID документа
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  /*declare $HIID     bigint;
  declare $UserEmID int;
  declare $CurDate  datetime;
  --
  if $dcID is NULL then
    -- Параметр ID документа должен иметь значение
    call raise(77001, NULL);
  end if;
  --
  set $HIID     = fn_GetStamp();
  set $UserEmID = fn_GetEmID();
  set $CurDate  = NOW();
  --
  update dcDoc set
     ChangedBy = $UserEmID
    ,Changed = $CurDate
  where dcID = $dcID;
  --
  update crmEvent set
     HIID     = $HIID
    ,isClosed = true
  where dcID = $dcID;*/
END $$
DELIMITER ;
--
