DELIMITER $$
DROP PROCEDURE IF EXISTS dc_IPInsDoc;
CREATE PROCEDURE dc_IPInsDoc(
    $Aid            INT
    , $dcID         int           -- ID документа
    , $dctID        tinyint       -- ID тип документа
    , $dcNo         varchar(35)   -- Номер документа
    , $dcState      smallint      -- состояние документа
    , $dcDate       date          -- дата документа
    , $dcLink       int           -- ID документа основания
    , $dcComment    varchar(200)  -- комментарий
    , $dcSum        decimal(14, 2)-- сумма документа
    , $dcStatus     int           -- статус документа
    , $clID         int           -- ID клиента
    , $emID         int           -- ID владельца
    , $pcID         int           -- ID профитцентра
    , $isActive     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $ffID             INT;
  IF ($Aid < 1) THEN
    call RAISE(77068, 'dc_IPInsDoc');
  ELSE
    if $dcID is NULL then
      -- Параметр ID документа должен иметь значение
      call raise(77001, NULL);
    end if;
    if $dctID is NULL then
      -- Параметр "ID тип документа" должен иметь значение
      call raise(77002, NULL);
    end if;
    if $dcState is NULL then
      -- Параметр "Состояние документа" должен иметь значение
      call raise(77032, NULL);
    end if;
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение
      call raise(77004, NULL);
    end if;
    if $emID is NULL then
      -- Параметр "ID сотрудника" должен иметь значение
      call raise(77007, NULL);
    end if;
    if $pcID is NULL then
      -- Параметр "ID профитцентра" должен иметь значение
      call raise(77006, NULL);
    end if;
    --
    if $clID IS NULL OR $clID = 0 then
      SET $ffID = 0;
    ELSE
      SELECT ffID
      INTO $ffID
      FROM crmClient
      WHERE clID = $clID AND Aid = $Aid
      LIMIT 1;
      SET $ffID    = IFNULL($ffID, 0);
    end if;
    --
    set $dcNo = NULLIF(TRIM($dcNo), '');
    --
    insert into dcDoc (
      HIID
      , dcID
      , dctID
      , dcNo
      , dcState
      , dcDate
      , dcLink
      , dcComment
      , dcSum
      , dcStatus
      , clID
      , emID
      , pcID
      , Aid
      , CreatedBy
      , isActive
      , uID
      , ffID
    )
    values (
      fn_GetStamp()
      , $dcID
      , $dctID
      , $dcNo
      , $dcState
      , $dcDate
      , $dcLink
      , $dcComment
      , $dcSum
      , $dcStatus
      , $clID
      , $emID
      , $pcID
      , $Aid
      , $emID
      , $isActive
      , UUID_SHORT()
      , $ffID
    );
  END IF;
END $$
DELIMITER ;
--
