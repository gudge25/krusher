DELIMITER $$
DROP PROCEDURE IF EXISTS dc_IPUpdDoc;
CREATE PROCEDURE dc_IPUpdDoc(
    $token          VARCHAR(100)
    , $dcID         int           -- ID документа
    , $dctID        tinyint       -- ID тип документа
    , $dcNo         varchar(35)   -- Номер документа
    , $dcState      smallint      -- состояние документа
    , $dcDate       date          -- дата документа
    , $dcLink       int           -- ID документа основания
    , $dcComment    varchar(200)  -- комментарий
    , $dcSum        decimal(14,2) -- сумма документа
    , $dcStatus     int           -- статус документа
    , $clID         int           -- ID клиента
    , $emID         int           -- ID владельца
    , $isActive     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $emID int;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_IPUpdDoc');
  ELSE
    SET $emID = fn_GetEmployID($token);
    if $dcID is NULL then
      -- Параметр ID документа должен иметь значение
      call RAISE(77001, NULL);
    end if;
    if $dctID is NULL then
      -- Параметр "ID тип документа" должен иметь значение
      call RAISE(77002, NULL);
    end if;
    if $dcState is NULL then
      -- Параметр "Состояние документа" должен иметь значение
      call RAISE(77032, NULL);
    end if;
    if $dcDate is NULL then
      -- Параметр "Дата документа" должен иметь значение
      call RAISE(77033, NULL);
    end if;
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение
      call RAISE(77004, NULL);
    end if;
    if $emID is NULL then
      -- Параметр "ID сотрудника" должен иметь значение
      call RAISE(77007, NULL);
    end if;
    --
    set $dcNo = NULLIF(TRIM($dcNo),'');
    --
    update dcDoc set
      dcNo          = $dcNo
      , dcState     = $dcState
      , dcDate      = $dcDate
      , dcLink      = $dcLink
      , dcComment   = $dcComment
      , dcSum       = $dcSum
      , dcStatus    = $dcStatus
      , clID        = $clID
      , emID        = $emID
      , ChangedBy   = $emID
      , isActive    = $isActive
    where dcID = $dcID
      and dctID = $dctID
      AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
