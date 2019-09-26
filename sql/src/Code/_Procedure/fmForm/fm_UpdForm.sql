DROP PROCEDURE IF EXISTS fm_UpdForm;
DELIMITER $$
CREATE PROCEDURE fm_UpdForm(
    $token          VARCHAR(100)
    , $HIID         bigint        -- версия
    , $dcID         int           -- ID документа
    , $dcNo         varchar(35)   -- Номер документа
    , $dcDate       date          -- дата документа
    , $dcLink       int           -- ID документа основания
    , $dcComment    varchar(200)  -- комментарий
    , $dcStatus     int           -- статус документа
    , $clID         int           -- ID клиента
    , $emID         int           -- ID владельца
    , $isActive     BIT
    , $tpID         int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_UpdForm');
  ELSE
    if ($HIID is NULL) then
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
      from fmForm
      where HIID = $HIID
        and dcID = $dcID AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    call dc_IPUpdDoc(
      $token
      , $dcID
      ,2
      ,$dcNo
      ,0
      ,$dcDate
      ,$dcLink
      ,$dcComment
      ,NULL -- dcSum
      ,$dcStatus
      ,$clID
      ,$emID
      ,$isActive);
    --
    update fmForm set
      tpID = $tpID
      , isActive = $isActive
    where dcID = $dcID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
