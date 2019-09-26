DELIMITER $$
DROP PROCEDURE IF EXISTS sl_IPInsDeal;
CREATE PROCEDURE sl_IPInsDeal(
  $token            VARCHAR(100)
  , $dcID           int           -- ID документа
  , $dcNo           varchar(35)   -- Номер документа
  , $dcDate         date          -- дата документа
  , $dcLink         int           -- ID документа основания
  , $dcComment      varchar(200)  -- комментарий
  , $dcSum          decimal(14,2) -- сумма документа
  , $dcStatus       int           -- статус документа
  , $clID           int           -- ID клиента
  , $emID           int           -- ID владельца
  , $HasDocNo       varchar(35)   -- номер официального документа
  , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $isHasDoc            BIT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sl_IPInsDeal');
  ELSE
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
    set $HasDocNo = NULLIF(TRIM($HasDocNo),'');
    set $isHasDoc = IF($HasDocNo is NOT NULL,1,0);
    --
    call dc_IPInsDoc($Aid, $dcID, 2, $dcNo, 0, $dcDate, $dcLink, $dcComment, $dcSum, $dcStatus, $clID, $emID, 0, $isActive);
    --
    insert slDeal (
       HIID
      ,dcID
      ,isHasDoc
      ,HasDocNo
      , isActive
      , Aid
    )
    values (
      fn_GetStamp()
      , $dcID
      , $isHasDoc
      , $HasDocNo
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
