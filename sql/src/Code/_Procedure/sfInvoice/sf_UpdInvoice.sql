DROP PROCEDURE IF EXISTS sf_UpdInvoice;
DELIMITER $$
CREATE PROCEDURE sf_UpdInvoice(
    $token            VARCHAR(100)
    , $HIID           BIGINT        -- версия
    , $dcID           INT           -- ID документа
    , $dcNo           VARCHAR(35)   -- Номер документа
    , $dcDate         DATE          -- дата документа
    , $dcLink         INT           -- ID документа основания
    , $dcComment      VARCHAR(200)  -- комментарий
    , $dcSum          DECIMAL(14,2) -- сумма документа
    , $dcStatus       INT           -- статус документа
    , $clID           INT           -- ID клиента
    , $emID           INT           -- ID владельца
    , $isActive       BIT
    , $Delivery       VARCHAR(255)  -- адрес доставки
    , $VATSum         DECIMAL(14,2) -- НДС
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sf_UpdInvoice');
  ELSE
    IF $HIID is NULL THEN
      -- Параметр "Версия" должен иметь значение
      CALL RAISE(77034,NULL);
    END IF;
    --
    IF $dcID is NULL THEN
      -- Параметр ID документа должен иметь значение
      CALL RAISE(77001, NULL);
    END IF;
    IF $dcDate is NULL THEN
      -- Параметр "Дата документа" должен иметь значение
      CALL RAISE(77033, NULL);
    END IF;
    IF $clID is NULL THEN
      -- Параметр "ID клинта" должен иметь значение
      CALL RAISE(77004, NULL);
    END IF;
    IF $emID is NULL THEN
      -- Параметр "ID сотрудника" должен иметь значение
      CALL RAISE(77007, NULL);
    END IF;
    --
    IF NOT exists (
      SELECT 1
      FROM sfInvoice
      WHERE HIID = $HIID
        AND dcID = $dcID
        AND Aid = $Aid) THEN
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действие еще раз.
      CALL RAISE(77003,NULL);
    END IF;
    --
    CALL dc_IPUpdDoc($token, $dcID, 5, $dcNo, 0, $dcDate, $dcLink, $dcComment, $dcSum, $dcStatus, $clID, $emID, $isActive);
    UPDATE sfInvoice SET
      HIID        = fn_GetStamp()
      , Delivery = $Delivery
      , VATSum   = $VATSum
      , isActive = $isActive
    WHERE dcID = $dcID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
